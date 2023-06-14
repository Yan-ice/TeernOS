
use super::{
    frame_alloc,
    nkapi_vun_getpt, nkapi_dealloc, nkapi_alloc,
    nkapi_translate, nkapi_translate_va, frame_dealloc,
};
use crate::shared::*;
use crate::config::*;


use alloc::{vec::Vec, boxed::Box};
use bitflags::*;
use spin::Mutex;
use crate::debug_info;

impl PhysPageNum{
    pub fn get_pte_array(&self) -> &'static mut [PageTableEntry] {
        let pa: PhysAddr = self.clone().into();
        unsafe {
            core::slice::from_raw_parts_mut(pa.0 as *mut PageTableEntry, 512)
        }
    }
}

#[derive(Copy, Clone)]
#[repr(C)]
pub struct PageTableEntry {
    pub bits: usize,
}



impl PageTableEntry {
    pub fn new(ppn: PhysPageNum, flags: PTEFlags) -> Self {
        PageTableEntry {
            bits: ppn.0 << 10 | flags.bits() as usize,
        }
    }
    pub fn empty() -> Self {
        PageTableEntry {
            bits: 0,
        }
    }
    pub fn ppn(&self) -> PhysPageNum {
        (self.bits >> 10 & ((1usize << 44) - 1)).into()
    }
    pub fn flags(&self) -> PTEFlags {
        PTEFlags::from_bits(self.bits as u8).unwrap()
    }
    pub fn is_valid(&self) -> bool {
        (self.flags() & PTEFlags::V) != PTEFlags::empty()
    }
    pub fn readable(&self) -> bool {
        (self.flags() & PTEFlags::R) != PTEFlags::empty()
    }
    pub fn writable(&self) -> bool {
        (self.flags() & PTEFlags::W) != PTEFlags::empty()
    }
    pub fn executable(&self) -> bool {
        (self.flags() & PTEFlags::X) != PTEFlags::empty()
    }
    pub fn set_flags(&mut self, flags: PTEFlags) {
        let new_flags: u8 = flags.bits().clone();
        self.bits = (self.bits & 0xFFFF_FFFF_FFFF_FF00) | (new_flags as usize);
    }

    // the 9th flag is used as COW flag.
    pub fn set_cow(&mut self) {
        (*self).bits = self.bits | (1 << 9);
    }
    pub fn reset_cow(&mut self) {
        (*self).bits = self.bits & !(1 << 9);
    }
    pub fn is_cow(&self) -> bool {
        self.bits & (1 << 9) != 0
    }
    pub fn set_bits(&mut self, ppn: PhysPageNum, flags: PTEFlags) {
        self.bits = ppn.0 << 10 | flags.bits() as usize;
    }
    // only X+W+R can be set
    pub fn set_pte_flags(&mut self, flags: usize) {
        self.bits = (self.bits & !(0b1110 as usize)) | ( flags & (0b1110 as usize));
    }

}


#[derive(Copy, Clone)]
pub struct PageTable {
    pt_id: usize,
    root_ppn: PhysPageNum,
}

pub struct PageTableRecord {
    pt_id: usize,
    root_ppn: PhysPageNum,
    frames: Vec<PhysPageNum>
}

impl From<&PageTableRecord> for PageTable{
    fn from(pt: &PageTableRecord) -> Self {
        PageTable {
            pt_id: pt.pt_id,
            root_ppn: pt.root_ppn
        }
    }
}
impl From<&mut PageTableRecord> for PageTable{
    fn from(pt: &mut PageTableRecord) -> Self {
        PageTable {
            pt_id: pt.pt_id,
            root_ppn: pt.root_ppn
        }
    }
}

impl PageTable {
    pub fn id(&self) -> usize{
        return self.pt_id;
    }
    pub fn token(&self) -> usize {
        8usize << 60 | self.root_ppn.0
    }
}

/// Assume that it won't oom when creating/mapping.
impl PageTableRecord {
    pub fn id(&self) -> usize{
        return self.pt_id;
    }
    
    pub fn new(id: usize) -> Self {
        let ppn = frame_alloc().unwrap();
        PageTableRecord {
            pt_id: id,
            root_ppn: ppn,
            frames: Vec::new(),
        }
    }
    pub fn destroy(mut self){
        for mapped_frame in self.frames.into_iter(){
            frame_dealloc(mapped_frame);
        }
        self.pt_id = usize::MAX;
        self.root_ppn = 0.into();
    }

    fn find_pte_create(&mut self, vpn: VirtPageNum) -> Option<&mut PageTableEntry> {
        let idxs = vpn.indexes();
        let mut ppn = self.root_ppn;
        let mut result: Option<&mut PageTableEntry> = None;
        for i in 0..3 {
            let pte = &mut ppn.get_pte_array()[idxs[i]];
            if i == 2 {
                result = Some(pte);
                break;
            }
            if !pte.is_valid() {
                // debug_info!("index i {}", idxs[i]);
                // debug_info!{"invalid!!!!!!!!"}
                // debug_info!("i {}", i);
                // debug_info!("root ppn {:x}", self.root_ppn.0);
                // debug_info!("vpn is {:x}", vpn.0);
                let ppn = frame_alloc().unwrap();
                // debug_info!("ppn is {:x}", ppn.0);
                *pte = PageTableEntry::new(ppn, PTEFlags::V);
                self.frames.push(ppn);
                
            }
            ppn = pte.ppn();
        }
        result

    }
    fn find_pte(&self, vpn: VirtPageNum) -> Option<&PageTableEntry> {
        let idxs = vpn.indexes();
        let mut ppn = self.root_ppn;
        let mut result: Option<&PageTableEntry> = None;
        for i in 0..3 {
            let pte = &ppn.get_pte_array()[idxs[i]];
            if !pte.is_valid() {
                return None;
            }
            if i == 2 {
                result = Some(pte);
                break;
            }
            ppn = pte.ppn();
        }
        result
    }

    // level = {1,2,3}
    pub fn find_pte_level(&self, vpn:VirtPageNum, level:usize) -> Option<&PageTableEntry> {
        let idxs = vpn.indexes();
        let mut ppn = self.root_ppn;
        let mut result: Option<&PageTableEntry> = None;
        for i in 0..(level) {
            let pte = &ppn.get_pte_array()[idxs[i]];
            if !pte.is_valid() {
                return None;
            }
            if i == (level -1) {
                result = Some(pte);
                break;
            }
            ppn = pte.ppn();
        }
        result
    }
    
    // only X+W+R can be set
    // return -1 if find no such pte
    pub fn set_pte_flags(&mut self, vpn: VirtPageNum, flags: usize) -> isize{
        let idxs = vpn.indexes();
        let mut ppn = self.root_ppn;
        for i in 0..3 {
            let pte = &mut ppn.get_pte_array()[idxs[i]];
            if i == 2 {
                // if pte == None{
                //     panic!("set_pte_flags: no such pte");
                // }
                // else{
                    pte.set_pte_flags(flags);
                // }
                break;
            }
            if !pte.is_valid() {
                return -1;
            }
            ppn = pte.ppn();
        }
        0
    }

    pub fn trace_address(&mut self, va: VirtAddr){
        let vpn = va.floor();

        let idxs = vpn.indexes();
        let mut ppn = self.root_ppn;
        let mut result: Option<&PageTableEntry> = None;
        print!("Tracing translation:");

        for i in 0..3 {
            print!("{:x}[{}] -> ", ppn.0, i);
            let pte = &ppn.get_pte_array()[idxs[i]];
            
            if !pte.is_valid() {
                debug_info!("INVALID");
                return;
            }
            if i == 2 {
                debug_info!("{:x}", pte.ppn().0);
                break;
            }
            ppn = pte.ppn();
        }
        debug_info!("Trace finished. {:?} -> {:?}", va, self.translate_va(va));
    }

    pub fn print_pagetable(&mut self, from: usize, to:usize){
        debug_info!("[pt] printing pagetable with token {:x}",self.token());

        let idxs = [0 as usize;3];
        let mut ppns = [PhysPageNum(0);3];
        ppns[0] = self.root_ppn;
        for i in 0..512{
            // debug_info!("[pt] printing progress ({}/512)",i);
            let pte = &mut ppns[0].get_pte_array()[i];
            if !pte.is_valid(){
                continue;
            }
            ppns[1] = pte.ppn();
            for j in 0..512{
                let pte = &mut ppns[1].get_pte_array()[j];
                if !pte.is_valid(){
                    continue;
                }
                ppns[2] = pte.ppn();
                for k in 0..512{
                    let pte = &mut ppns[2].get_pte_array()[k];
                    if !pte.is_valid(){
                        continue;
                    }
                    let va = ((((i<<9)+j)<<9)+k)<<12 ;
                    let pa = pte.ppn().0 << 12 ;
                    let flags = pte.flags();
                    if va < from || va > to {
                        continue;
                    }
                    debug_info!("va:0x{:x}  pa:0x{:x} flags:{:?}",va,pa,flags);
                }
            }
        }
    }
    
    #[allow(unused)]
    pub fn map(&mut self, vpn: VirtPageNum, ppn: PhysPageNum, flags: PTEFlags) {
        let pte = self.find_pte_create(vpn).unwrap();
        assert!(!pte.is_valid(), "vpn {:?} is mapped before mapping", vpn);
        *pte = PageTableEntry::new(ppn, flags | PTEFlags::V);
    }
    #[allow(unused)]
    pub fn remap_cow(&mut self, vpn: VirtPageNum, ppn: PhysPageNum, former_ppn: PhysPageNum) {
        let pte = self.find_pte_create(vpn).unwrap();
        // debug_info!{"remapping {:?}", 
        *pte = PageTableEntry::new(ppn, pte.flags() | PTEFlags::W);
        pte.set_cow();
        ppn.get_bytes_array().copy_from_slice(former_ppn.get_bytes_array());
    }
    #[allow(unused)]
    pub fn unmap(&mut self, vpn: VirtPageNum) {
        let pte = self.find_pte_create(vpn).unwrap();
        assert!(pte.is_valid(), "vpn {:?} is invalid before unmapping", vpn);
        *pte = PageTableEntry::empty();
    }
    pub fn translate(&self, vpn: VirtPageNum) -> Option<PageTableEntry> {
        let p = self.find_pte(vpn)
            .map(|pte| {pte.clone()});
        p
    }
    pub fn translate_va(&self, va: VirtAddr) -> Option<PhysAddr> {
        if let Some(pte) = self.find_pte(va.clone().floor()) {
            if pte.is_valid() {
                let pa: PhysAddr = PhysAddr{0: pte.ppn().0*crate::config::PAGE_SIZE + va.page_offset()};
                return Some(pa);
            }
        }
        None
        
    }
    pub fn set_cow(&mut self, vpn: VirtPageNum) {
        self.find_pte_create(vpn).unwrap().set_cow();
    }
    pub fn reset_cow(&mut self, vpn: VirtPageNum) {
        self.find_pte_create(vpn).unwrap().reset_cow();
    }
    pub fn set_flags(&mut self, vpn: VirtPageNum, flags: PTEFlags) {
        self.find_pte_create(vpn).unwrap().set_flags(flags);
    }

    // WARNING: This is a very naive version, which may cause severe errors when "config.rs" is changed
    pub fn map_kernel_shared(&mut self, kernel_pagetable: &mut PageTableRecord){
 
        debug_info!("kernel shared: PPN 0x80000 ~ PPN 0xb0000");

        // insert shared pte of from kernel
        let kernel_vpn:VirtPageNum = (NKSPACE_START / PAGE_SIZE).into();
        let pte_kernel = kernel_pagetable.find_pte_level(kernel_vpn, 1);
        let idxs = kernel_vpn.indexes();
        let mut ppn = self.root_ppn;
        let pte = &mut ppn.get_pte_array()[idxs[0]];
        *pte = *pte_kernel.unwrap();

        // insert top va(kernel stack + trampoline)
        let kernel_vpn:VirtPageNum = (TRAMPOLINE / PAGE_SIZE).into();
        let pte_kernel = kernel_pagetable.find_pte_level(kernel_vpn, 1);
        let idxs = kernel_vpn.indexes();
        let mut ppn = self.root_ppn;
        let pte = &mut ppn.get_pte_array()[idxs[0]];
        *pte = *pte_kernel.unwrap();

        let kernel_vpn:VirtPageNum = 0xb0000.into();
        let idxs = kernel_vpn.indexes();

        // Yan_ice: TODO: problems about MMIO mapping.
        // It maps level 1 PTE (0x0 ~ 0x2000000) instead of level 3, which cause mistake.

        //insert MMIO (assert that each MMIO length is one PAGE)
        for pair in MMIO {
            let page_num = pair.0 / PAGE_SIZE;
            self.map(page_num.into(), page_num.into(), PTEFlags::R | PTEFlags::W);
            // let kernel_vpn:VirtPageNum = (pair.0 / PAGE_SIZE).into();
            // let idxs = kernel_vpn.indexes();
            // let mut ppn = self.root_ppn;
            // for i in 0..3 {
            //     let pte = &mut ppn.get_pte_array()[idxs[i]];
            //     if !pte.is_valid() {
            //         let pte_kernel = kernel_pagetable.find_pte_level(kernel_vpn, i+1);
            //         *pte = *pte_kernel.unwrap();
            //         break;
            //     }
            //     ppn = pte.ppn();
            // }
        }
        
    }

    //Yan_ice： 这个是satp！
    pub fn token(&self) -> usize {
        8usize << 60 | self.root_ppn.0
    }


}


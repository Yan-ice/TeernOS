use super::memory_set::outerkernel_pt;
use super::{
    frame_alloc_raw,
    PhysPageNum,
    VirtPageNum,
    VirtAddr,
    PhysAddr,
    StepByOne,
    pt_get,
};
use crate::config::*;
use crate::task::{current_user_token, current_task};
use alloc::vec::Vec;
use alloc::string::String;
use bitflags::*;

bitflags! {
    pub struct PTEFlags: u8 {
        const V = 1 << 0;
        const R = 1 << 1;
        const W = 1 << 2;
        const X = 1 << 3;
        const U = 1 << 4;
        const G = 1 << 5;
        const A = 1 << 6;
        const D = 1 << 7;
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
            bits: ppn.0 << 10 | flags.bits as usize,
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
        self.bits = ppn.0 << 10 | flags.bits as usize;
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
    //frames: Vec<PhysPageNum>,
}

/// Assume that it won't oom when creating/mapping.
impl PageTable {
    pub fn id(&self) -> usize{
        return self.pt_id;
    }
    pub fn new(id: usize) -> Self {
        let ppn = frame_alloc_raw().unwrap();
        PageTable {
            pt_id: id,
            root_ppn: ppn,
            //frames: vec![ppn],
        }
    }

    /// Temporarily used to get arguments from user space.
    pub fn from_id(id: usize) -> Self {
        if let Some(pt) = super::pt_get(id) {
            return pt;
        }else{
            super::nkapi_pt_init(id);
            return PageTable::from_id(id);
        }
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
                // println!{"invalid!!!!!!!!"}
                let ppn = frame_alloc_raw().unwrap();
                *pte = PageTableEntry::new(ppn, PTEFlags::V);
                //self.frames.push(ppn);
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



    pub fn print_pagetable(&mut self){
        println!("[pt] printing pagetable {:x}",self.token());

        let idxs = [0 as usize;3];
        let mut ppns = [PhysPageNum(0);3];
        ppns[0] = self.root_ppn;
        for i in 0..512{
            println!("[pt] printing progress ({}/512)",i);
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
                    println!("va:0x{:X}  pa:0x{:X} flags:{:?}",va,pa,flags);
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
        // println!{"remapping {:?}", 
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
        self.find_pte(vpn)
            .map(|pte| {pte.clone()})
    }
    pub fn translate_va(&self, va: VirtAddr) -> Option<PhysAddr> {
        if let Some(pte) = self.find_pte(va.clone().floor()) {
            if pte.is_valid() {
                let pa: PhysAddr = PhysAddr{0: pte.ppn().0 + va.page_offset()};
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
    pub fn map_kernel_shared(&mut self){
        let kernel_pagetable = outerkernel_pt();
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
        // insert MMIO (assert that each MMIO length is one PAGE)
        for pair in MMIO {
            let kernel_vpn:VirtPageNum = (pair.0 / PAGE_SIZE).into();
            let idxs = kernel_vpn.indexes();
            let mut ppn = self.root_ppn;
            for i in 0..3 {
                let pte = &mut ppn.get_pte_array()[idxs[i]];
                if !pte.is_valid() {
                    let pte_kernel = kernel_pagetable.find_pte_level(kernel_vpn, i+1);
                    *pte = *pte_kernel.unwrap();
                    break;
                }
                ppn = pte.ppn();
            }
        }
        
        
    }

    //Yan_ice： 这个是satp！
    pub fn token(&self) -> usize {
        8usize << 60 | self.root_ppn.0
    }


}


/// 直接读取指定长度的字节串数据。
pub fn translated_raw(pt_handle: usize, ptr: *const u8, len: usize) -> Vec<&'static mut [u8]> {
    if let Some(page_table) = pt_get(pt_handle){
        let mut start = ptr as usize;
        let end = start + len;
        let mut v = Vec::new();
        while start < end {
            let start_va = VirtAddr::from(start);
            let mut vpn = start_va.floor();
            //println!("tbb vpn = 0x{:X}", vpn.0);
            // let ppn: PhysPageNum;
            if page_table.translate(vpn).is_none() {
                // println!{"preparing into checking lazy..."}
                //println!("check_lazy 3");
                current_task().unwrap().check_lazy(start_va, true);
                unsafe {
                    llvm_asm!("sfence.vma" :::: "volatile");
                    llvm_asm!("fence.i" :::: "volatile");
                }
                //println!{"preparing into checking lazy..."}
            }
            let ppn = page_table
                .translate(vpn)
                .unwrap()
                .ppn();
            //println!("vpn = {} ppn = {}", vpn.0, ppn.0);
            vpn.step();
            let mut end_va: VirtAddr = vpn.into();
            end_va = end_va.min(VirtAddr::from(end));
            if end_va.page_offset() == 0 {
                v.push(&mut ppn.get_bytes_array()[start_va.page_offset()..]);
            } else {
                v.push(&mut ppn.get_bytes_array()[start_va.page_offset()..end_va.page_offset()]);
            }
            start = end_va.into();
        }
        return v;
    }
    panic!("Unknown pagetable handle index.");
}

/// 读取一个字符串（遇到\0为止）
pub fn translated_str(pt_handle: usize, ptr: *const u8) -> String {
    if let Some(page_table) = pt_get(pt_handle) {
        let mut string = String::new();
        let mut va = ptr as usize;
        loop {
            let ch: u8 = *(page_table.translate_va(VirtAddr::from(va)).unwrap().get_mut());
            if ch == 0 {
                break;
            }
            string.push(ch as char);
            va += 1;
        }
        return string;
    }
    panic!("Unknown pagetable handle index.");
}

///读一个指定类型数据，获取其只读引用。
pub fn translated_ref<T>(pt_handle: usize, ptr: *const T) -> &'static T{
    if let Some(page_table) = pt_get(pt_handle) {
        return page_table.translate_va(VirtAddr::from(ptr as usize)).unwrap().get_ref();
    }
    panic!("Unknown pagetable handle index.");
}

///读一个指定类型数据，获取其mutable引用。
pub fn translated_refmut<T>(pt_handle: usize, ptr: *mut T) -> &'static mut T {
    if let Some(page_table) = pt_get(pt_handle){
        let va = ptr as usize;
        let vaddr = VirtAddr::from(va);
        if page_table.translate_va(vaddr).is_none() {
            // println!{"preparing into checking lazy..."}
            //println!("check_lazy 2");
            current_task().unwrap().check_lazy(vaddr,true);
            unsafe {
                llvm_asm!("sfence.vma" :::: "volatile");
                llvm_asm!("fence.i" :::: "volatile");
            }
        }
        let pa = page_table.translate_va(VirtAddr::from(vaddr));
        // print!("[translated_refmut pa:{:?}]",pa);
        return pa.unwrap().get_mut()
    }
    panic!("Unknown pagetable handle index.");
}

///读取一个指定类型数据，获取其复制。
/// T必须是可以复制的类型。
pub fn translated_refcopy<T>(pt_handle: usize, ptr: *mut T) -> T where T:Copy {
    if let Some(page_table) = pt_get(pt_handle){
        let mut va = ptr as usize;
        let size = core::mem::size_of::<T>();
        //println!("step = {}, len = {}", step, len);
        
        let u_buf = UserBuffer::new( translated_raw(pt_handle, va as *const u8, size) );
        let mut bytes_vec:Vec<u8> = Vec::new();
        u_buf.read_as_vec(&mut bytes_vec, size);
        //println!("loop, va = 0x{:X}, vec = {:?}", va, bytes_vec);
        unsafe{
            return *(bytes_vec.as_slice() as *const [u8] as *const u8 as usize as *const T);
        }
    }
    panic!("Unknown pagetable handle index.");
}


fn trans_to_bytes<T>(ptr: *const T)->&'static[u8]{
    let size = core::mem::size_of::<T>();
    unsafe {
        core::slice::from_raw_parts(
            ptr as usize as *const u8,
            size,
        )
    }
}

fn trans_to_bytes_mut<T>(ptr: *mut T)->&'static mut [u8]{
    let size = core::mem::size_of::<T>();
    unsafe {
        core::slice::from_raw_parts_mut(
            ptr as usize as *mut u8,
            size,
        )
    }
}

/**
 * 进行memcopy。
 */
pub fn copy_object<T>(src: *const T, dst: *mut T) {
    let token = current_user_token();
    let size = core::mem::size_of::<T>();
    // translated_ 实际上完成了地址合法检测
    let buf = UserBuffer::new(translated_raw(token, src as *const u8, size));
    let mut dst_bytes = trans_to_bytes_mut(dst);
    buf.read(dst_bytes);
}

pub fn copy_array<T>(src: *const T, dst: *mut T, len: usize) {
    let token = current_user_token();
    let size = core::mem::size_of::<T>();
    // translated_ 实际上完成了地址合法检测
    let buf = UserBuffer::new(translated_raw(token, src as *const u8, size*len));
    let mut dst_bytes = trans_to_bytes_mut(dst);
    buf.read(dst_bytes);
}


pub struct UserBuffer {
    pub buffers: Vec<&'static mut [u8]>,
}

impl UserBuffer {
    pub fn new(buffers: Vec<&'static mut [u8]>) -> Self {
        Self { buffers }
    }

    pub fn empty()->Self{
        Self {
            buffers:Vec::new(),
        }
    }
     
    pub fn len(&self) -> usize {
        let mut total: usize = 0;
        for b in self.buffers.iter() {
            total += b.len();
        }
        total
    }

    // 将一个Buffer的数据写入UserBuffer，返回写入长度
    pub fn write(&mut self, buff: &[u8])->usize{
        let len = self.len().min(buff.len());
        let mut current = 0;
        for sub_buff in self.buffers.iter_mut() {
            let sblen = (*sub_buff).len();
            for j in 0..sblen {
                (*sub_buff)[j] = buff[current];
                current += 1;
                if current == len {
                    return len;
                }
            }
        }
        return len;
    }

    pub fn clear( &mut self ){
        for sub_buff in self.buffers.iter_mut() {
            let sblen = (*sub_buff).len();
            for j in 0..sblen {
                (*sub_buff)[j] = 0;
            }
        }
    }

    pub fn write_at(&mut self, offset:usize, buff: &[u8])->isize{
        let len = buff.len();
        if offset + len > self.len() {
            return -1
        }
        let mut head = 0; // offset of slice in UBuffer
        let mut current = 0; // current offset of buff
    
        for sub_buff in self.buffers.iter_mut() {
            let sblen = (*sub_buff).len();
            if head + sblen < offset {
                continue;
            } else if head < offset {
                for j in (offset - head)..sblen {
                    (*sub_buff)[j] = buff[current];
                    current += 1;
                    if current == len {
                        return len as isize;
                    }
                }
            } else {  //head + sblen > offset and head > offset
                for j in 0..sblen {
                    (*sub_buff)[j] = buff[current];
                    current += 1;
                    if current == len {
                        return len as isize;
                    }
                }
            }
            head += sblen;
        }
    
        //for b in self.buffers.iter_mut() {
        //    if offset > head && offset < head + b.len() {
        //        (**b)[offset - head] = char;
        //        //b.as_mut_ptr()
        //    } else {
        //        head += b.len();
        //    }
        //}
        0
    }

    // 将UserBuffer的数据读入一个Buffer，返回读取长度
    pub fn read(&self, buff:&mut [u8])->usize{
        let len = self.len().min(buff.len());
        let mut current = 0;
        for sub_buff in self.buffers.iter() {
            let sblen = (*sub_buff).len();
            for j in 0..sblen {
                buff[current] = (*sub_buff)[j];
                current += 1;
                if current == len {
                    return len;
                }
            }
        }
        return len;
    }

    // TODO: 把vlen去掉    
    pub fn read_as_vec(&self, vec: &mut Vec<u8>, vlen:usize)->usize{
        let len = self.len();
        let mut current = 0;
        for sub_buff in self.buffers.iter() {
            let sblen = (*sub_buff).len();
            for j in 0..sblen {
                vec.push( (*sub_buff)[j] );
                current += 1;
                if current == len {
                    return len;
                }
            }
        }
        return len;
    }

   
}

impl IntoIterator for UserBuffer {
    type Item = *mut u8;
    type IntoIter = UserBufferIterator;
    fn into_iter(self) -> Self::IntoIter {
        UserBufferIterator {
            buffers: self.buffers,
            current_buffer: 0,
            current_idx: 0,
        }
    }
}

pub struct UserBufferIterator {
    buffers: Vec<&'static mut [u8]>,
    current_buffer: usize,
    current_idx: usize,
}

impl Iterator for UserBufferIterator {
    type Item = *mut u8;
    fn next(&mut self) -> Option<Self::Item> {
        if self.current_buffer >= self.buffers.len() {
            None
        } else {
            let r = &mut self.buffers[self.current_buffer][self.current_idx] as *mut _;
            if self.current_idx + 1 == self.buffers[self.current_buffer].len() {
                self.current_idx = 0;
                self.current_buffer += 1;
            } else {
                self.current_idx += 1;
            }
            Some(r)
        }
    }
}
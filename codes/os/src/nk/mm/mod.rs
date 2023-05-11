mod heap_allocator;
mod address;
mod frame_allocator;
mod page_table;
pub(crate) mod memory_set;
mod vma;

use alloc::sync::Arc;
use lazy_static::*;
use spin::Mutex;

use alloc::vec::Vec;
use riscv::register::satp;

pub use address::{PhysAddr, VirtAddr, PhysPageNum, VirtPageNum, StepByOne, VPNRange};
pub use frame_allocator::{
    FrameTracker, 
    outer_frame_alloc,
    outer_frame_alloc_raw, 
    outer_frame_dealloc,
    add_free, 
    print_free_pages, 
    outer_print_free_pages, 
    frame_add_ref, 
    enquire_refcount
};

//nk内部的就不暴露啦
use frame_allocator::{
    frame_alloc_raw
};

pub use page_table::{
    PageTable,
    PageTableEntry,
    translated_raw,
    translated_str,
    translated_ref,
    translated_refmut,
    translated_refcopy,
    copy_object,
    copy_array,
    UserBuffer,
    UserBufferIterator,
    PTEFlags
};

pub use vma::{MmapArea, MmapSpace};
pub use memory_set::{MemorySet, KERNEL_SPACE, OUTER_KERNEL_SPACE,KERNEL_MMAP_AREA, KERNEL_TOKEN, kernel_token};
pub use memory_set::remap_test;
pub use heap_allocator::HEAP_ALLOCATOR;
pub use frame_allocator::FRAME_ALLOCATOR;

use crate::config::*;
extern "C" {
    fn stext();
    fn etext();
    fn srodata();
    fn erodata();
    fn sdata();
    fn edata();
    fn sbss_with_stack();
    fn ebss();
    fn ekernel();
    fn strampoline();
    fn ssignaltrampoline();
    fn snktrampoline();
}

#[derive(Copy, Clone, PartialEq, Debug)]
pub enum MapType {
    Identical,
    Framed,
    FramedInNK
}

bitflags! {
    pub struct MapPermission: u8 {
        const R = 1 << 1;
        const W = 1 << 2;
        const X = 1 << 3;
        const U = 1 << 4;
    }
    
}
impl MapPermission{
    pub fn flags(self) -> PTEFlags{
        PTEFlags::from_bits(self.bits).unwrap()
    }
}

pub fn init() {

    heap_allocator::init_heap();  // 堆空间分配器

    frame_allocator::init_frame_allocator();  // 物理页帧分配器
    // KERNEL_SPACE是个lazy启动的，启动时将pagetable等数据写好
 
    KERNEL_SPACE.lock().activate();  // 切换页表
    // KERNEL_SPACE.lock().print_pagetable();
    
    let mut reg:usize = 0;
    unsafe{
        llvm_asm!("mv $0,sp" : "=r"(reg));
    }
    println!("latter sp: {:x}",reg);

}

pub fn init_othercore(){
    KERNEL_SPACE.lock().activate();
}

lazy_static! {
    pub static ref PAGE_TABLE_LIST: Mutex<Vec<PageTable>> = Mutex::new(
        Vec::<PageTable>::new()
    );
}

//get the Pagetable from its handle(id)
pub fn pt_get(pt_handle: usize) -> Option<PageTable>{
    for i in PAGE_TABLE_LIST.lock().clone().into_iter(){
        if i.id() == pt_handle {
            return Some(i.clone());
        }
    }
    return None
}

pub fn pt_init(pt: PageTable){
    &PAGE_TABLE_LIST.lock().push(pt);
}


//the function below would expose to outer kernel

//Yan_ice: this function is used to create a new bare pagetable for user process.
pub fn nkapi_pt_init(pt_handle: usize){
    
    for i in PAGE_TABLE_LIST.lock().clone().into_iter(){
        if i.id() == pt_handle {
            return;
        }
    }

    //Yan_ice: here we create a new pagetable.
    let mut pt = PageTable::new(pt_handle);
    println!("Creating PageTable [{}] with token {:x}.",pt_handle, pt.token());

    println!("[debug] Mapping trampoline.");

    //Yan_ice: mapping signal trampoline, I don't know why here panic occurs.
    pt.map(VirtAddr::from(SIGNAL_TRAMPOLINE).into(),
        PhysAddr::from(ssignaltrampoline as usize).into(),
        PTEFlags::R | PTEFlags::X | PTEFlags::U,
    );

    // mapping trampoline
    pt.map(VirtAddr::from(TRAMPOLINE).into(), 
        PhysAddr::from(strampoline as usize).into(),
        PTEFlags::R | PTEFlags::X);

    pt.map(VirtAddr::from(NK_TRAMPOLINE).into(), 
            PhysAddr::from(snktrampoline as usize).into(),
            PTEFlags::R | PTEFlags::X);

    pt.print_pagetable();

    println!("[debug ]Mapping kernel_shared space.");
    pt.map_kernel_shared();

    println!("Creating Pagetable success.");
    PAGE_TABLE_LIST.lock().push(pt);
}

// pub fn nkapi_pt_copy(pt_handle: usize, parent_handle: usize){
//     nkapi_pt_init(pt_handle);

//     let mut parent = None;
//     for i in PAGE_TABLE_LIST.into_iter(){
//         if i.id() == parent_handle {
//             parent = Some(i);
//         }
//     }

// }

pub fn nkapi_set_permission(pt_handle: usize, vpn: VirtPageNum, flags: usize){
    // find target pagetable
    if let Some(mut target_pt) = pt_get(pt_handle){
        target_pt.set_pte_flags(vpn, flags);
    }
    
}
pub fn pt_destroy(pt_handle: usize){
    // TODO
}

pub fn nkapi_alloc(pt_handle: usize, vpn: VirtPageNum, map_type: MapType, perm: MapPermission) -> PhysPageNum{
    let pte_flags = PTEFlags::from_bits(perm.bits()).unwrap();

    if let Some(mut target_pt) = pt_get(pt_handle){
        // get target ppn
        let target_ppn;
        match map_type{
            MapType::Framed => {
                if let Some(ppn) = outer_frame_alloc_raw(){
                    target_ppn = ppn;
                }else{
                    outer_print_free_pages();
                    panic!("No more memory in Outer Kernel!");
                }
            }
            MapType::FramedInNK => {
                if let Some(ppn) = frame_alloc_raw(){
                    target_ppn = ppn;
                }else{
                    print_free_pages();
                    panic!("No more memory in Nested Kernel!");
                }
            }
            MapType::Identical => {
                target_ppn = PhysPageNum::from(vpn.0);
            }
        }

        //clean the page frame
        let bytes_array = target_ppn.get_bytes_array();
        for i in bytes_array {
            *i = 0;
        }

        // modify pagetable entry
        target_pt.map(vpn, target_ppn, pte_flags);

        return target_ppn
    }

    return PhysPageNum{0: vpn.0};

}

pub fn nkapi_dealloc(pt_handle: usize, vpn: VirtPageNum){
    if let Some(mut pt) = pt_get(pt_handle){
        pt.unmap(vpn);
    }
    
}

pub fn nkapi_mmap(pt_handle: usize, vpn: VirtPageNum, ppn: PhysPageNum, perm: MapPermission){
    if let Some(mut pt) = pt_get(pt_handle) {
        pt.map(vpn, ppn, perm.flags());
    }
    
}

pub fn nkapi_unmap(pt_handle: usize, vpn: VirtPageNum){
    if let Some(mut pt) = pt_get(pt_handle){
        pt.unmap(vpn);
    }
    
}

// while translating COW with write==True, it would start alloc and copy.
pub fn nkapi_translate(pt_handle: usize, vpn: VirtPageNum, write: bool) -> Option<PhysPageNum>{
    if let Some(mut pt) = pt_get(pt_handle){
        let pte = pt.translate(vpn).unwrap();
        if pte.is_valid() {
            let former_ppn = pte.ppn();

            if pte.is_cow(){

                //the code copy from memoryset::cow_alloc
                if enquire_refcount(former_ppn) == 1 {
                    pt.reset_cow(vpn);
                    // change the flags of the src_pte
                    pt.set_flags(
                        vpn, pt.translate(vpn).unwrap().flags() | PTEFlags::W
                    );
                }

                let ppn = frame_alloc_raw().unwrap();
                pt.remap_cow(vpn, ppn, former_ppn);
                return Some(ppn);

            }else{
                return Some(former_ppn);
            }
            
        }
    }
    None
}

pub fn nkapi_translate_va(pt_handle: usize, va: VirtAddr) -> Option<PhysAddr>{
    if let Some(pt) = pt_get(pt_handle){
        return pt.translate_va(va);
    }
    None
}


pub fn nkapi_copyTo(pt_handle: usize, mut current_vpn: VirtPageNum, data: &[u8], offset:usize) {
    let mut start: usize = 0;
    let mut page_offset: usize = offset;
    let len = data.len();
    if let Some(pt) = pt_get(pt_handle){
        loop { 
            let src = &data[start..len.min(start + crate::config::PAGE_SIZE - page_offset)];
            let dst = &mut pt.translate(current_vpn)
                .unwrap().ppn()
                .get_bytes_array()[page_offset..(page_offset+src.len())];
            dst.copy_from_slice(src);
    
            start += crate::config::PAGE_SIZE - page_offset;
            
            page_offset = 0;
            if start >= len {
                break;
            }
            current_vpn.step();
        }
    }
    
}

pub fn nkapi_activate(pt_handle: usize) {
    if let Some(page_table) = pt_get(pt_handle) {
        let satp = page_table.token();
        unsafe {
            satp::write(satp);
            llvm_asm!("sfence.vma" :::: "volatile");
        }
    }
    
}


// this function is temporaily used. it is vulunerable!
pub fn nkapi_vun_getpt(pt_handle: usize) -> PageTable{
    if let Some(pt) = pt_get(pt_handle) {
        return pt;
    }
    panic!("Pagetable handle not exist.");
}
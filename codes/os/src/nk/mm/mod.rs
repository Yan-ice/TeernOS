mod heap_allocator;
mod address;
mod frame_allocator;
mod page_table;
pub(crate) mod memory_set;
mod vma;

use crate::lazy_static;
use alloc::vec::Vec;

use page_table::PTEFlags;
use address::VPNRange;

pub use address::{PhysAddr, VirtAddr, PhysPageNum, VirtPageNum, StepByOne};
pub use frame_allocator::{
    FrameTracker, 
    outer_frame_alloc, 
    outer_frame_dealloc,
    add_free, 
    print_free_pages, 
    frame_add_ref, 
    enquire_refcount
};

//nk内部的就不暴露啦
use frame_allocator::{
    frame_alloc,
    frame_dealloc
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
};

pub use vma::{MmapArea, MmapSpace};
pub use memory_set::{MemorySet, KERNEL_SPACE, OUTER_KERNEL_SPACE,KERNEL_MMAP_AREA, KERNEL_TOKEN,  MapPermission, kernel_token};
pub use memory_set::remap_test;
pub use heap_allocator::HEAP_ALLOCATOR;
pub use frame_allocator::FRAME_ALLOCATOR;



#[derive(Copy, Clone, PartialEq, Debug)]
pub enum MapType {
    Identical,
    Framed,
    FramedInNK
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
    pub static ref PAGE_TABLE_LIST: Vec<PageTable> = Vec::<PageTable>::new();
}

pub fn pt_init_in_nk(pt: PageTable){
    PAGE_TABLE_LIST.append(pt);
}

//the function below would expose to outer kernel

pub fn pt_init(pt_handle: usize){
    for i in PAGE_TABLE_LIST.into_iter(){
        if (i.id() == pt_handle) {
            return;
        }
    }
    PAGE_TABLE_LIST.append(PageTable::new(pt_handle));
}

pub fn pt_destroy(pt_handle: usize){
    // TODO
}

pub fn alloc(pt_handle: usize, vpn: VirtAddr, map_type: MapType, flags: PTEFlags){
    let &target_pt;
    for i in PAGE_TABLE_LIST.into_iter(){
        if (i.id() == pt_handle) {
            target_pt = i;
        }
    }

    let ppn;
    match map_type{
        MapType::Framed => {
            if let Some(ppn) = frame_alloc_raw(){
                
            }else{
                print_free_pages();
                panic!("No more memory!");
            }
        }
        MapType::FramedInNK => {
            i.map(vpn, PhysAddr::new(vpn.0), flags);
        }
        MapType::Identical => {
            ppn = 
            i.map(vpn, PhysAddr::new(vpn.0), flags);
        }
    }

    //clean the page frame
    let bytes_array = ppn.get_bytes_array();
    for i in bytes_array {
        *i = 0;
    }


}

pub fn unmap(pt_handle: usize, vpn: VirtAddr){
    for i in PAGE_TABLE_LIST.into_iter(){
        if (i.id() == pt_handle) {
            i.unmap(vpn);
        }
    }
}
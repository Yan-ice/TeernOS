mod heap_allocator;
mod address;
mod frame_allocator;
mod page_table;
mod memory_set;
mod vma;

use page_table::PTEFlags;
use address::VPNRange;
pub use address::{PhysAddr, VirtAddr, PhysPageNum, VirtPageNum, StepByOne};
pub use frame_allocator::{FrameTracker, frame_alloc, frame_dealloc,add_free, print_free_pages, frame_add_ref, enquire_refcount};
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
pub use memory_set::{MemorySet, KERNEL_SPACE, KERNEL_MMAP_AREA, KERNEL_TOKEN,  MapPermission, kernel_token};
pub use memory_set::remap_test;
pub use heap_allocator::HEAP_ALLOCATOR;

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


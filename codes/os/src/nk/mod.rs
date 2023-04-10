mod mm;   
mod trap;
pub mod drivers;

pub use trap::{TrapContext as TrapContext, trap_handler as trap_handler, trap_return as trap_return};
pub use mm::{VirtPageNum as VirtPageNum, 
            VirtAddr as VirtAddr, 
            PhysPageNum as PhysPageNum,
            PhysAddr as PhysAddr, 
            UserBuffer as UserBuffer, 
            add_free as add_free, 
            KERNEL_SPACE as KERNEL_SPACE, 
            MapPermission as MapPermission,
            KERNEL_MMAP_AREA as KERNEL_MMAP_AREA,
            PageTableEntry as PageTableEntry,
            translated_refmut as translated_refmut,
            MemorySet as MemorySet,
            MmapArea as MmapArea,
            translated_ref as translated_ref,
            PageTable as PageTable,
            translated_byte_buffer as translated_byte_buffer,
            translated_str as translated_str,
            print_free_pages as print_free_pages,
            copy_from_user as copy_from_user,
            copy_to_user as copy_to_user,
            translated_array_copy as translated_array_copy}; 

pub fn nk_main(){
    mm::init();
    mm::remap_test();
    trap::init();
    trap::enable_timer_interrupt();
    println!("Nesked kernel init");
}
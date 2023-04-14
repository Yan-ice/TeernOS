mod mm;   
mod trap;
pub mod drivers;

pub use trap::{TrapContext as TrapContext, trap_return as trap_return};
pub use mm::{VirtPageNum as VirtPageNum, 
            VirtAddr as VirtAddr, 
            PhysPageNum as PhysPageNum,
            PhysAddr as PhysAddr, 
            UserBuffer as UserBuffer, 
            KERNEL_SPACE as KERNEL_SPACE, 
            MapPermission as MapPermission,
            KERNEL_MMAP_AREA as KERNEL_MMAP_AREA,
            PageTableEntry as PageTableEntry,
            MemorySet as MemorySet,
            MmapArea as MmapArea,
            PageTable as PageTable,

            //以下是在当前partition中，外部用到的接口。
            translated_refmut as translated_refmut,
            translated_ref as translated_ref,
            add_free as add_free, 
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


fn nk_call(){
    //entry gate
    //exit gate
}
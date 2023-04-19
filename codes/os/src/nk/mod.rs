mod mm;   
mod trap;

pub use trap::{TrapContext as TrapContext, 
        trap_return};

pub use mm::{VirtPageNum as VirtPageNum, 
            VirtAddr as VirtAddr, 
            PhysPageNum as PhysPageNum,
            PhysAddr as PhysAddr, 
            UserBuffer as UserBuffer, 
            KERNEL_SPACE as KERNEL_SPACE, 
            MapPermission as MapPermission,
            KERNEL_MMAP_AREA as KERNEL_MMAP_AREA,
            KERNEL_TOKEN as KERNEL_TOKEN,
            PageTableEntry as PageTableEntry,
            MemorySet as MemorySet,
            MmapArea as MmapArea,
            PageTable as PageTable,
            FrameTracker as FrameTracker,
            StepByOne as StepByOne,
            
            //以下是读取内存数据的系列接口。
            translated_refmut as translated_refmut,
            translated_ref as translated_ref,
            translated_refcopy as translated_refcopy,
            translated_raw as translated_raw,
            translated_str as translated_str,

            //以下是memcopy的系列接口。
            copy_array as copy_array,
            copy_object as copy_object,
            //或许可以实现strcpy?

            //以下是alloc/mmio系列接口，还没实现
            frame_alloc as frame_alloc,
            frame_dealloc as frame_dealloc,
            //io_map as io_map
            //io_unmap as io_unmap

            //以下接口暂时未知。
            add_free as add_free, 
            print_free_pages as print_free_pages,
            }; 


pub fn nk_main(){
    mm::init();
    mm::remap_test();  //无用
    trap::init();
    trap::enable_timer_interrupt();
    println!("Nesked kernel init");
}


fn nk_call(){
    //entry gate
    
    //exit gate
}
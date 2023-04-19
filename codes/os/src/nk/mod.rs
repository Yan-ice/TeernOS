mod mm;   
mod trap;

use crate::outer_kernel_init;

pub use trap::{TrapContext as TrapContext, 
        trap_return, trap_handler};

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

pub fn id() -> usize {
                let cpu_id;
                unsafe {
                    llvm_asm!("mv $0, tp" : "=r"(cpu_id));
                }
                cpu_id
}

fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    (sbss as usize..ebss as usize).for_each(|a| {
        unsafe { (a as *mut u8).write_volatile(0) }
    });
}


#[no_mangle]
pub fn nk_main(){
    let core = id();
    // println!("core {} is running",core);
    if core != 0 {
        loop{}
        // WARNING: Multicore mode only supports customized RustSBI platform, especially not including OpenSBI
        // We use OpenSBI in qemu and customized RustSBI in k210, if you want to try Multicore mode, you have to
        // try to switch to RustSBI in qemu and try to wakeup, which needs some effort and you can refer to docs.
        //
        // while !CORE2_FLAG.lock().is_in(){}
        // mm::init_othercore();
        // println!("other core start");
        // trap::init();
        // nk::trap::enable_timer_interrupt();
        // timer::set_next_trigger();
        // println!("other core start run tasks");
        // task::run_tasks();
        // panic!("Unreachable in rust_main!");
    }
    clear_bss();

    mm::init();
    mm::remap_test();  //无用
    trap::init();
    trap::enable_timer_interrupt();
    extern "C"{
        fn sokernelstack();
    }
    TrapContext::app_init_context(
        outer_kernel_init as usize, //返回到outer kernel init
        sokernelstack as usize,
        0, //outer kernel的页表
        0 //outer kernel的栈
    );
    //手动构造outer kernel的trap context上下文

    println!("Nesked kernel init");

    outer_kernel_init();

    return;
    unsafe {
        asm!("csrsi mstatus, 0x8");
    }

    unsafe{
        llvm_asm!("ecall");
    }
}


fn nk_call(){
    //entry gate
    
    //exit gate
}
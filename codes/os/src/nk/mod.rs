mod mm;   
mod trap;
mod debug_util;

use crate::{outer_kernel_init, nk::trap::ProxyContext};
pub use trap::{TrapContext as TrapContext, 
    //nk_trap_return, 
    user_trap_return, PROXYCONTEXT};

pub use debug_util::*;

pub use mm::{VirtPageNum as VirtPageNum, 
            VirtAddr as VirtAddr, 
            PhysPageNum as PhysPageNum,
            PhysAddr as PhysAddr, 
            UserBuffer as UserBuffer, 
            KERNEL_SPACE as KERNEL_SPACE, 
            OUTER_KERNEL_SPACE as OUTER_KERNEL_SPACE,
            MapPermission as MapPermission,
            MapType as MapType,
            PTEFlags as PTEFlags,
            KERNEL_MMAP_AREA as KERNEL_MMAP_AREA,
            KERNEL_TOKEN as KERNEL_TOKEN,
            PageTableEntry as PageTableEntry,
            MmapArea as MmapArea,
            PageTable as PageTable,
            FrameTracker as FrameTracker,
            StepByOne as StepByOne,
            VPNRange as VPNRange,

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

            //以下是alloc/mmio系列接口?
            //Yan_ice: 对外暴露的其实是outer kernel的alloc
            outer_frame_alloc as frame_alloc,
            outer_frame_dealloc as frame_dealloc,

            nkapi_pt_init as nkapi_pt_init,
            nkapi_alloc as nkapi_alloc,
            nkapi_dealloc as nkapi_dealloc,
            nkapi_activate as nkapi_activate,
            nkapi_copyTo as nkapi_copyTo,

            //io_map as io_map
            //io_unmap as io_unmap
            nkapi_mmap as nkapi_mmap,
            nkapi_unmap as nkapi_unmap,
            nkapi_set_permission as nkapi_set_permission,
            nkapi_translate as nkapi_translate,
            nkapi_translate_va as nkapi_translate_va,

            //以下接口暂时未知。
            add_free as add_free, 
            print_free_pages as print_free_pages,

            //DANGER
            nkapi_vun_getpt as nkapi_vun_getpt
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

global_asm!(include_str!("nk_gate.S"));

extern "C" {
    fn nk_entry(
        proxy_address: *const usize,
    );
}

// syscall结束后直接执行这个，没有参数，因为syscall是被nk_exit_gate调用出去的，调用时就已经设置好了ra，然后执行exit_gate的东西
pub fn nk_entry_gate(){
    println!("1");
    // 交换页表
    KERNEL_SPACE.lock().activate();
    // println!("2");
    // // 禁用中断
    // unsafe {
    //     llvm_asm!("csrci sstatus, 2");
    // }
    // println!("3");
    // 先恢复寄存器，再换栈
    unsafe {
        nk_entry(&(PROXYCONTEXT.lock().nk_register) as *const usize);
    }
    println!("enter nk");
}

extern "C" {
    pub fn nk_exit(
        proxy_address: *const usize,
        function_address: usize
    );
}

fn nk_exit_gate(proxycontext: *const usize, function_address: usize){

    println!("exit nk");

    //if to outer kernel:
    //开启中断
    unsafe {
        llvm_asm!("csrsi sstatus, 2");
    }

    //先保存寄存器，再换栈，再设置好ra，再换页表
    unsafe {
        nk_exit(proxycontext, function_address);
    }
               
    //TODO: 进程页表/内核页表
    //if to user: 暂时未写
    // trap return (so here ignore)
}

#[no_mangle]
pub fn nk_main(){
    let core = id();
    if core != 0 {
        loop{}
    }
    clear_bss();

    mm::init();
    mm::remap_test();
    trap::init();
    //trap::enable_timer_interrupt();

    extern "C"{
        fn nk_kernel_stack_top();
        fn eokernelstack();
        fn __exit_gate();
    }

    println!("Nesked kernel init success");

    unsafe{
        let mut proxycontext = PROXYCONTEXT.lock();
        proxycontext.outer_register[2] = eokernelstack as usize; // 初始化 outer kernel的栈指针
        
        drop(proxycontext);

        context_info();
        register_info();
        nk_exit_gate(&(PROXYCONTEXT.lock().nk_register) as *const usize, outer_kernel_init as usize);
        panic!("not reachable");
    }

    // //手动构造user的trap context上下文，然后回到user space
    // let mut trap_context_address = &TrapContext::app_init_context(
    //     outer_kernel_init as usize, //返回到outer kernel init
    //     eokernelstack as usize, //outer kernel 栈
    //     KERNEL_SPACE.lock().token(), //nested kernel的页表
    //     nk_kernel_stack_top as usize //nested kernel的栈
    // ) as *const TrapContext;
    
    return;
}


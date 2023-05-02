mod mm;   
mod trap;

use spin::Mutex;
use alloc::sync::Arc;
use crate::{outer_kernel_init, nk::trap::ProxyContext};

pub use trap::{TrapContext as TrapContext, 
    //nk_trap_return, 
    user_trap_return, PROXYCONTEXT};

pub use mm::{VirtPageNum as VirtPageNum, 
            VirtAddr as VirtAddr, 
            PhysPageNum as PhysPageNum,
            PhysAddr as PhysAddr, 
            UserBuffer as UserBuffer, 
            KERNEL_SPACE as KERNEL_SPACE, 
            OUTER_KERNEL_SPACE as OUTER_KERNEL_SPACE,
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

            //以下是alloc/mmio系列接口?
            //Yan_ice: 对外暴露的其实是outer kernel的alloc
            outer_frame_alloc as frame_alloc,
            outer_frame_dealloc as frame_dealloc,

            //io_map as io_map
            //io_unmap as io_unmap

            //以下接口暂时未知。
            add_free as add_free, 
            print_free_pages as print_free_pages,

            //以下是process系列接口，会转交给outer kernel.
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
    pub fn nk_entry(
        proxy_address: *const usize,
    );
}

// 暂时作为让outer kernel执行完毕后得到数据
fn nk_entry_gate(){
    // 交换页表
    KERNEL_SPACE.lock().activate();

    // 先恢复寄存器，再换栈
    unsafe {
        nk_entry(&*PROXYCONTEXT as *const ProxyContext as *const usize);
    }

    // 禁用中断
    unsafe {
        llvm_asm!("csrci sstatus, 2");
    }

}

extern "C" {
    pub fn nk_exit(
        proxy_address: *const usize,
        function_address: usize
    );
}

fn nk_exit_gate(proxycontext: *const usize, function_address: usize){
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
    trap::enable_timer_interrupt();

    extern "C"{
        fn nk_kernel_stack_top();
        fn eokernelstack();
        fn __exit_gate();
    }

    println!("Nesked kernel init success");

    unsafe{
        println!("{}", 1);
    
        nk_exit_gate((&(*PROXYCONTEXT)) as *const ProxyContext as *const usize, outer_kernel_init as usize);
        println!("{}", 2);
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


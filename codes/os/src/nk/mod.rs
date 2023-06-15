mod mm;   
mod trap;
pub mod tests;
use crate::debug_info;
use crate::{outer_kernel_init, nk::{trap::PROXYCONTEXT, 
    tests::{mem_access_timecost, nkapi_gatetest}}, 
syscall::syscall, OUTER_KERNEL_SPACE};
use alloc::slice::{from_raw_parts, from_raw_parts_mut};

use crate::shared::*;

pub use trap::user_trap_return as user_trap_return;


pub use mm::{
            KERNEL_SPACE as KERNEL_SPACE, 
        
            KERNEL_TOKEN as KERNEL_TOKEN,
            PageTableEntry as PageTableEntry,
            PageTable as PageTable,
            StackFrameAllocator as StackFrameAllocator,
            FrameAllocator as FrameAllocator,
            //以下接口暂时未知。
            add_free as add_free, 
            print_free_pages as print_free_pages,

            //DANGER
            nkapi_vun_getpt as nkapi_vun_getpt
};


global_asm!(include_str!("nk_gate.S"));
global_asm!(include_str!("context.S"));


#[macro_use]

fn get_time() -> usize {
    let mut time:usize = 0;
    unsafe{
        asm!(
            "rdtime a0",
            inout("a0") time
        );
    }
    time
}


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
extern "C" {
    pub fn nk_entry();
    pub fn nk_exit();
}

fn space(){

    extern "C" {
        fn stext();
        fn etext();
        fn srodata();
        fn erodata();
        fn sdata();
        fn edata();
        fn sbss_with_stack();
        fn ebss();
        fn sproxy();
        fn eproxy();
        fn snkheap();
        fn enkheap();
        fn ekernel();
        fn sokernel();
        fn outer_allocator();
        fn outer_static();
        fn sokheap();
        fn eokheap();
        fn sokernelstack();
        fn eokernelstack();
        fn eokernel();
        fn strampoline();
        fn ssignaltrampoline();
        fn snktrampoline();
    }
    debug_info!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
    debug_info!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
    debug_info!(".data [{:#x}, {:#x})", sdata as usize, edata as usize);
    debug_info!(".bss [{:#x}, {:#x})", sbss_with_stack as usize, ebss as usize);
    debug_info!("nkheap [{:#x}, {:#x})", snkheap as usize, enkheap as usize);
    debug_info!("nkframe [{:#x}, {:#x})", ekernel as usize, crate::config::NKSPACE_END);
    debug_info!("okheap [{:#x}, {:#x})", sokheap as usize, eokheap as usize);
    debug_info!("okstack [{:#x}, {:#x})", sokernelstack as usize, eokernelstack as usize);
    debug_info!("okframe [{:#x}, {:#x})", eokernel as usize, crate::config::OKSPACE_END);
}
#[no_mangle]
pub fn nk_main(){
    let core = id();
    if core != 0 {
        loop{}
    }
    clear_bss();
    
    mm::init();
    debug_info!("mm init success.");

    trap::init();
    debug_info!("trap init success.");

    //init page for outer kernel.

    OUTER_KERNEL_SPACE().lock();
    debug_info!("outer kernel pagetable init success.");

    nkapi_gatetest();
    //nkapi_print_pt(0, 0, 0x5000);

    unsafe{
        let mut proxy = PROXYCONTEXT();
        proxy.nk_satp = KERNEL_SPACE.lock().token();
        proxy.outer_satp = crate::nk::nkapi_vun_getpt(0).token();
        proxy.outer_register[1] = outer_kernel_init as usize; //let ra be outer kernel init
        proxy.outer_register[2] = eokernelstack as usize; // 初始化 outer kernel的栈指针
    }

    extern "C"{
        fn nk_kernel_stack_top();
        fn eokernelstack();
        fn __exit_gate();
        fn snkheap();
        fn enkheap();
        fn sokheap();
        fn eokheap();
    }

    debug_info!("copying heap");
    unsafe{
        let total_size = enkheap as usize - snkheap as usize;
        let unit_size = 1024;
        let from_addr = snkheap as usize;
        let to_addr = sokheap as usize;

        for part in 0..(total_size/unit_size){
            let a1 = from_addr+unit_size*part;
            let a2 = to_addr+unit_size*part;
            let mut src_data = from_raw_parts(a1 as *const u8, unit_size);
            let mut dst_data = from_raw_parts_mut(a2 as *mut u8, unit_size);
            dst_data.copy_from_slice(src_data);
        }  
    }

    debug_info!("Nesked kernel init success");
    space();

    mem_access_timecost();

    unsafe{
        nk_exit();
        panic!("not reachable");
    }

}


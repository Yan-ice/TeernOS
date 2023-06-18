#![no_std]
#![no_main]
#![feature(global_asm)]
#![feature(llvm_asm)]
#![feature(asm)]
#![feature(panic_info_message)]
#![feature(alloc_error_handler)]


extern crate alloc;

#[macro_use]
extern crate bitflags;

#[macro_use]
mod lang_items;

extern crate shared;

mod mm;   
mod trap;
mod tests;

global_asm!(include_str!("entry.asm"));
global_asm!(include_str!("start_app.S"));

use tests::{mem_access_timecost, nkapi_gatetest};

use crate::shared::*;

use mm::{
            KERNEL_SPACE as KERNEL_SPACE, 
            //DANGER
            nkapi_vun_getpt as nkapi_vun_getpt
};
use core::panic::PanicInfo;
use crate::shared::sbi::shutdown;


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
        fn ekernel();
        fn strampoline();
        fn ssignaltrampoline();
        fn snktrampoline();
    }
    debug_info!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
    debug_info!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
    debug_info!(".data [{:#x}, {:#x})", sdata as usize, edata as usize);
    debug_info!(".bss [{:#x}, {:#x})", sbss_with_stack as usize, ebss as usize);
    // debug_info!("nkheap [{:#x}, {:#x})", snkheap as usize, enkheap as usize);
    debug_info!("nkframe [{:#x}, {:#x})", ekernel as usize, crate::config::NKSPACE_END);
    // debug_info!("okstack [{:#x}, {:#x})", sokernelstack as usize, eokernelstack as usize);
    // debug_info!("okheap [{:#x}, {:#x})", sokheap as usize, eokheap as usize);
    // debug_info!("okframe [{:#x}, {:#x})", eokernel as usize, crate::config::OKSPACE_END);
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

    nkapi_pt_init(0, false);
    nkapi_alloc_mul(0, 0x80200.into(), 0x600, 
    MapType::Identical, MapPermission::R | MapPermission::W | MapPermission::X);

    nkapi_alloc_mul(0, 0x80800.into(), 0x4, 
    MapType::Identical, MapPermission::R | MapPermission::W | MapPermission::X);

    //OUTER_KERNEL_SPACE().lock();
    debug_info!("outer kernel pagetable init success.");

    nkapi_gatetest();
    //nkapi_print_pt(0, 0, 0x5000);

    unsafe{
        let mut proxy = PROXYCONTEXT();
        proxy.nk_satp = KERNEL_SPACE.lock().token();
        proxy.outer_satp = nkapi_vun_getpt(0).token();
        proxy.outer_register[1] = 0x80800000 as usize; //let ra be outer kernel init
        proxy.outer_register[2] = 0x80812000 as usize; // 初始化 outer kernel的栈指针 
    }


    debug_info!("Nesked kernel init success");
    space();

    mem_access_timecost();

    unsafe{
        nk_exit();
        panic!("not reachable");
    }

}

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    if let Some(location) = info.location() {
        debug_error!("[kernel] Panicked at {}:{} {}", location.file(), location.line(), info.message().unwrap());
    } else {
        debug_error!("[kernel] Panicked: {}", info.message().unwrap());
    }
    shutdown()
}

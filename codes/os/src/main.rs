#![no_std]
#![no_main]
#![feature(global_asm)]
#![feature(llvm_asm)]
#![feature(asm)]
#![feature(panic_info_message)]
#![feature(alloc_error_handler)]

use lazy_static::lazy_static;
use sbi::sbi_send_ipi;
use spin::*;
use timer::get_timeval;
use nk::*;
use alloc::sync::Arc;
extern crate alloc;

#[macro_use]
extern crate bitflags;

#[macro_use]
mod console;
mod lang_items;
mod sbi;
mod nk;
mod config;
mod utils;
mod fs;
mod util;
mod syscall;

mod drivers;
#[macro_use]
mod monitor;
mod task;
mod timer;

global_asm!(include_str!("entry.asm"));
global_asm!(include_str!("start_app.S"));




pub const SYSCALL_GETPPID:usize = 173;
pub fn test() {
    // let start = get_timeval();
    // for _ in 0..100000000{
    //     syscall(SYSCALL_GETPPID,[0,0,0,0,0,0]);
    // }
    // let end = get_timeval();
    // println!("test: run sys_getppid 100000000 times, spent {:?}",end-start);
}

struct Core2flag{
    is_in: bool,
}

impl Core2flag{
    pub fn is_in(&self)->bool{
        self.is_in
    }
    pub fn set_in(&mut self){
        self.is_in = true;
    }
}


lazy_static! {
    static ref CORE2_FLAG: Arc<Mutex<Core2flag>> = Arc::new(Mutex::new(
        Core2flag{
            is_in:false,
        }
    ));
}

pub fn outer_kernel_init(){
    KERNEL_SPACE.lock().activate();

    println!("UltraOS: outer kernel init.");
    timer::set_next_trigger();
    println!("UltraOS: interrupt initialized");
    fs::init_rootfs();
    println!("UltraOS: fs initialized");
    task::add_initproc();
    println!("UltraOS: task initialized");
    println!("UltraOS: wake other cores");
    let mask:usize = 1 << 1;
    sbi_send_ipi(&mask as *const usize as usize);
    // CORE2_FLAG.lock().set_in();
    //test();
    println!("UltraOS: run tasks");
    task::run_tasks();
    panic!("Unreachable in rust_main!");
}
#![no_std]
#![no_main]
#![feature(global_asm)]
#![feature(llvm_asm)]
#![feature(asm)]
#![feature(panic_info_message)]
#![feature(alloc_error_handler)]

use crate::config::*;
use lazy_static::lazy_static;
use sbi::sbi_send_ipi;
use spin::*;
use timer::get_timeval;
use nk::*;
use alloc::sync::Arc;
pub use statics::*;

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
mod statics;

mod drivers;
#[macro_use]
mod monitor;
mod task;
mod timer;

global_asm!(include_str!("entry.asm"));
global_asm!(include_str!("start_app.S"));

fn OuterAllocator() -> &'static mut StackFrameAllocator{
    extern "C"{
        fn outer_allocator();
    }
    unsafe{
        let v = outer_allocator as usize as *mut StackFrameAllocator;
        &mut (*v)
    }
}

pub fn allocator_init(){
    extern "C"{
        fn outer_allocator();
        fn eokernel();
    }
    let allocator = outer_allocator as usize as *mut StackFrameAllocator;
    unsafe{
        //init allocator
        (*allocator) = StackFrameAllocator::new();
        (*allocator).init(PhysAddr::from(eokernel as usize).ceil(), PhysAddr::from(OKSPACE_END).floor());
    }
}

//Yan_ice 给outer kernel加俩函数,用outer kernel的frame allocator，
//然后就暴露他俩咯
pub fn outer_frame_alloc() -> Option<PhysPageNum> {
    let vadr = OuterAllocator().alloc();
    println!("Outer kernel alloc: {:?}", vadr.unwrap());
    vadr
    
}
pub fn outer_frame_dealloc(ppn: PhysPageNum) {
    OuterAllocator().dealloc(ppn);
}


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
    //temoraily have to add to make program run. only for test.
    // KERNEL_SPACE.lock().activate();

    println!("UltraOS: outer kernel init.");
    extern "C"{
        fn snkheap();
    }

    debug_register_info();

    allocator_init();
    println!("UltraOS: static struct initialized");

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
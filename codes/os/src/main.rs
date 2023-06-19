#![no_std]
#![no_main]
#![feature(global_asm)]
#![feature(llvm_asm)]
#![feature(asm)]
#![feature(panic_info_message)]
#![feature(alloc_error_handler)]

#[macro_use]
extern crate shared;
extern crate alloc;

#[macro_use]
extern crate bitflags;

mod lang_items;
mod fs;

#[macro_use]
mod util;
mod os_trap;
mod syscall;
mod drivers;
mod task;

mod timer;
mod heap_allocator;

use crate::{config::*};
use lazy_static::lazy_static;
use sbi::sbi_send_ipi;
use spin::*;
use alloc::sync::Arc;
use shared::*;
use util::*;


global_asm!(include_str!("entry.asm"));
global_asm!(include_str!("start_app.S"));

use crate::heap_allocator::init_heap;


pub const SYSCALL_GETPPID:usize = 173;
pub fn test() {
    // let start = get_timeval();
    // for _ in 0..100000000{
    //     syscall(SYSCALL_GETPPID,[0,0,0,0,0,0]);
    // }
    // let end = get_timeval();
    // debug_os!("test: run sys_getppid 100000000 times, spent {:?}",end-start);

    
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

extern "C"{
    fn eokernel();
}

#[no_mangle]
pub fn outer_kernel_init(){
    debug_os!("Outer Kernel init.");
    
    //temoraily have to add to make program run. only for test.
    nkapi_set_delegate_handler(os_trap::trap_handler_delegate as usize);
    nkapi_set_signal_handler(crate::task::perform_signal_handler as usize);
    nkapi_set_allocator_range(eokernel as usize, OKSPACE_END);
    debug_os!("UltraOS: Config success.");
    init_heap();
    debug_os!("Heap init success.");
    KERNEL_SPACE.lock();
    //nkapi_gatetest();
    //mem_access_timecost();
    
    extern "C"{
        fn sokheap();
    }
    
    debug_os!("UltraOS: static struct initialized");

    timer::set_next_trigger();
    debug_os!("UltraOS: interrupt initialized");

    // unsafe{
    //     asm!("ecall", in("a7")9);
    // }

    fs::init_rootfs();

    debug_os!("UltraOS: fs initialized");

    //unsafe { sie::set_stimer(); }

    task::add_initproc();
    debug_os!("UltraOS: task initialized");

    debug_os!("UltraOS: wake other cores");
    let mask:usize = 1 << 1;
    sbi_send_ipi(&mask as *const usize as usize);
    // CORE2_FLAG.lock().set_in();
    //test();
    
    debug_os!("UltraOS: run tasks");

    task::run_tasks();
    panic!("Unreachable in rust_main!");
}
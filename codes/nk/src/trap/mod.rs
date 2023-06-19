mod trap;
mod trap_handle;

use riscv::register::{
    mtvec::TrapMode,
    scause::{
        self,
        Trap,
        Exception,
        Interrupt,
    },
    sie,
    stval,
    stvec
};
use crate::config::*;
use crate::shared::*;
use trap::{user_trap_handler, user_trap_return};

pub use trap_handle::nk_trap_handler_impl;

extern "C"{
    fn nk_entry();
}
pub fn init(){
    unsafe {
        stvec::write(TRAMPOLINE as usize, TrapMode::Direct);

        debug_warn!("NK_GATE: {:x}",nk_entry as usize);
        PROXYCONTEXT().usr_trap_handler = user_trap_handler as usize;
        PROXYCONTEXT().usr_trap_return = user_trap_return as usize;
    }

}

pub fn enable_timer_interrupt() {
    unsafe { sie::set_stimer(); }
}

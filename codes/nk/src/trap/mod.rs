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
use crate::shared::*; use crate::config::*;

pub use trap_handle::nk_trap_handler;

global_asm!(include_str!("trap.S"));
global_asm!(include_str!("trap_signal.S"));

extern "C"{
    fn __signal_trampoline();
    fn __alltraps();
    fn __restore();
}

pub fn init(){
    unsafe {
        stvec::write(TRAMPOLINE as usize, TrapMode::Direct);
        PROXYCONTEXT().usr_trap_return = TRAMPOLINE + __restore as usize - __alltraps as usize;
    }

}

pub fn enable_timer_interrupt() {
    unsafe { sie::set_stimer(); }
}

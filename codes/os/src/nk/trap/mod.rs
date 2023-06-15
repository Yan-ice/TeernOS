mod trap;

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
pub use crate::shared::*;
pub use trap::user_trap_handler;
pub use trap::user_trap_return;
use super::mm::{MemorySet, KERNEL_SPACE};


pub fn init(){
    unsafe {
        stvec::write(TRAMPOLINE as usize, TrapMode::Direct);

        PROXYCONTEXT().usr_trap_handler = user_trap_handler as usize;
        PROXYCONTEXT().usr_trap_return = user_trap_return as usize;
    }

}

pub fn enable_timer_interrupt() {
    unsafe { sie::set_stimer(); }
}

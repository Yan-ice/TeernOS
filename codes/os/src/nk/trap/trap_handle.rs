use riscv::register::{
    mtvec::TrapMode,
    scause::{
        self,
        Trap,
        Exception,
        Interrupt,
    },
    stval,
    stvec, hpmcounter21::read
};

use crate::shared::*;
use crate::config::*;

///
/// trap in NK would be handled here.
/// 
pub fn nk_trap_handler_impl(ctx: &TrapContext) {
    let scause: scause::Scause = scause::read();
    let stval = stval::read();

    panic!{"Nothing need to handle now..."}
}



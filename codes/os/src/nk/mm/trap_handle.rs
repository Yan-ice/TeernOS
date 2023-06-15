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
use crate::debug_info;

use crate::shared::*;
use crate::config::*;

use crate::syscall::{syscall};
use crate::task::{
    exit_current_and_run_next,
    suspend_current_and_run_next,
    current_user_token,
    current_trap_cx,
    current_task,
    Signals,
    perform_signal_handler,
};

use super::PROXYCONTEXT;
use crate::timer::set_next_trigger;
use crate::gdb_print;
use crate::monitor::*;

pub fn handle_nk_trap(scause: scause::Scause, stval: usize) {
    let is_load: bool;
    if scause.cause() == Trap::Exception(Exception::LoadFault) || scause.cause() == Trap::Exception(Exception::LoadPageFault) {
        debug_info!("cause: {:?}", scause.cause());
        is_load = true;
    } else {
        is_load = false;
    }
    let va: VirtAddr = (stval as usize).into();

    // The boundary decision
    if va > usize::MAX.into() {
        panic!("VirtAddr out of range!");
    }
    debug_info!("check_lazy 1");
    let lazy = current_task().unwrap().check_lazy(va, is_load);
    if lazy != 0 {
        // page fault exit code
        let current_task = current_task().unwrap();
        if current_task.is_signal_execute() || !current_task.check_signal_handler(Signals::SIGSEGV){
            // current_task.acquire_inner_lock().memory_set.print_pagetable();
            debug_info!(
                "[kernel] {:?} in application, bad addr = {:#x}, bad instruction = {:#x}, core dumped.",
                scause.cause(),
                stval,
                current_trap_cx().sepc,
            );
            drop(current_task);
            exit_current_and_run_next(-2);
        }
    }
    // unsafe {
    //     llvm_asm!("sfence.vma" :::: "volatile");
    //     llvm_asm!("fence.i" :::: "volatile");
    // }
    debug_info!{"Trap solved..."}
}



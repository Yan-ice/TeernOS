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
use crate::{nk::{
    VirtAddr, nkapi_traphandler, nkapi_vun_getpt
}, config::NK_TRAMPOLINE};
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

pub use crate::nk::nkapi::ProxyContext;
use super::PROXYCONTEXT;
use crate::timer::set_next_trigger;
use crate::config::{TRAP_CONTEXT, TRAMPOLINE};
use crate::gdb_print;
use crate::monitor::*;

pub fn handle_nk_trap(scause: scause::Scause, stval: usize) {
    let is_load: bool;
    if scause.cause() == Trap::Exception(Exception::LoadFault) || scause.cause() == Trap::Exception(Exception::LoadPageFault) {
        println!("cause: {:?}", scause.cause());
        is_load = true;
    } else {
        is_load = false;
    }
    let va: VirtAddr = (stval as usize).into();

    let x = nkapi_vun_getpt(1);
    let pt = x.translate(VirtAddr::from(stval).floor());
    println!("pte va: {:?}", va);

    // The boundary decision
    if va > usize::MAX.into() {
        panic!("VirtAddr out of range!");
    }
    //println!("check_lazy 1");
    let lazy = current_task().unwrap().check_lazy(va, is_load);
    if lazy != 0 {
        println!("check_lazy not 0: {:x}", lazy);
        // page fault exit code
        let current_task = current_task().unwrap();
        if current_task.is_signal_execute() || !current_task.check_signal_handler(Signals::SIGSEGV){
            // current_task.acquire_inner_lock().memory_set.print_pagetable();
            println!(
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
    //println!{"Trap solved..."}
}

pub fn handle_outer_trap(scause: scause::Scause, stval: usize){

//TODO: entry gate
//trap到outer kernel时，切换为kernel trap。
match scause.cause() {
Trap::Exception(Exception::InstructionFault) |
Trap::Exception(Exception::InstructionPageFault) => {
    let task = current_task().unwrap();
    // println!{"pinLoadFault"}
    //println!("prev syscall = {}", G_SATP.lock().get_syscall());

    let x = nkapi_vun_getpt(1);
    let pt = x.translate(VirtAddr::from(stval).floor());
    println!("trans: {:?} {:?} flags: {:?}", stval<<12, pt.unwrap().ppn(), pt.unwrap().flags());

    println!(
        "[kernel] {:?} in application-{}, bad addr = {:#x}, bad instruction = {:#x}, core dumped.",
        scause.cause(),
        task.pid.0,
        stval,
        current_trap_cx().sepc,
    );
    drop(task);
    // page fault exit code
    let current_task = current_task().unwrap();
    if current_task.is_signal_execute() || !current_task.check_signal_handler(Signals::SIGSEGV){
        drop(current_task);
        exit_current_and_run_next(-2);
    }
}

Trap::Exception(Exception::IllegalInstruction) => {
    // println!{"pinIllegalInstruction"}
    println!("[kernel] IllegalInstruction in application, continue.");
    //let mut cx = current_trap_cx();
    //cx.sepc += 4;
    println!(
        "         {:?} in application, bad addr = {:#x}, bad instruction = {:#x}, core dumped.",
        scause.cause(),
        stval,
        current_trap_cx().sepc,
    );
    // illegal instruction exit code
    exit_current_and_run_next(-3);
}

Trap::Interrupt(Interrupt::SupervisorTimer) => {
    gdb_print!(TIMER_ENABLE,"[timer]");
    set_next_trigger();
    suspend_current_and_run_next();
    //is_schedule = true;
}

_ => {
    panic!("Unsupported trap {:?}, stval = {:#x}!", scause.cause(), stval);
}
}
}

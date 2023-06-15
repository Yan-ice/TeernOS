use riscv::{register::{
    mtvec::TrapMode,
    scause::{
        self,
        Trap,
        Exception,
        Interrupt,
    },
    stval,
    stvec, hpmcounter21::read, sstatus::Sstatus, sie
}, addr::BitField};

use crate::shared::*;
use crate::config::*;
use crate::timer::set_next_trigger;

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

use crate::debug_info;
use super::PROXYCONTEXT;

use crate::config::{TRAP_CONTEXT, TRAMPOLINE};

///
/// Main trap delegate handler in Outer Kernel.
/// 
pub fn trap_handler_delegate(ctx: *mut TrapContext){
    let scause: scause::Scause = scause::read();
    let stval = stval::read();
    unsafe{
        handle_outer_trap(&mut *ctx,scause,stval);
    }
    return;
}

fn handle_outer_trap(cx: &mut TrapContext, scause: scause::Scause, stval: usize){

    //TODO: entry gate
    //trap到outer kernel时，切换为kernel trap。
    match scause.cause() {
        Trap::Exception(Exception::UserEnvCall) =>{
            //debug_info!{"pinUserEnvCall"}
            // jump to next instruction anyway
            // let mut cx = current_trap_cx();
            cx.sepc += 4;

            //G_SATP.lock().set_syscall(cx.x[17]);
            let syscall_id = cx.x[17];
            if syscall_id > 62 && syscall_id != 113 {
                unsafe {
                    //llvm_asm!("sfence.vma zero, zero" :::: "volatile");
                }
            }
            
            //get system call return value
            let result = syscall(syscall_id, [cx.x[10], cx.x[11], cx.x[12], cx.x[13], cx.x[14], cx.x[15]]);
            // cx is changed during sys_exec, so we have to call it again
            //if syscall_id != 64 && syscall_id != 63{
            //    debug_info!("[{}]syscall-({}) = 0x{:X}  ", current_task().unwrap().pid.0, syscall_id, result);
            //} 
            //cx = current_trap_cx();
            cx.x[10] = result as usize;
        }
        Trap::Exception(Exception::InstructionFault) |
        Trap::Exception(Exception::InstructionPageFault) => {
            let task = current_task().unwrap();
            debug_info!{"pinInstructionFault"}
            //debug_info!("prev syscall = {}", G_SATP.lock().get_syscall());
            
            debug_info!(
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
            debug_info!("[kernel] IllegalInstruction in application, continue.");
            //let mut cx = current_trap_cx();
            //cx.sepc += 4;
            debug_info!(
                "         {:?} in application, bad addr = {:#x}, bad instruction = {:#x}, core dumped.",
                scause.cause(),
                stval,
                current_trap_cx().sepc,
            );
            // illegal instruction exit code
            exit_current_and_run_next(-3);
        }
        
        Trap::Interrupt(Interrupt::SupervisorTimer) => {
            debug_info!{"pinTimer"}
            set_next_trigger();
            suspend_current_and_run_next();
            //is_schedule = true;
        }
        
        _ => {
            panic!("Unsupported trap {:?}, stval = {:#x}!", scause.cause(), stval);
        }
    }
}
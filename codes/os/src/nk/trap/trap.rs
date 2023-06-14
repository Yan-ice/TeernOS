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

global_asm!(include_str!("trap.S"));
global_asm!(include_str!("trap_signal.S"));

#[no_mangle]
pub fn user_trap_handler(trap_ctx: *mut TrapContext) -> ! {
    let mut cx: &mut TrapContext;
    unsafe{
        //trap_ctx seems to be const value TRAP_CONTEXT?
        cx = &mut *(TRAP_CONTEXT as *mut TrapContext);
    }

    // unsafe {
    //     stvec::write(TRAMPOLINE as usize, TrapMode::Direct);
    // }

    let scause: scause::Scause = scause::read();
    let stval = stval::read();
    match scause.cause() {
        Trap::Exception(Exception::UserEnvCall) =>{
            // debug_info!{"pinUserEnvCall"}
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
        // Trap::Exception(Exception::InstructionFault) |
        // Trap::Exception(Exception::InstructionPageFault) |        
        // Trap::Exception(Exception::IllegalInstruction) |
        // Trap::Interrupt(Interrupt::SupervisorTimer) => {
        //     handle_outer_trap(scause, stval as usize);
        //     return
        // }
        Trap::Exception(Exception::InstructionFault) |
        Trap::Exception(Exception::InstructionPageFault) |        
        Trap::Exception(Exception::IllegalInstruction) |
        Trap::Interrupt(Interrupt::SupervisorTimer) |
        Trap::Exception(Exception::LoadFault) |
        Trap::Exception(Exception::StoreFault) |
        Trap::Exception(Exception::StorePageFault) |
        Trap::Exception(Exception::LoadPageFault) => {
            nkapi_traphandler(cx);
        }
        _ => {
            panic!("Unsupported trap {:?}, stval = {:#x}!", scause.cause(), stval);
        }
    }

    user_trap_return();
}

#[no_mangle]
pub fn user_trap_return() -> ! {

    // update RUsage of process
    // update_user_clock();
    // let ru_stime = get_kernel_runtime_usec();
    // current_task().unwrap().acquire_inner_lock().rusage.add_stime(ru_stime);
    perform_signal_handler();
    
    //return到user space时，切换为user trap。

    // unsafe {
    //     stvec::write(TRAMPOLINE as usize, TrapMode::Direct);
    // }
    let trap_cx_ptr = TRAP_CONTEXT;

    // if let Some(pa) = nkapi_translate_va(1, trap_cx_ptr.into()){
    //     debug_info!("TRAP_CONTEXT is mapped to {:?}", pa);
    //     unsafe{
    //         let v: &mut TrapContext = &mut *(trap_cx_ptr as *mut TrapContext);
    //         //v.sepc = usr_test as usize;
    //         debug_info!("trap context: {:?}",v);
    //         debug_info!("trap context sp: {:x}",v.x[2]);
            
    //     }
    // }else{
    //     debug_info!("WARN: TRAP_CONTEXT is not mapped!");
    // }

    // let trap_cx = current_task().unwrap().acquire_inner_lock().get_trap_cx();
    // if trap_cx.get_sp() == 0{
    //     debug_info!("[trap_ret] sp = 0");
    // }
    extern "C" {
        fn __alltraps();
        fn __restore();
        fn __signal_trampoline();
    }

    //TODO: exit gate
    let restore_va = __restore as usize - __alltraps as usize + TRAMPOLINE;
   
    unsafe {
        llvm_asm!("fence.i" :::: "volatile");
        llvm_asm!("sfence.vma" :::: "volatile");
        // WARNING: here, we make a1 = __signal_trampoline, because otherwise the "__signal_trampoline" func will be optimized to DEATH
        llvm_asm!("jr $0" :: "r"(restore_va), "{a0}"(trap_cx_ptr), "{a1}"(__signal_trampoline as usize) :: "volatile");
    }
    panic!("Unreachable in back_to_user!");
}

pub fn usr_test(){
    debug_info!("reach usr test!");
}
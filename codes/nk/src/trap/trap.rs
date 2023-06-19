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

use crate::debug_info;

global_asm!(include_str!("trap.S"));
global_asm!(include_str!("trap_signal.S"));

extern "C"{
    fn __delegate(ctx: *const TrapContext);
}

#[no_mangle]
pub fn user_trap_handler(trap_ctx: *mut TrapContext) -> ! {
    
    let ctx;
    unsafe {
        //ctx = &mut *(TRAP_CONTEXT as *mut TrapContext);
        ctx = &mut *trap_ctx;
    }

    let scause: scause::Scause = scause::read();
    let stval = stval::read();
    match scause.cause() {

        Trap::Exception(Exception::InstructionFault) |
        Trap::Exception(Exception::InstructionPageFault) |        
        Trap::Exception(Exception::IllegalInstruction) |
        Trap::Interrupt(Interrupt::SupervisorTimer) |
        Trap::Exception(Exception::LoadFault) |
        Trap::Exception(Exception::StoreFault) |
        Trap::Exception(Exception::StorePageFault) |
        Trap::Exception(Exception::LoadPageFault) => {
            unsafe{
                __delegate(ctx);
            }
        }

        Trap::Exception(Exception::UserEnvCall) => {

            if ctx.x[17] == usize::MAX {

                //some special syscall can be designed, for let NK handle user's requirement instead of OS.
                println!("NK trap handle.");
                nkapi_traphandler(ctx);

            }else{
                unsafe{
                    __delegate(ctx);
                }
            }
            
        }
        _ => {
            panic!("Unsupported trap {:?}, stval = {:#x}!", scause.cause(), stval);
        }
    }

    user_trap_return();
}

#[no_mangle]
pub fn user_trap_return() -> ! {
    debug_info!("into usr_trap_return");
    // update RUsage of process
    // update_user_clock();
    // let ru_stime = get_kernel_runtime_usec();
    // current_task().unwrap().acquire_inner_lock().rusage.add_stime(ru_stime);
    unsafe{
        asm!("jalr x1, x28, 0", 
            in("x28") PROXYCONTEXT().signal_handler
        );
    }
    
    //perform_signal_handler();
    
    //return到user space时，切换为user trap。

    // unsafe {
    //     stvec::write(TRAMPOLINE as usize, TrapMode::Direct);
    // }
    
    let trap_cx_ptr = TRAP_CONTEXT;
    debug_info!("check_va");
    if let Some(pa) = nkapi_translate_va(1, trap_cx_ptr.into()){
        debug_info!("TRAP_CONTEXT is mapped to {:?}", pa);
        unsafe{
            let v: &mut TrapContext = &mut *(trap_cx_ptr as *mut TrapContext);
            //v.sepc = usr_test as usize;
            debug_info!("trap context: {:?}",v);
            debug_info!("trap context sp: {:x}",v.x[2]);
        }
    }else{
        debug_warn!("WARN: TRAP_CONTEXT is not mapped!");
    }

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
        // WARNING: here, we make a1 = __signal_trampoline, because otherwise the "__signal_trampoline" func will be optimized to DEATH
        llvm_asm!("jr $0" :: "r"(restore_va), "{a0}"(trap_cx_ptr), "{a1}"(__signal_trampoline as usize) :: "volatile");
    }
    panic!("Unreachable in back_to_user!");
}

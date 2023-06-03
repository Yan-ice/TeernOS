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
use crate::{TrapContext, nk::{
    VirtAddr, nkapi_traphandler, nkapi_translate_va, mm::nkapi_activate, nkapi_alloc, MapPermission, nkapi_set_permission
}, config::NK_TRAMPOLINE};
use crate::syscall::{syscall, SYSCALLPARAMETER};
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

global_asm!(include_str!("trap.S"));
global_asm!(include_str!("trap_signal.S"));

#[no_mangle]
pub fn user_trap_handler() -> ! {

    println!("handling user trap");

    // unsafe {
    //     stvec::write(TRAMPOLINE as usize, TrapMode::Direct);
    // }

    let scause: scause::Scause = scause::read();
    let stval = stval::read();
    match scause.cause() {
        Trap::Exception(Exception::UserEnvCall) =>{
            
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
            nkapi_traphandler(current_trap_cx());
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

    println!("user trap return");

    // unsafe {
    //     stvec::write(TRAMPOLINE as usize, TrapMode::Direct);
    // }
    let trap_cx_ptr = TRAP_CONTEXT;
    let user_satp = 0;

    
    if let Some(pa) = nkapi_translate_va(1, trap_cx_ptr.into()){
        println!("TRAP_CONTEXT is mapped to {:?}", pa);
        unsafe{
            let v: &mut TrapContext = &mut *(trap_cx_ptr as *mut TrapContext);

            // println!("temporarily change sepc to test.");
            //nkapi_activate(0);
            v.sepc = test_in_usr as usize;
            //let mut sstatus = v.sstatus.bits();
            //sstatus.set_bit(0,true);

            v.sstatus.set_spie(true);

            //println!("sie reg: {:x}", sie.bits());
            println!("sstatus: uie {} upie {} sie {} spie {}", v.sstatus.uie(), v.sstatus.upie(), v.sstatus.sie(), v.sstatus.spie());
            nkapi_alloc(1, VirtAddr::from(v.x[2]).into(), crate::nk::MapType::Framed, MapPermission::W | MapPermission::R );
            if let Some(sp_pa) = nkapi_translate_va(1, v.x[2].into()){
                println!("stack is mapped to {:?}", pa);
            }else{
                println!("WARN: stack is not mapped!");
                
            }
        
        }
    }else{
        println!("WARN: TRAP_CONTEXT is not mapped!");
    }

    let trap_cx = current_task().unwrap().acquire_inner_lock().get_trap_cx();
    if trap_cx.get_sp() == 0{
        println!("[trap_ret] sp = 0");
    }
    extern "C" {
        fn __alltraps();
        fn __restore();
        fn __signal_trampoline();
    }

    //TODO: exit gate
    let restore_va = __restore as usize - __alltraps as usize + TRAMPOLINE;
    
    println!("ready to jump");

    unsafe {
        //llvm_asm!("fence.i" :::: "volatile");
        // WARNING: here, we make a2 = __signal_trampoline, because otherwise the "__signal_trampoline" func will be optimized to DEATH
        llvm_asm!("jr $0" :: "r"(restore_va), "{a0}"(trap_cx_ptr), "{a1}"(user_satp), "{a2}"(__signal_trampoline as usize) :: "volatile");
    }
    panic!("Unreachable in back_to_user!");
}

fn test_in_usr(){
    println!("Test code in user.");


    unsafe{
        let mut satp: usize = 0;
        llvm_asm!("csrr $0,satp" : "=r"(satp));
        println!("current satp: {:x}", satp);
        for i in 0..100{
            nkapi_set_permission(1, 0.into(), (MapPermission::R | 
                MapPermission::W | MapPermission::X | MapPermission::U).bits().into());
            let aa = *(i as *const usize);
            println!("val in {:x}: {:x}", i, aa);
        }
    }
}
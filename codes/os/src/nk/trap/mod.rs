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
pub use crate::shared::*;
pub use trap::user_trap_handler;
pub use trap::user_trap_return;
pub use crate::nk::mm::{MemorySet, KERNEL_SPACE};
use crate::{syscall::syscall, config::{TRAMPOLINE, NK_TRAMPOLINE}};

pub fn init(){
    
    unsafe {
        stvec::write(TRAMPOLINE as usize, TrapMode::Direct);
        //stvec::write(user_trap_handler as usize, TrapMode::Direct);

        PROXYCONTEXT().delegate = syscall as usize;
        PROXYCONTEXT().usr_trap_handler = user_trap_handler as usize;
        PROXYCONTEXT().usr_trap_return = user_trap_return as usize;
    }

    //由于暂时nk的trap还没做好，所以先放nk trampoline吧
    // unsafe {
    //     stvec::write(NK_TRAMPOLINE as usize, TrapMode::Direct);
    // }
}
pub fn enable_timer_interrupt() {
    unsafe { sie::set_stimer(); }
}

pub struct GlobalSatp {
    satp:usize,
    syscall:usize,
}

impl GlobalSatp{
    pub fn set(&mut self, satp:usize){
        self.satp = satp;
    }
    pub fn get(&self)->usize{
        self.satp
    }
    pub fn set_syscall(&mut self, syscall_id:usize){
        self.syscall = syscall_id;
    }
    pub fn get_syscall(&self)->usize{
        self.syscall
    }
}


extern "C"{
    fn nk_kernel_stack_top();
    fn eokernelstack();
    fn __exit_gate();
    fn sproxy();
}

pub fn PROXYCONTEXT() -> &'static mut ProxyContext{
    unsafe{ 
        &mut *(NK_TRAMPOLINE as usize 
        as *mut usize 
        as *mut ProxyContext) 
    }
} 



// #[no_mangle]
// pub fn trap_from_kernel(){
//     // panic!("a trap {:?} from kernel! Stvec:{:x}, Stval:{:X}", scause::read().cause(), stvec::read().bits(), stval::read());

//     debug_info!("trap from kernel");
//     unsafe{
//     let mut sepc: usize;
//         asm!("csrr {0}, sepc", out(reg) sepc,);
//         sepc += 8;
//         asm!("csrw sepc, {0}", in(reg) sepc);

//         asm!("jr {0}", in(reg) sepc);
//     }
//     trap_return_to_kernel();
// }

// #[no_mangle]
// pub fn trap_return_to_kernel(){
//     // panic!("a trap {:?} from kernel! Stvec:{:x}, Stval:{:X}", scause::read().cause(), stvec::read().bits(), stval::read());

//     extern "C" {
//         fn __nktraps();
//         fn __nkrestore();
//         fn __signal_trampoline();
//     }
//     let restore_va = __nkrestore as usize - __nktraps as usize + NK_TRAMPOLINE;
//     unsafe {
//         //llvm_asm!("fence.i" :::: "volatile");
//         // WARNING: here, we make a2 = __signal_trampoline, because otherwise the "__signal_trampoline" func will be optimized to DEATH
//         llvm_asm!("jr $0" :: "r"(restore_va), "{a0}"(trap_cx_ptr), "{a1}"(user_satp), "{a2}"(__signal_trampoline as usize) :: "volatile");
//     }
//     panic!("Unreachable in back_to_outer_kernel!");
    
// }

mod context;
mod trap;


use trap::user_trap_handler;
//use trap_nk::nk_trap_handler;
pub use trap::user_trap_return;
//pub use trap_nk::nk_trap_return;
pub use crate::nk::mm::memory_set::{MemorySet, KERNEL_SPACE, OUTER_KERNEL_SPACE};

use riscv::register::{
    mtvec::TrapMode,
    sie,
    stvec,
};
use crate::config::{TRAMPOLINE};

fn trap_in_nk() -> !{
    unsafe{
        
        let mut val = 1111;
        //llvm_asm!("addi $0, x31, 0" : "=r"(val));
        llvm_asm!("ld $0, 1*8(x10)" : "=r"(val));
        println!("register: {:x}",val); 
        panic!("ERROR: trap occured in Nested Kernel!");
        
    }
    
}

pub fn init(){
    unsafe {
        stvec::write(trap_in_nk as usize, TrapMode::Direct);
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

use lazy_static::lazy_static;
use alloc::sync::Arc;
use spin::Mutex;

// 这个也没有用，实际上和trap相关的信息也只需要在trap模块中被访问，存一个全局的信息没有什么必要
lazy_static! {
    pub static ref G_SATP: Arc<Mutex<GlobalSatp>> = Arc::new(Mutex::new(GlobalSatp{satp:0, syscall:0}));
}

extern "C"{
    fn nk_kernel_stack_top();
    fn eokernelstack();
    fn __exit_gate();
}

lazy_static! {
    pub static ref PROXYCONTEXT: ProxyContext = ProxyContext{
        nk_register: [0; 32],
        outer_register: [0; 32], 
        nk_satp: KERNEL_SPACE.lock().token(),
        outer_satp: OUTER_KERNEL_SPACE.lock().token(),
    };
}


// #[no_mangle]
// pub fn trap_from_kernel(){
//     // panic!("a trap {:?} from kernel! Stvec:{:x}, Stval:{:X}", scause::read().cause(), stvec::read().bits(), stval::read());

//     println!("trap from kernel");
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
pub use context::{TrapContext, ProxyContext};

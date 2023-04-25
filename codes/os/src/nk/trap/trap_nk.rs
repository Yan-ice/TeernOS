// use riscv::register::{
//     mtvec::TrapMode,
//     scause::{
//         self,
//         Trap,
//         Exception,
//         Interrupt,
//     },
//     stval,
//     stvec
// };
// use crate::nk::{
//     VirtAddr,
//     VirtPageNum,
//     print_free_pages,
// };
// use crate::syscall::{syscall};
// use crate::task::{
//     exit_current_and_run_next,
//     suspend_current_and_run_next,
//     current_user_token,
//     current_trap_cx,
//     current_task,
//     Signals,
//     perform_signal_handler,
// };
// use crate::timer::set_next_trigger;
// use crate::config::{TRAP_CONTEXT, TRAMPOLINE, NK_TRAMPOLINE, USER_STACK_SIZE};
// use crate::gdb_print;
// use crate::monitor::*;

// global_asm!(include_str!("trap_nk.S"));

// fn trap_in_nk() -> !{
//     panic!("ERROR: trap occured in Nested Kernel!");
// }

// #[no_mangle]
// pub fn nk_trap_handler() -> ! {

//     //trap到outer kernel时，切换为panic trap。
//     unsafe {
//         stvec::write(trap_in_nk as usize, TrapMode::Direct);
//     }

//     //G_SATP.lock().set(current_user_token());
//     //crate::syscall::test();
//     // update RUsage of process
//     // let ru_utime = get_user_runtime_usec();
//     // current_task().unwrap().acquire_inner_lock().rusage.add_utime(ru_utime);
//     // update_kernel_clock();

//     //let mut is_schedule = false;
//     let scause = scause::read();
//     let stval = stval::read();
//     match scause.cause() {
//         Trap::Exception(Exception::UserEnvCall) => {
            
//             // println!{"pinUserEnvCall"}
//             // jump to next instruction anyway
//             let mut cx = current_trap_cx();
//             cx.sepc += 4;

//             //G_SATP.lock().set_syscall(cx.x[17]);
//             let syscall_id = cx.x[17];
//             if syscall_id > 62 && syscall_id != 113 {
//                 unsafe {
//                     //llvm_asm!("sfence.vma zero, zero" :::: "volatile");
//                 }
//             }
//             //get system call return value

//             let result = syscall(syscall_id, [cx.x[10], cx.x[11], cx.x[12], cx.x[13], cx.x[14], cx.x[15]]);
//             // cx is changed during sys_exec, so we have to call it again
//             //if syscall_id != 64 && syscall_id != 63{
//             //    println!("[{}]syscall-({}) = 0x{:X}  ", current_task().unwrap().pid.0, syscall_id, result);
//             //} 
//             cx = current_trap_cx();
//             cx.x[10] = result as usize;
//             // println!{"cx written..."}
//         }
        
//         Trap::Exception(Exception::InstructionFault) |
//         Trap::Exception(Exception::InstructionPageFault) => {
//             let task = current_task().unwrap();
//             // println!{"pinLoadFault"}
//             //println!("prev syscall = {}", G_SATP.lock().get_syscall());
//             println!(
//                 "[kernel] {:?} in application-{}, bad addr = {:#x}, bad instruction = {:#x}, core dumped.",
//                 scause.cause(),
//                 task.pid.0,
//                 stval,
//                 current_trap_cx().sepc,
//             );
//             drop(task);
//             // page fault exit code
//             let current_task = current_task().unwrap();
//             if current_task.is_signal_execute() || !current_task.check_signal_handler(Signals::SIGSEGV){
//                 drop(current_task);
//                 exit_current_and_run_next(-2);
//             }
//         }
//         Trap::Exception(Exception::LoadFault) |
//         Trap::Exception(Exception::StoreFault) |
//         Trap::Exception(Exception::StorePageFault) |
//         Trap::Exception(Exception::LoadPageFault) => {
//             // println!("page fault 1");
//             let is_load: bool;
//             if scause.cause() == Trap::Exception(Exception::LoadFault) || scause.cause() == Trap::Exception(Exception::LoadPageFault) {
//                 is_load = true;
//             } else {
//                 is_load = false;
//             }
//             let va: VirtAddr = (stval as usize).into();
//             // The boundary decision
//             if va > TRAMPOLINE.into() {
//                 panic!("VirtAddr out of range!");
//             }
//             //println!("check_lazy 1");
//             let lazy = current_task().unwrap().check_lazy(va, is_load);
//             if lazy != 0 {
//                 // page fault exit code
//                 let current_task = current_task().unwrap();
//                 if current_task.is_signal_execute() || !current_task.check_signal_handler(Signals::SIGSEGV){
//                     current_task.acquire_inner_lock().memory_set.print_pagetable();
//                     println!(
//                         "[kernel] {:?} in application, bad addr = {:#x}, bad instruction = {:#x}, core dumped.",
//                         scause.cause(),
//                         stval,
//                         current_trap_cx().sepc,
//                     );
//                     drop(current_task);
//                     exit_current_and_run_next(-2);
//                 }
//             }
//             unsafe {
//                 llvm_asm!("sfence.vma" :::: "volatile");
//                 llvm_asm!("fence.i" :::: "volatile");
//             }
//             // println!{"Trap solved..."}
//         }
//         Trap::Exception(Exception::IllegalInstruction) => {
//             // println!{"pinIllegalInstruction"}
//             println!("[kernel] IllegalInstruction in application, continue.");
//             //let mut cx = current_trap_cx();
//             //cx.sepc += 4;
//             println!(
//                 "         {:?} in application, bad addr = {:#x}, bad instruction = {:#x}, core dumped.",
//                 scause.cause(),
//                 stval,
//                 current_trap_cx().sepc,
//             );
//             // illegal instruction exit code
//             exit_current_and_run_next(-3);
//         }
//         Trap::Interrupt(Interrupt::SupervisorTimer) => {
//             gdb_print!(TIMER_ENABLE,"[timer]");
//             set_next_trigger();
//             suspend_current_and_run_next();
//             //is_schedule = true;
//         }
//         _ => {
//             panic!("Unsupported trap {:?}, stval = {:#x}!", scause.cause(), stval);
//         }
//     }
//     // println!("before trap_return");
//     nk_trap_return();
// }

// #[no_mangle]
// pub fn nk_trap_return() -> ! {

//     //return到outer space时，切换为kernel trap。
//     unsafe {
//         stvec::write(NK_TRAMPOLINE as usize, TrapMode::Direct);
//     }

//     let trap_cx_ptr = TRAP_CONTEXT;
//     let user_satp = current_user_token();
//     let trap_cx = current_task().unwrap().acquire_inner_lock().get_trap_cx();
//     if trap_cx.get_sp() == 0{
//         println!("[trap_ret] sp = 0");
//     }
//     extern "C" {
//         fn __alltraps();
//         fn __restore();
//         fn __signal_trampoline();
//     }
//     let restore_va = __restore as usize - __alltraps as usize + TRAMPOLINE;
//     unsafe {
//         //llvm_asm!("fence.i" :::: "volatile");
//         // WARNING: here, we make a2 = __signal_trampoline, because otherwise the "__signal_trampoline" func will be optimized to DEATH
//         llvm_asm!("jr $0" :: "r"(restore_va), "{a0}"(trap_cx_ptr), "{a1}"(user_satp), "{a2}"(__signal_trampoline as usize) :: "volatile");
//     }
//     panic!("Unreachable in back_to_user!");
// }


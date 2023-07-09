// #![feature(llvm_asm)]
// #[macro_use]
use super::{TaskControlBlock};
use alloc::sync::Arc;
use core::{cell::RefCell};
use lazy_static::*;
use super::{fetch_task, TaskStatus};
use super::__switch;
use crate::timer::get_time_us;

use crate::shared::*; use crate::config::*;
use crate::util::memory_set::*;

use crate::task::manager::add_task;
use crate::debug_os;
pub fn get_core_id() -> usize{
    let tp:usize;
    unsafe {
        core::arch::asm!("mv {0}, tp", 
                        out(reg) tp);
    }
    // tp
    0
}

pub struct Processor {
    inner: RefCell<ProcessorInner>,
}

unsafe impl Sync for Processor {}

struct ProcessorInner {
    current: Option<Arc<TaskControlBlock>>,
    idle_task_cx_ptr: usize,  //你小子是干啥用的 
    user_clock: usize,  /* Timer usec when last enter into the user program */
    kernel_clock: usize, /* Timer usec when user program traps into the kernel*/
}


lazy_static! {
    pub static ref PROCESSOR_LIST: [Processor; 2] = [Processor::new(),Processor::new()];
}


impl Processor {
    pub fn new() -> Self {
        Self {
            inner: RefCell::new(ProcessorInner {
                current: None,
                idle_task_cx_ptr: 0,
                user_clock: 0,  
                kernel_clock: 0,
            }),
        }
    }

    // when trap return to user program, use this func to update user clock
    pub fn update_user_clock(& self){
        self.inner.borrow_mut().user_clock = get_time_us();
    }
    
    // when trap into kernel, use this func to update kernel clock
    pub fn update_kernel_clock(& self){
        self.inner.borrow_mut().kernel_clock = get_time_us();
    }

    pub fn get_user_clock(& self) -> usize{
        return self.inner.borrow().user_clock;
    }

    pub fn get_kernel_clock(& self) -> usize{
        return self.inner.borrow().kernel_clock;
    }

    fn get_idle_task_cx_ptr2(&self) -> *const usize {
        let inner = self.inner.borrow();
        &inner.idle_task_cx_ptr as *const usize
    }
    pub fn run(&self) {
        loop{
            // True: Not first time to fetch a task 
            // 暂时没改
            if let Some(current_task) = take_current_task(){  //主动切换任务
                //gdb_print!(PROCESSOR_ENABLE,"[hart {} run:pid{}]", get_core_id(), current_task.pid.0);
                let mut current_task_inner = current_task.acquire_inner_lock();
                //debug_os!("get lock");
                let task_cx_ptr2 = current_task_inner.get_task_cx_ptr2();
                let idle_task_cx_ptr2 = self.get_idle_task_cx_ptr2();

                // True: switch
                // False: return to current task, don't switch
                if let Some(task) = fetch_task() {
                    debug_os!("[processor] switch to next task.");
                    let mut next_task_inner = task.acquire_inner_lock();
                    // task_inner.memory_set.activate();// change satp
                    let next_task_cx_ptr2 = next_task_inner.get_task_cx_ptr2();
                    next_task_inner.task_status = TaskStatus::Running;
                    drop(next_task_inner);

                    // release
                    self.inner.borrow_mut().current = Some(task);
                    ////////// current task  /////////
                    // update RUsage of process
                    // let ru_stime = get_kernel_runtime_usec();
                    // update_kernel_clock();
                    // current_task_inner.rusage.add_stime(ru_stime);

                    // Change status to Ready
                    current_task_inner.task_status = TaskStatus::Ready;
                    drop(current_task_inner);
                    add_task(current_task);

                    let pt_id = self.inner.borrow_mut().current.as_ref().unwrap().getpid();

                    nkapi_activate(pt_id);
                    
                    ////////// current task  /////////
                    unsafe {
                        __switch(
                            idle_task_cx_ptr2,
                            next_task_cx_ptr2,
                        );
                    }
                }
                else{
                    debug_os!("[processor] keep the same task.");  //想主动切换但是没有可换的
                    drop(current_task_inner);
                    self.inner.borrow_mut().current = Some(current_task);
                    unsafe {
                        __switch(
                            idle_task_cx_ptr2, 
                            task_cx_ptr2,
                        );
                    }
                }

            // False: First time to fetch a task
            } else {
                // Keep fetching
                debug_os!("[processor] First fetch (kernel trick).");  
 
                if let Some(task) = fetch_task() {
                    // acquire
                    let idle_task_cx_ptr2 = self.get_idle_task_cx_ptr2();
                    let mut task_inner = task.acquire_inner_lock();
                    let next_task_cx_ptr2 = task_inner.get_task_cx_ptr2();
                    task_inner.task_status = TaskStatus::Running;
                    let id = task_inner.memory_set.id();
                    drop(task_inner);
                    self.inner.borrow_mut().current = Some(task);
                    nkapi_activate(id); 
                    //debug_os!("ready switch.");  
                    unsafe {
                        __switch(
                            idle_task_cx_ptr2, // 这个值是taskcontext的指针，都是用汇编改的，相当于栈顶，以后所有的schedule都是调这个，两个栈切来切去
                            next_task_cx_ptr2,  //第一次切换，值是默认的，从此以后都用不到了，第一次初始化的位置是随机的，应该是在堆上，因为无所谓，以后都用不到了，以后都是用上面的idle，这个在内核栈上
                        );
                    }

                }
            }
        }
    }
    pub fn take_current(&self) -> Option<Arc<TaskControlBlock>> {
        self.inner.borrow_mut().current.take()
    }
    pub fn current(&self) -> Option<Arc<TaskControlBlock>> {
        self.inner.borrow().current.as_ref().map(|task| Arc::clone(task))
    }
}

pub fn run_tasks() {
    let core_id: usize = get_core_id();
    PROCESSOR_LIST[core_id].run();
}

pub fn take_current_task() -> Option<Arc<TaskControlBlock>> {
    let core_id: usize = get_core_id();
    PROCESSOR_LIST[core_id].take_current()
}

pub fn current_task() -> Option<Arc<TaskControlBlock>> {
    let core_id: usize = get_core_id();
    PROCESSOR_LIST[core_id].current()
}


//temporaily be lazy to rename it :D
pub fn current_user_token() -> usize {
    // let core_id: usize = get_core_id();
    let task = current_task().unwrap();
    let token = task.acquire_inner_lock().get_user_id();
    token
}

pub fn current_user_id() -> usize {
    // let core_id: usize = get_core_id();
    let task = current_task().unwrap();
    let token = task.acquire_inner_lock().get_user_id();
    token
}


pub fn current_trap_cx() -> &'static mut TrapContext {
    current_task().unwrap().acquire_inner_lock().get_trap_cx()
}

pub fn print_core_info(){
    debug_os!( "[core{}] pid = {}", 0, PROCESSOR_LIST[0].current().unwrap().getpid() );
    debug_os!( "[core{}] pid = {}", 1, PROCESSOR_LIST[1].current().unwrap().getpid() );
}

// when trap return to user program, use this func to update user clock
pub fn update_user_clock(){
    let core_id: usize = get_core_id();
    PROCESSOR_LIST[core_id].update_user_clock();
}

// when trap into kernel, use this func to update kernel clock
pub fn update_kernel_clock(){
    let core_id: usize = get_core_id();
    PROCESSOR_LIST[core_id].update_kernel_clock();
}

// when trap into kernel, use this func to get time spent in user (it is duration not accurate time)
pub fn get_user_runtime_usec() -> usize{
    let core_id: usize = get_core_id();
    return get_time_us() - PROCESSOR_LIST[core_id].get_user_clock();
}

// when trap return to user program, use this func to get time spent in kernel (it is duration not accurate time)
pub fn get_kernel_runtime_usec() -> usize{
    let core_id: usize = get_core_id();
    return get_time_us() - PROCESSOR_LIST[core_id].get_kernel_clock();
}


//上下文切换，需要移入NestedKernel。
pub fn schedule(switched_task_cx_ptr2: *const usize) {
    let core_id: usize = get_core_id();
    let idle_task_cx_ptr2 = PROCESSOR_LIST[core_id].get_idle_task_cx_ptr2();
    unsafe {
        __switch(
            switched_task_cx_ptr2, 
            idle_task_cx_ptr2,
        );
    }
}

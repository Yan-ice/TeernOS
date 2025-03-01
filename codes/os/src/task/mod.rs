mod context;
mod switch;
mod task;
mod manager;
mod processor;
pub(crate) mod pid;
mod info;
mod resource;
use crate::debug_os;
use crate::lazy_static;
use crate::fs::{open, OpenFlags, DiskInodeType, File};
use crate::util::mm_util::{UserBuffer};
use crate::gdb_print;
use crate::monitor::*;
//use easy_fs::DiskInodeType;
pub use switch::__switch;
pub use task::{TaskControlBlock, TaskControlBlockInner, TaskStatus, FdTable};
pub use info::*;
pub use resource::*;
use alloc::sync::Arc;
use alloc::vec::Vec;
use manager::fetch_task;
pub use context::TaskContext;
use crate::util::log2;

pub use processor::{
    Processor,
    run_tasks,
    current_task,
    current_user_id,
    current_user_token,
    current_trap_cx,
    take_current_task,
    schedule,
    get_core_id,
    print_core_info,
    update_user_clock,
    update_kernel_clock, 
    get_user_runtime_usec, 
    get_kernel_runtime_usec,
};
pub use manager::{TaskManager, add_task, find_task};
pub use pid::{PidHandle, pid_alloc, KernelStack};
pub use task::AuxHeader;


lazy_static! {
    pub static ref INITPROC: Arc<TaskControlBlock> = Arc::new({
        let inode = open("/","initproc", OpenFlags::RDONLY, DiskInodeType::File).unwrap();
        let v = inode.read_all();
        TaskControlBlock::new(v.as_slice())
    });
}

pub fn suspend_current_and_run_next() -> isize{
    // There must be an application running.
    let task = current_task().unwrap();
    if task.has_signal(Signals::SIGKILL){
        drop(task);
        return -1;
    }
    else{
        // ---- hold current PCB lock
        let mut task_inner = task.acquire_inner_lock();
        let task_cx_ptr2 = task_inner.get_task_cx_ptr2();
        drop(task_inner);
        drop(task);

        // jump to scheduling cycle
        // push back to ready queue while scheduling
        schedule(task_cx_ptr2);
        return 0;
    }
}

pub fn exit_current_and_run_next(exit_code: i32) {
    // debug_os!("exit 1");
    // Forbid more than one process exit (by acquiring lock of INITPROC)
    unsafe{
        let initproc = crate::task::INITPROC.clone();
        let mut initproc_inner = initproc.acquire_inner_lock();
        let task = take_current_task().unwrap();
        // debug_os!("strong count of pid{} = {}", task.pid.0, Arc::strong_count(&task));
        //if task.pid.0 == 2{
        //    crate::fs::clear_cache();
        //}

        //send signal SIGCHLD to parent
        {
            let parent_task = task.get_parent().unwrap(); // this will acquire inner of current task
            let mut parent_inner = parent_task.acquire_inner_lock();
            parent_inner.add_signal(Signals::SIGCHLD);
        }
        let mut inner = task.acquire_inner_lock();
        // debug_os!("exit 2");
        // reset user tid area
        // let clear_child_tid = inner.address.clear_child_tid;
        // if clear_child_tid != 0{
        //     *translated_refmut(inner.get_user_token(), clear_child_tid as *mut i32) = 0;
        // }
        gdb_print!(EXIT_ENABLE,"[exit{}]",task.pid.0);
        // Change status to Zombie
        inner.task_status = TaskStatus::Zombie;
        inner.exit_code = exit_code;
        let initproc = crate::task::INITPROC.clone();
        for child in inner.children.iter() {
        
            child.acquire_inner_lock().parent = Some(Arc::downgrade(&initproc));
            initproc_inner.children.push(child.clone());
        }

        // debug_os!("exit 3");
        // recycle all the data of task
        inner.children.clear();
        // deallocate user space
        inner.memory_set.recycle_data_pages();
        // drop task manually to maintain rc correctly
        drop(inner);
        drop(task);
        drop(initproc_inner);
        // we do not have to save task context
        let _unused: usize = 0;
        schedule(&_unused as *const _);
        
    }
    

}


// Write initproc & user_shell into file system to be executed
// And then release them to fram_allocator
pub fn add_initproc_into_fs() {
    extern "C" { fn _num_app(); }
    extern "C" { fn _app_names(); }
    let mut num_app_ptr = _num_app as usize as *mut usize;
    // let start = _app_names as usize as *const u8;
    let mut app_start = unsafe {
        core::slice::from_raw_parts_mut(num_app_ptr.add(1), 3)
    };

    open(
        "/",
        "mnt",
        OpenFlags::CREATE,
        DiskInodeType::Directory
    );

    // find if there already exits 
    // debug_os!("Find if there already exits ");
    if let Some(inode) = open(
        "/",
        "initproc",
        OpenFlags::RDONLY,
        DiskInodeType::File
    ){
        debug_os!("Already have init proc in FS");
        //return;
        inode.delete();
    }

    if let Some(inode) = open(
        "/",
        "user_shell",
        OpenFlags::RDONLY,
        DiskInodeType::File
    ){
        debug_os!("Already have user shell in FS");
        //return;
        inode.delete();
    }


    // debug_os!("Write apps(initproc & user_shell) to disk from mem ");

    //Write apps(initproc & user_shell) to disk from mem
    if let Some(inode) = open(
        "/",
        "initproc",
        OpenFlags::CREATE,
        DiskInodeType::File
    ){
        // debug_os!("Create initproc ");
        let mut data: Vec<&'static mut [u8]> = Vec::new();
        data.push( unsafe{
        core::slice::from_raw_parts_mut(
            app_start[0] as *mut u8,
            app_start[1] - app_start[0]
        )}) ;
        // debug_os!("Start write initproc ");
        inode.write(UserBuffer::new(data));
        // debug_os!("Init_proc OK");
    }
    else{
        // panic!("initproc create fail!");
    }

    if let Some(inode) = open(
        "/",
        "user_shell",
        OpenFlags::CREATE,
        DiskInodeType::File
    ){
        // debug_os!("Create user_shell ");
        let mut data:Vec<&'static mut [u8]> = Vec::new();
        data.push(unsafe{
        core::slice::from_raw_parts_mut(
            app_start[1] as *mut u8,
            app_start[2] - app_start[1]
        )});
        //data.extend_from_slice(  )
        // debug_os!("Start write user_shell ");
        inode.write(UserBuffer::new(data));
        // debug_os!("User_shell OK");
    }
    else{
        // panic!("user_shell create fail!");
    }
    debug_os!("Write apps(initproc & user_shell) to disk from mem");


    // release
    // let mut start_ppn = app_start[0] / PAGE_SIZE + 1;
    // debug_os!("Recycle memory: {:x}-{:x}", start_ppn* PAGE_SIZE, (app_start[2] / PAGE_SIZE)* PAGE_SIZE);
    // while start_ppn < app_start[2] / PAGE_SIZE {
    //     add_free(start_ppn);
    //     start_ppn += 1;
    // }

}

pub fn add_initproc() {
    add_initproc_into_fs();
    unsafe{
        let initproc = crate::task::INITPROC.clone();
        debug_os!("ready to clone initproc");
        let proc = initproc.clone();
        debug_os!("ready to add task");
        add_task(proc);
        debug_os!("add task success");
    }
}

// if there is unhandled signal, it will automatic change trap_cx which makes it unseen in codes outside the func
pub fn perform_signal_handler(){
    let current_task = current_task().unwrap();
    // if current_task.pid.0 == 4{print!("[pid 4 1]");}
    // mask all the signals when processing signal handler
    if !current_task.is_signal_execute() && !current_task.acquire_inner_lock().siginfo.signal_pending.is_empty(){
        // if current_task.pid.0 == 4{print!("[pid 4 2]");}
        if let Some((signal, handler)) = current_task.scan_signal_handler(){
            // if current_task.pid.0 == 4{print!("[pid 4 3]");}
            if (signal == Signals::SIGTERM || signal == Signals::SIGKILL) && handler == SIG_DFL {
                // if current_task.pid.0 == 4{print!("[pid 4 4]");}
                drop(current_task);
                exit_current_and_run_next(log2(signal.bits()) as i32);
            }
        }
    }
}
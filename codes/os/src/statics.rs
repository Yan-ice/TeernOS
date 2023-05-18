use spin::*;

use alloc::sync::Arc;
use crate::task::TaskManager;

use crate::task::{TaskControlBlock, Processor};
use crate::fs::{open, OpenFlags, DiskInodeType, File};

pub struct StaticThings{
    pub MAGIC_NUM: usize,
    TASK_MANAGER: Option<Mutex<TaskManager>>,
    INITPROC: Option<Arc<TaskControlBlock>>,
    PROCESSOR_LIST: Option<[Processor; 2]>,
}

impl StaticThings{
    pub fn new() -> Self{
        Self {
            MAGIC_NUM: 2333,
            TASK_MANAGER: None,
            PROCESSOR_LIST: None,
            INITPROC: None
        }
    }
}


pub fn TASK_MANAGER() -> &'static Mutex<TaskManager>{
    let mut sf = StaticThings();
    if sf.TASK_MANAGER.is_none() {
        sf.TASK_MANAGER = Some(
            Mutex::new(TaskManager::new())
        );
    }
    (&sf.TASK_MANAGER).as_ref().unwrap()
}
pub fn PROCESSOR_LIST() -> &'static [Processor; 2]{
    let mut sf = StaticThings();
    if sf.PROCESSOR_LIST.is_none() {
        sf.PROCESSOR_LIST = Some(
            [Processor::new(),Processor::new()]
        );
    }
    (&sf.PROCESSOR_LIST).as_ref().unwrap()
}
pub fn INITPROC() -> &'static Arc<TaskControlBlock>{
    let mut sf = StaticThings();
    if sf.INITPROC.is_none() {
        sf.INITPROC = Some(
            Arc::new({
                let inode = open("/","initproc", OpenFlags::RDONLY, DiskInodeType::File).unwrap();
                let v = inode.read_all();
                TaskControlBlock::new(v.as_slice())
            })
        );
    }
    (&sf.INITPROC).as_ref().unwrap()
}


fn StaticThings() -> &'static mut StaticThings{
    extern "C"{
        fn outer_static();
    }
    unsafe{
        let statics = outer_static as usize as *mut StaticThings;
        if (*statics).MAGIC_NUM != 2333 {
            (*statics) = StaticThings::new();
        }
        &mut (*statics)
    }
}
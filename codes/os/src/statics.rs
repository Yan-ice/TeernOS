use spin::*;

use alloc::sync::Arc;
use crate::config::KMMAP_BASE;
use crate::nk::{MmapArea, VirtAddr};
use crate::task::TaskManager;

use crate::task::{TaskControlBlock, Processor};
use crate::fs::{open, OpenFlags, DiskInodeType, File};
use crate::util::MemorySet;
use crate::task::pid::PidAllocator;

pub struct StaticThings{
    pub MAGIC_NUM: usize,
    OUTER_KERNEL_SPACE: Option<Mutex<MemorySet>>,
    OUTER_MMAP_AREA: Option<Arc<Mutex<MmapArea>>>,
    TASK_MANAGER: Option<Mutex<TaskManager>>,
    INITPROC: Option<Arc<TaskControlBlock>>,
    PROCESSOR_LIST: Option<[Processor; 2]>,
    PID_ALLOCATOR : Option<Mutex<PidAllocator>>
}

impl StaticThings{
    pub fn new() -> Self{
        Self {
            MAGIC_NUM: 2333,
            OUTER_KERNEL_SPACE: None,
            OUTER_MMAP_AREA: None,
            TASK_MANAGER: None,
            PROCESSOR_LIST: None,
            INITPROC: None,
            PID_ALLOCATOR: None
        }
    }
}

pub fn OUTER_MMAP_AREA() -> &'static Mutex<MmapArea>{
    let mut sf = StaticThings();
    if sf.OUTER_MMAP_AREA.is_none() {
        sf.OUTER_MMAP_AREA = Some(
            Arc::new(Mutex::new(
                MmapArea::new(VirtAddr::from(KMMAP_BASE), VirtAddr::from(KMMAP_BASE))
            ))
        );
    }
    (&sf.OUTER_MMAP_AREA).as_ref().unwrap()
}

pub fn OUTER_KERNEL_SPACE() -> &'static Mutex<MemorySet>{
    let mut sf = StaticThings();
    if sf.OUTER_KERNEL_SPACE.is_none() {
        sf.OUTER_KERNEL_SPACE = Some(
            Mutex::new(MemorySet::new_outer_kernel())
        );
    }
    (&sf.OUTER_KERNEL_SPACE).as_ref().unwrap()
}


pub fn PID_ALLOCATOR() -> &'static Mutex<PidAllocator>{
    let mut sf = StaticThings();
    if sf.PID_ALLOCATOR.is_none() {
        sf.PID_ALLOCATOR = Some(
            Mutex::new(PidAllocator::new())
        );
    }
    (&sf.PID_ALLOCATOR).as_ref().unwrap()
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
        let inode = open("/","initproc", OpenFlags::RDONLY, DiskInodeType::File).unwrap();
        let v = inode.read_all();
        println!("read initproc file success.");
        sf.INITPROC = Some(
            Arc::new(
                TaskControlBlock::new(v.as_slice())
            )
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
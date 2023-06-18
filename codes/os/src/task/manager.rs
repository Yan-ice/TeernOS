use super::TaskControlBlock;
use alloc::collections::VecDeque;
use alloc::sync::Arc;
use spin::Mutex;
use lazy_static::*;

use crate::TASK_MANAGER;

pub struct TaskManager {
    ready_queue: VecDeque<Arc<TaskControlBlock>>,
}

/// A simple FIFO scheduler.
impl TaskManager {
    pub fn new() -> Self {
        Self { ready_queue: VecDeque::new(), }
    }
    pub fn add(&mut self, task: Arc<TaskControlBlock>) {
        self.ready_queue.push_back(task);
    }
    pub fn fetch(&mut self) -> Option<Arc<TaskControlBlock>> {
        self.ready_queue.pop_front()
    }
}

pub fn add_task(task: Arc<TaskControlBlock>) {
    unsafe{
        TASK_MANAGER().lock().add(task);
    }
    
}

pub fn fetch_task() -> Option<Arc<TaskControlBlock>> {
    unsafe{
        TASK_MANAGER().lock().fetch()
    }
    // debug_os!("core{}:fetch task",get_core_id());
}

pub fn find_task(pid:usize)->Option<Arc<TaskControlBlock>>{
    unsafe{
        let inner = TASK_MANAGER().lock();
        for task in &inner.ready_queue {
            if task.pid.0 == pid {
                return Some(task.clone())
            }
        }
        return None
    }
    
}
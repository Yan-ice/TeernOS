use crate::config::*;
use crate::shared::PROXYCONTEXT;
//use crate::nk::user_trap_return;
#[derive(Debug)]
#[repr(C)]
pub struct TaskContext {
    ra: usize,
    s: [usize; 12],
}


impl TaskContext {
    pub fn goto_trap_return() -> Self {
        unsafe{
            Self {
                ra: PROXYCONTEXT().usr_trap_return,
                //ra: user_trap_return as usize,
                s: [0; 12],
            }
        }
        
    }
}


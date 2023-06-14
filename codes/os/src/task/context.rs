use crate::config::*;
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
                ra: *((NK_TRAMPOLINE as usize + 93*8) as *const usize),
                //ra: user_trap_return as usize,
                s: [0; 12],
            }
        }
        
    }
}


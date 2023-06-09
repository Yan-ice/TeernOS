use crate::config::*;

use super::{nkapi_pt_init, nkapi_alloc, nkapi_translate_va, nkapi_dealloc, 
    nkapi_activate, nkapi_assert_eq_and_echo, nkapi_copy_to, nkapi_translate, nkapi_set_permission, nkapi_traphandle, nkapi_print_pt};


pub fn init_vec(){
    let proxy = PROXYCONTEXT();

    proxy.nkapi_enable = 1;

    proxy.nkapi_vec[NKTRAP_HANDLE] = nkapi_traphandle as usize;
    proxy.nkapi_vec[NKAPI_TEST] = nkapi_assert_eq_and_echo as usize;
    proxy.nkapi_vec[NKAPI_PT_INIT] = nkapi_pt_init as usize;
    proxy.nkapi_vec[NKAPI_ALLOC] = nkapi_alloc as usize;
    proxy.nkapi_vec[NKAPI_DEALLOC] = nkapi_dealloc as usize;
    proxy.nkapi_vec[NKAPI_ACTIVATE] = nkapi_activate as usize;
    proxy.nkapi_vec[NKAPI_COPY_TO] = nkapi_copy_to as usize;
    proxy.nkapi_vec[NKAPI_TRANSLATE] = nkapi_translate as usize;
    proxy.nkapi_vec[NKAPI_TRANSLATE_VA] = nkapi_translate_va as usize;
    proxy.nkapi_vec[NKAPI_SET_PERM] = nkapi_set_permission as usize;
    proxy.nkapi_vec[NKAPI_TIME] = nkapi_time as usize;
    proxy.nkapi_vec[NKAPI_DEBUG] = nkapi_print_pt as usize;
}

#[repr(C)]
#[derive(Debug, Clone)]
pub struct ProxyContext{
    pub nk_register: [usize; 32], //nk的寄存器
    //_+32*8
    pub outer_register: [usize; 32], //outer kernel的寄存器 注意初始化的时候把栈指针设置好
    //_+64*8
    pub nk_satp: usize, // nk的satp
    pub outer_satp: usize, // outer的satp

    //_+66*8
    pub nkapi_vec: [usize; 24],
    
    //_+90*8
    pub delegate: usize,

    //_+91*8
    pub nkapi_enable: usize
}

pub fn NKAPI_ENABLE() -> &'static mut ProxyContext{
    unsafe{ 
        &mut *(NK_TRAMPOLINE as usize 
        as *mut usize 
        as *mut ProxyContext) 
    }
}

pub fn PROXYCONTEXT() -> &'static mut ProxyContext{
    unsafe{ 
        &mut *(NK_TRAMPOLINE as usize 
        as *mut usize 
        as *mut ProxyContext) 
    }
}


fn nkapi_time() -> usize {
    let mut time:usize = 0;
    unsafe{
        asm!(
            "rdtime a0",
            inout("a0") time
        );
    }
    time
}


use crate::{config::NK_TRAMPOLINE};

use super::{nkapi_pt_init, nkapi_alloc, nkapi_translate_va, nkapi_dealloc, 
    nkapi_activate, nkapi_assert_eq_and_echo, nkapi_copy_to, nkapi_translate, nkapi_set_permission, nkapi_traphandle};
pub static mut API_ENABLE: bool = false;

///////////////////////////////////
/// 
/// the value below is NK call number.
/// 

pub const NKTRAP_HANDLE: usize = 0;
pub const NKAPI_TEST: usize = 1;
pub const NKAPI_PT_INIT: usize = 2;
pub const NKAPI_ALLOC: usize = 3;
pub const NKAPI_DEALLOC: usize = 4;
pub const NKAPI_ACTIVATE: usize = 5;
pub const NKAPI_COPY_TO: usize = 6;
pub const NKAPI_TRANSLATE: usize = 7;
pub const NKAPI_TRANSLATE_VA: usize = 10;
pub const NKAPI_SET_PERM: usize = 8;
pub const NKAPI_TIME: usize = 9;

///
///////////////////////////////////

pub fn init_vec(){
    let proxy = PROXYCONTEXT();
    
    proxy.nkapi_vec[NKTRAP_HANDLE] = nkapi_traphandle as usize;
    proxy.nkapi_vec[NKAPI_TEST] = nkapi_assert_eq_and_echo as usize;
    proxy.nkapi_vec[NKAPI_PT_INIT] = nkapi_pt_init as usize;
    proxy.nkapi_vec[NKAPI_ALLOC] = nkapi_alloc as usize;
    proxy.nkapi_vec[NKAPI_DEALLOC] = nkapi_dealloc as usize;
    proxy.nkapi_vec[NKAPI_ACTIVATE] = nkapi_activate as usize;
    proxy.nkapi_vec[NKAPI_COPY_TO] = nkapi_copy_to as usize;
    proxy.nkapi_vec[NKAPI_TRANSLATE] = nkapi_translate as usize;
    proxy.nkapi_vec[NKAPI_SET_PERM] = nkapi_set_permission as usize;
    proxy.nkapi_vec[NKAPI_TIME] = nkapi_time as usize;
    proxy.nkapi_vec[NKAPI_TRANSLATE_VA] = nkapi_translate_va as usize;

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


#[macro_export]
macro_rules! entry_gate {
    ($tar:expr) => {
        unsafe{
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize*8));
            if !crate::nk::mm::NKAPI_ENABLE {
                llvm_asm!("jal nk_bypass");
            }else{
                llvm_asm!("jal nk_entry");
            }
            // llvm_asm!("addi sp, sp, -8*6");
            // llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize*8));
            // llvm_asm!("jal nk_entry");
        }
    };
    ($tar:expr,$t1:expr) => {
        unsafe{
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     return $tar($t1);
            // }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize*8));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            if !crate::nk::mm::NKAPI_ENABLE {
                llvm_asm!("jal nk_bypass");
            }else{
                llvm_asm!("jal nk_entry");
            }
        }
    };
    ($tar:expr,$t1:expr,$t2:expr) => {
        unsafe{
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     return $tar($t1,$t2);
            // }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize*8));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            llvm_asm!("sd $0, 16(sp)" :: "r"(usize::from($t2)));
            if !crate::nk::mm::NKAPI_ENABLE {
                llvm_asm!("jal nk_bypass");
            }else{
                llvm_asm!("jal nk_entry");
            }
        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$t3:expr) => {
        unsafe{
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     return $tar($t1,$t2,$t3);
            // }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize*8));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            llvm_asm!("sd $0, 16(sp)" :: "r"(usize::from($t2)));
            llvm_asm!("sd $0, 24(sp)" :: "r"(usize::from($t3)));
            if !crate::nk::mm::NKAPI_ENABLE {
                llvm_asm!("jal nk_bypass");
            }else{
                llvm_asm!("jal nk_entry");
            }
        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$t3:expr,$t4:expr) => {
        unsafe{
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     return $tar($t1,$t2,$t3,$t4);
            // }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize*8));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            llvm_asm!("sd $0, 16(sp)" :: "r"(usize::from($t2)));
            llvm_asm!("sd $0, 24(sp)" :: "r"(usize::from($t3)));
            llvm_asm!("sd $0, 32(sp)" :: "r"(usize::from($t4)));
            if !crate::nk::mm::NKAPI_ENABLE {
                llvm_asm!("jal nk_bypass");
            }else{
                llvm_asm!("jal nk_entry");
            }
        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$t3:expr,$t4:expr,$t5:expr) => {
        unsafe{
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     return $tar($t1,$t2,$t3,$t4,$t5);
            // }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize*8));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            llvm_asm!("sd $0, 16(sp)" :: "r"(usize::from($t2)));
            llvm_asm!("sd $0, 24(sp)" :: "r"(usize::from($t3)));
            llvm_asm!("sd $0, 32(sp)" :: "r"(usize::from($t4)));
            llvm_asm!("sd $0, 40(sp)" :: "r"(usize::from($t5)));
            if !crate::nk::mm::NKAPI_ENABLE {
                llvm_asm!("jal nk_bypass");
            }else{
                llvm_asm!("jal nk_entry");
            }
        }
    };
}

#[macro_export]
macro_rules! return_void {
    () => {
        return;
    };
}

#[macro_export]
macro_rules! return_ref {
    ($type:ty) => {
        unsafe{
            let retval: usize;
            llvm_asm!("mv $0, x10" : "=r"(retval));
            let cast: *mut $type = retval as *const usize as *mut $type;
            return (*cast).clone();
        }
    };
}

#[macro_export]
macro_rules! return_value {
    ($type:ty) => {
        unsafe{
            let retval: usize;
            llvm_asm!("mv $0, x10" : "=r"(retval));
            let cast: $type = <$type>::from(retval);
            return cast;
        }
    };
}

#[macro_export]
macro_rules! return_some {
    ($type:ty) => {
        unsafe{
            let is_none: usize;
            let retval: usize;
            llvm_asm!("mv $0, x10" : "=r"(is_none));
            llvm_asm!("mv $0, x11" : "=r"(retval));
            if is_none == 0{
                return None;
            }
            let cast: $type = <$type>::from(retval);
            return Some(cast);
        }
    };
}

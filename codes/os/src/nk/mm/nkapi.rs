
pub static mut API_ENABLE: bool = false;

#[macro_export]
macro_rules! entry_gate {
    ($tar:expr) => {
        unsafe{
            if !crate::nk::mm::NKAPI_ENABLE {
                return $tar();
            }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize));
            llvm_asm!("jal nk_entry");
        }
    };
    ($tar:expr,$t1:expr) => {
        unsafe{
            if !crate::nk::mm::NKAPI_ENABLE {
                return $tar($t1);
            }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            llvm_asm!("jal x1, nk_entry");
        }
    };
    ($tar:expr,$t1:expr,$t2:expr) => {
        unsafe{
            if !crate::nk::mm::NKAPI_ENABLE {
                return $tar($t1,$t2);
            }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            llvm_asm!("sd $0, 16(sp)" :: "r"(usize::from($t2)));
            llvm_asm!("jal x1, nk_entry");
        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$t3:expr) => {
        unsafe{
            if !crate::nk::mm::NKAPI_ENABLE {
                return $tar($t1,$t2,$t3);
            }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            llvm_asm!("sd $0, 16(sp)" :: "r"(usize::from($t2)));
            llvm_asm!("sd $0, 24(sp)" :: "r"(usize::from($t3)));
            llvm_asm!("jal x1, nk_entry");
        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$t3:expr,$t4:expr) => {
        unsafe{
            if !crate::nk::mm::NKAPI_ENABLE {
                return $tar($t1,$t2,$t3,$t4);
            }
            println!("cast: {:?} -> {:x}",$t3, usize::from($t3));
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            llvm_asm!("sd $0, 16(sp)" :: "r"(usize::from($t2)));
            llvm_asm!("sd $0, 24(sp)" :: "r"(usize::from($t3)));
            llvm_asm!("sd $0, 32(sp)" :: "r"(usize::from($t4)));
            llvm_asm!("jal x1, nk_entry");
        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$t3:expr,$t4:expr,$t5:expr) => {
        unsafe{
            if !crate::nk::mm::NKAPI_ENABLE {
                return $tar($t1,$t2,$t3,$t4,$t5);
            }
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize));
            llvm_asm!("sd $0, 8(sp)" :: "r"(usize::from($t1)));
            llvm_asm!("sd $0, 16(sp)" :: "r"(usize::from($t2)));
            llvm_asm!("sd $0, 24(sp)" :: "r"(usize::from($t3)));
            llvm_asm!("sd $0, 32(sp)" :: "r"(usize::from($t4)));
            llvm_asm!("sd $0, 40(sp)" :: "r"(usize::from($t5)));
            llvm_asm!("jal x1, nk_entry");
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
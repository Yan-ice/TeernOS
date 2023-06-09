
pub fn nkapi_time() -> usize{
    entry_gate!(nkapi::NKAPI_TIME);
    return_value!(usize);
}

pub fn nkapi_translate(pt_handle: usize, vpn:VirtPageNum, write: bool) -> Option<PhysPageNum>{
    entry_gate!(nkapi::NKAPI_TRANSLATE,pt_handle,vpn,write);
    return_some!(PhysPageNum);
}

pub fn nkapi_translate_va(pt_handle: usize, va: VirtAddr) -> Option<PhysAddr>{
    // if let Some(ppn) = nkapi_translate(pt_handle,va.clone().floor(),false) {
    //     let pa: PhysAddr = PhysAddr{0: ppn.0*crate::config::PAGE_SIZE + va.page_offset()};
    //     return Some(pa);
    // }
    // None
    entry_gate!(nkapi::NKAPI_TRANSLATE_VA,pt_handle,va);
    return_some!(PhysAddr);
}

pub fn nkapi_alloc(pt_handle:usize, vpn: VirtPageNum, map_type: MapType, perm: MapPermission)-> PhysPageNum{
    entry_gate!(nkapi::NKAPI_ALLOC, pt_handle, vpn, usize::from(map_type), perm);
    return_value!(PhysPageNum);
}

pub fn nkapi_pt_init(pt_handle: usize, regenerate: bool){
    entry_gate!(nkapi::NKAPI_PT_INIT,pt_handle, regenerate);
    return_void!();
}

pub fn nkapi_dealloc(pt_handle: usize, vpn: VirtPageNum){
    entry_gate!(nkapi::NKAPI_DEALLOC, pt_handle, vpn);
    return_void!();
}

pub fn nkapi_activate(pt_handle: usize){
    entry_gate!(nkapi::NKAPI_ACTIVATE, pt_handle);
    return_void!();
}

pub fn nkapi_copyTo(pt_handle: usize, mut current_vpn: VirtPageNum, data: &[u8], offset:usize){
    entry_gate!(nkapi::NKAPI_COPY_TO,pt_handle, current_vpn, data as *const [u8] as *const usize as usize, offset);
    return_void!();
}

pub fn nkapi_traphandler(ctx: &TrapContext){
    entry_gate!(nkapi::NKTRAP_HANDLE, ctx as *const TrapContext as *const usize as usize);
    return_void!();
}

pub fn nkapi_set_permission(pt_handle: usize, vpn:VirtPageNum, flags: usize){
    entry_gate!(nkapi::NKAPI_SET_PERM, pt_handle, vpn, flags);
    return_void!();
}

pub fn nkapi_print_pt(pt_handle: usize, from: usize, to: usize){
    entry_gate!(nkapi::NKAPI_DEBUG, pt_handle, from, to);
    return_void!();
}



#[macro_export]
macro_rules! entry_gate {
    ($tar:expr) => {
        unsafe{
            llvm_asm!("addi sp, sp, -8*6");
            llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize*8));
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     llvm_asm!("jal nk_bypass");
            // }else{
            //     llvm_asm!("jal nk_entry");
            // }
            // llvm_asm!("addi sp, sp, -8*6");
            // llvm_asm!("sd $0, 0(sp)" :: "r"($tar as usize*8));
            llvm_asm!("jal nk_entry");
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
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     llvm_asm!("jal nk_bypass");
            // }else{
                 llvm_asm!("jal nk_entry");
            // }
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
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     llvm_asm!("jal nk_bypass");
            // }else{
                 llvm_asm!("jal nk_entry");
            // }
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
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     llvm_asm!("jal nk_bypass");
            // }else{
                 llvm_asm!("jal nk_entry");
            // }
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
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     llvm_asm!("jal nk_bypass");
            // }else{
                 llvm_asm!("jal nk_entry");
            // }
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
            // if !crate::nk::mm::NKAPI_ENABLE {
            //     llvm_asm!("jal nk_bypass");
            // }else{
                 llvm_asm!("jal nk_entry");
            // }
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

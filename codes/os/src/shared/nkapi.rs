use crate::shared::*;
use crate::shared::config::*;

macro_rules! return_void {
    () => {
        return;
    };
}

macro_rules! return_ref {
    ($type:ty, $retval0:expr) => {
        unsafe{
            let cast: *mut $type = $retval0 as *const usize as *mut $type;
            return (*cast).clone();
        }
    };
}


macro_rules! return_value {
    ($type:ty, $retval0:expr) => {
        unsafe{
            let cast: $type = <$type>::from($retval0);
            return cast;
        }
    };
}

macro_rules! return_some {
    ($type:ty, $retval0:expr, $retval1:expr) => {
        unsafe{
            if $retval0 == 0{
                return None;
            }
            let cast: $type = <$type>::from($retval1);
            return Some(cast);
        }
    };
}

macro_rules! entry_gate {
    ($tar:expr,$retval0: expr, $retval1: expr) => {
        unsafe{
            asm!(
                "jal nk_entry",
                in("a0") $tar as usize*8,
                lateout("a0") $retval0,
                lateout("a1") $retval1,
            );
        }
    };
    ($tar:expr,$t1:expr,$retval0: expr, $retval1: expr) => {
        unsafe{
            asm!(
                "jal nk_entry",
                in("a0") $tar as usize*8,
                in("a1") usize::from($t1),
                lateout("a0") $retval0,
                lateout("a1") $retval1,
            );

            if usize::from($t1) > 2000 {
                println!("t1: {}",usize::from($t1));
            }

        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$retval0: expr, $retval1: expr) => {
        unsafe{
            asm!(
                "jal nk_entry",
                in("a0") $tar as usize*8,
                in("a1") usize::from($t1),
                in("a2") usize::from($t2),
                lateout("a0") $retval0,
                lateout("a1") $retval1,
            );

            if usize::from($t1) > 2000 {
                println!("t1: {}",usize::from($t1));
            }

        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$t3:expr,$retval0: expr, $retval1: expr) => {
        unsafe{
            asm!(
                "jal nk_entry",
                in("a0") $tar as usize*8,
                in("a1") usize::from($t1),
                in("a2") usize::from($t2),
                in("a3") usize::from($t3),
                lateout("a0") $retval0,
                lateout("a1") $retval1,
            );

            if usize::from($t1) > 2000 {
                println!("t1: {}",usize::from($t1));
            }

        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$t3:expr,$t4:expr,$retval0: expr, $retval1: expr) => {
        unsafe{

            asm!(
                "jal nk_entry",
                in("a0") $tar as usize*8,
                in("a1") usize::from($t1),
                in("a2") usize::from($t2),
                in("a3") usize::from($t3),
                in("a4") usize::from($t4),
                lateout("a0") $retval0,
                lateout("a1") $retval1,
            );

            if usize::from($t1) > 2000 {
                println!("t1: {}",usize::from($t1));
            }

        }
    };
    ($tar:expr,$t1:expr,$t2:expr,$t3:expr,$t4:expr,$t5:expr,$retval0: expr, $retval1: expr) => {
        unsafe{
            asm!(
                "jal nk_entry",
                in("a0") $tar as usize*8,
                in("a1") usize::from($t1),
                in("a2") usize::from($t2),
                in("a3") usize::from($t3),
                in("a4") usize::from($t4),
                in("a5") usize::from($t5),
                lateout("a0") $retval0,
                lateout("a1") $retval1,
            );

            if usize::from($t1) > 2000 {
                println!("t1: {}",usize::from($t1));
            }

        }
    };
}



pub fn nkapi_time() -> usize{
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_TIME, retval0, retval1);
    return retval0;
}

pub fn nkapi_translate(pt_handle: usize, vpn:VirtPageNum, write: bool) -> Option<PhysPageNum>{
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_TRANSLATE,pt_handle,vpn,write, retval0, retval1);
    return_some!(PhysPageNum,retval0,retval1);
}

pub fn nkapi_translate_va(pt_handle: usize, va: VirtAddr) -> Option<PhysAddr>{
    // if let Some(ppn) = nkapi_translate(pt_handle,va.clone().floor(),false) {
    //     let pa: PhysAddr = PhysAddr{0: ppn.0*crate::config::PAGE_SIZE + va.page_offset()};
    //     return Some(pa);
    // }
    // None
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_TRANSLATE_VA,pt_handle,va, retval0, retval1);
    return_some!(PhysAddr,retval0,retval1);

}

pub fn nkapi_alloc(pt_handle: usize, vpn: VirtPageNum, map_type: MapType, perm: MapPermission)-> PhysPageNum{
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_ALLOC, pt_handle, vpn, usize::from(map_type), perm, 
    retval0, retval1);
    return retval0.into();
}

pub fn nkapi_pt_init(pt_handle: usize, regenerate: bool){
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_PT_INIT,pt_handle, regenerate,retval0, retval1);
}

pub fn nkapi_dealloc(pt_handle: usize, vpn: VirtPageNum){
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_DEALLOC, pt_handle, vpn,retval0, retval1);
}

pub fn nkapi_activate(pt_handle: usize){
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_ACTIVATE, pt_handle ,retval0, retval1);
}

pub fn nkapi_copyTo(pt_handle: usize, mut current_vpn: VirtPageNum, data: &[u8], offset:usize){
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_COPY_TO,pt_handle, current_vpn, 
        data as *const [u8] as *const usize as usize, offset, retval0, retval1);
}

pub fn nkapi_traphandler(ctx: &TrapContext){
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_TRAP_HANDLE, ctx as *const TrapContext as *const usize as usize,
        retval0, retval1);
}

pub fn nkapi_set_delegate_handler(entry: usize){
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_CONFIG, NKCFG_DELEGATE, entry,
        retval0, retval1);
}

pub fn nkapi_set_signal_handler(entry: usize){
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_CONFIG, NKCFG_SIGNAL, entry,
        retval0, retval1);
}

pub fn nkapi_set_permission(pt_handle: usize, vpn:VirtPageNum, flags: usize){
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_SET_PERM, pt_handle, vpn, flags,retval0, retval1);
}

pub fn nkapi_print_pt(pt_handle: usize, from: usize, to: usize){
    let retval0: usize;
    let retval1: usize;
    entry_gate!(NKAPI_DEBUG, pt_handle, from, to ,retval0, retval1);
}



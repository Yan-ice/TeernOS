const SYSCALL_GETKEY: usize = 401;

use riscv::register::{
    mtvec::TrapMode,
    scause::{
        self,
        Trap,
        Exception,
        Interrupt,
    },
    stval,
    stvec, hpmcounter21::read
};

use crate::{shared::*, mm::pt_current};
use crate::config::*;

///
/// trap in NK would be handled here.
/// 
pub fn nk_trap_handler(mut ctx_addr: usize) -> usize {
    ctx_addr = TRAP_CONTEXT;
    debug_info!("handle nk trap for [{}]", pt_current());
    if let Some(pa) = nkapi_translate_va(pt_current(), ctx_addr.into()){
        unsafe{
            let ctx: &mut TrapContext = &mut *(pa.0 as *mut TrapContext); 
            ctx.sepc += 4;
            return nk_syscall_impl(ctx);
        }
    }else{
        panic!("invalid trap context!");
    }
}

pub fn nk_syscall_impl(ctx: &mut TrapContext) -> usize {
    // let stval = stval::read();
    let call_id: usize = ctx.x[17];
    if call_id == 401{
        // let mut hasher = XxHash64::default();
        unsafe{
            // let start = 0x80800000;
            // let end = 0x840000001;
            // for i in start..end{
            //     let temp = *(i as usize as *const usize);
            // }
            // ctx.x[10] = 1;
        }
    }
    debug_warn!("Nothing need to handle now... for syscall id [{}]", call_id);
    return 0;
}



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

use tiny_keccak::Hasher;
use tiny_keccak::Sha3;
use alloc::format;

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

    match call_id {
        401 => {
            ctx.x[10] = get_measure();
        }
        402 =>{

        }
        _=>{debug_warn!("Unsupported syscall id [{}]", call_id);}
    }

    
    return 0;
}

fn get_measure() -> usize{
    let mut hasher = Sha3::v256();
    unsafe{
        let start: usize= 0x80800000;
        let end: usize = 0x840000001;
        for i in start..end{
            let temp = *(i as usize as *const usize);
            hasher.update((&format!("{}", temp)).as_bytes());
        }
        let mut result = [0u8; 32];
        hasher.finalize(&mut result);

        let mut hash = [0u8; 8];
        hash.copy_from_slice(&result[..8]);
        return u64::from_le_bytes(hash) as usize;
    }
}



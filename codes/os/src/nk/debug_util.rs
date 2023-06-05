
use riscv::{register::{satp}, addr::PhysAddr};
use crate::nk::{PROXYCONTEXT};
use core::slice::{from_raw_parts};

#[macro_use]

extern "C"{
    pub fn save_context();
}

#[macro_export]
macro_rules! debug_current_reg{
    () => {
        debug_info!("============[debug]=============");
        debug_info!("[debug] current reg info:");
        debug_info!("SATP: {:?}",satp::read());
        let sp: usize;
        unsafe {
            llvm_asm!("mv $0, sp" : "=r"(sp));
        }
        debug_info!("sp: {:x}",sp);
        debug_info!("================================");
    };
}

#[macro_export]
macro_rules! debug_context_info{
    () => {
        unsafe{
            debug_info!("============[debug]=============");
            debug_info!("[debug] nk proxy context info:");
            debug_info!("SATP: {}",PROXYCONTEXT().nk_satp);
            debug_info!("sp: {:x}",PROXYCONTEXT().nk_register[2]);
        
            debug_info!("[debug] ok proxy context info:");
            debug_info!("SATP: {}",PROXYCONTEXT().outer_satp);
            debug_info!("sp: {:x}",PROXYCONTEXT().outer_register[2]);
            debug_info!("================================");
        }
    };
}

#[macro_export]
macro_rules! debug_stack_info{
    () => {
        let mut val: usize = 0x99;
        unsafe{
        debug_info!("============[debug]=============");
        debug_info!("[debug] stack info:");
        llvm_asm!("ld $0, 0(sp)" : "=r"(val));
        debug_info!("0x00: {:x}",val);
        llvm_asm!("ld $0, 1*8(sp)" : "=r"(val));
        debug_info!("0x08: {:x}",val);
        llvm_asm!("ld $0, 2*8(sp)" : "=r"(val));
        debug_info!("0x10: {:x}",val);
        llvm_asm!("ld $0, 3*8(sp)" : "=r"(val));
        debug_info!("0x18: {:x}",val);
        llvm_asm!("ld $0, 4*8(sp)" : "=r"(val));
        debug_info!("0x20: {:x}",val);
        llvm_asm!("ld $0, 5*8(sp)" : "=r"(val));
        debug_info!("0x28: {:x}",val);
        llvm_asm!("ld $0, 6*8(sp)" : "=r"(val));
        debug_info!("0x30: {:x}",val);
        llvm_asm!("ld $0, 7*8(sp)" : "=r"(val));
        debug_info!("0x38: {:x}",val);
        llvm_asm!("ld $0, 8*8(sp)" : "=r"(val));
        debug_info!("0x40: {:x}",val);

        llvm_asm!("ld $0, 9*8(sp)" : "=r"(val));
        debug_info!("0x48: {:x}",val);
        llvm_asm!("ld $0, 10*8(sp)" : "=r"(val));
        debug_info!("0x50: {:x}",val);
        llvm_asm!("ld $0, 11*8(sp)" : "=r"(val));
        debug_info!("0x58: {:x}",val);
        llvm_asm!("ld $0, 12*8(sp)" : "=r"(val));
        debug_info!("0x60: {:x}",val);
        llvm_asm!("ld $0, 13*8(sp)" : "=r"(val));
        debug_info!("0x68: {:x}",val);
        llvm_asm!("ld $0, 14*8(sp)" : "=r"(val));
        debug_info!("0x70: {:x}",val);
        llvm_asm!("ld $0, 15*8(sp)" : "=r"(val));
        debug_info!("0x78: {:x}",val);
        llvm_asm!("ld $0, 16*8(sp)" : "=r"(val));
        debug_info!("0x80: {:x}",val);

        llvm_asm!("ld $0, 17*8(sp)" : "=r"(val));
        debug_info!("0x88: {:x}",val);
        llvm_asm!("ld $0, 18*8(sp)" : "=r"(val));
        debug_info!("0x90: {:x}",val);
        llvm_asm!("ld $0, 19*8(sp)" : "=r"(val));
        debug_info!("0x98: {:x}",val);
        llvm_asm!("ld $0, 20*8(sp)" : "=r"(val));
        debug_info!("0xa0: {:x}",val);
        llvm_asm!("ld $0, 21*8(sp)" : "=r"(val));
        debug_info!("0xa8: {:x}",val);
        llvm_asm!("ld $0, 22*8(sp)" : "=r"(val));
        debug_info!("0xb0: {:x}",val);
        llvm_asm!("ld $0, 23*8(sp)" : "=r"(val));
        debug_info!("0xb8: {:x}",val);
        llvm_asm!("ld $0, 24*8(sp)" : "=r"(val));
        debug_info!("0xc0: {:x}",val);

        llvm_asm!("ld $0, 25*8(sp)" : "=r"(val));
        debug_info!("0xc8: {:x}",val);
        llvm_asm!("ld $0, 26*8(sp)" : "=r"(val));
        debug_info!("0xd0: {:x}",val);
        llvm_asm!("ld $0, 27*8(sp)" : "=r"(val));
        debug_info!("0xd8: {:x}",val);
        llvm_asm!("ld $0, 28*8(sp)" : "=r"(val));
        debug_info!("0xe0: {:x}",val);
        llvm_asm!("ld $0, 29*8(sp)" : "=r"(val));
        debug_info!("0xe8: {:x}",val);
        llvm_asm!("ld $0, 30*8(sp)" : "=r"(val));
    }
    };
}

#[macro_export]
macro_rules! debug_all_registers{
    () => {
        let mut val: usize = 0;
        unsafe{
            save_context();
            debug_info!("============[debug]=============");
            debug_info!("[debug] register info:");
            llvm_asm!("ld $0, 0(sp)" : "=r"(val));
            debug_info!("x0: {:x}",val);
            llvm_asm!("ld $0, -1*8(sp)" : "=r"(val));
            debug_info!("x1: {:x}",val);
            llvm_asm!("ld $0, -2*8(sp)" : "=r"(val));
            debug_info!("x2: {:x}",val);
            llvm_asm!("ld $0, -3*8(sp)" : "=r"(val));
            debug_info!("x3: {:x}",val);
            llvm_asm!("ld $0, -4*8(sp)" : "=r"(val));
            debug_info!("x4: {:x}",val);
            llvm_asm!("ld $0, -5*8(sp)" : "=r"(val));
            debug_info!("x5: {:x}",val);
            llvm_asm!("ld $0, -6*8(sp)" : "=r"(val));
            debug_info!("0x30: {:x}",val);
            llvm_asm!("ld $0, -7*8(sp)" : "=r"(val));
            debug_info!("0x38: {:x}",val);
            llvm_asm!("ld $0, -8*8(sp)" : "=r"(val));
            debug_info!("0x40: {:x}",val);
    
            llvm_asm!("ld $0, -9*8(sp)" : "=r"(val));
            debug_info!("0x48: {:x}",val);
            llvm_asm!("ld $0, -10*8(sp)" : "=r"(val));
            debug_info!("x10: {:x}",val);
            llvm_asm!("ld $0, -11*8(sp)" : "=r"(val));
            debug_info!("0x58: {:x}",val);
            llvm_asm!("ld $0, -12*8(sp)" : "=r"(val));
            debug_info!("0x60: {:x}",val);
            llvm_asm!("ld $0, -13*8(sp)" : "=r"(val));
            debug_info!("0x68: {:x}",val);
            llvm_asm!("ld $0, -14*8(sp)" : "=r"(val));
            debug_info!("0x70: {:x}",val);
            llvm_asm!("ld $0, -15*8(sp)" : "=r"(val));
            debug_info!("x15: {:x}",val);
            llvm_asm!("ld $0, -16*8(sp)" : "=r"(val));
            debug_info!("0x80: {:x}",val);
    
            llvm_asm!("ld $0, -17*8(sp)" : "=r"(val));
            debug_info!("0x88: {:x}",val);
            llvm_asm!("ld $0, -18*8(sp)" : "=r"(val));
            debug_info!("0x90: {:x}",val);
            llvm_asm!("ld $0, -19*8(sp)" : "=r"(val));
            debug_info!("0x98: {:x}",val);
            llvm_asm!("ld $0, -20*8(sp)" : "=r"(val));
            debug_info!("x20: {:x}",val);
            llvm_asm!("ld $0, -21*8(sp)" : "=r"(val));
            debug_info!("0xa8: {:x}",val);
            llvm_asm!("ld $0, -22*8(sp)" : "=r"(val));
            debug_info!("0xb0: {:x}",val);
            llvm_asm!("ld $0, -23*8(sp)" : "=r"(val));
            debug_info!("0xb8: {:x}",val);
            llvm_asm!("ld $0, -24*8(sp)" : "=r"(val));
            debug_info!("0xc0: {:x}",val);
    
            llvm_asm!("ld $0, -25*8(sp)" : "=r"(val));
            debug_info!("x25: {:x}",val);
            llvm_asm!("ld $0, -26*8(sp)" : "=r"(val));
            debug_info!("0xd0: {:x}",val);
            llvm_asm!("ld $0, -27*8(sp)" : "=r"(val));
            debug_info!("0xd8: {:x}",val);
            llvm_asm!("ld $0, -28*8(sp)" : "=r"(val));
            debug_info!("0xe0: {:x}",val);
            llvm_asm!("ld $0, -29*8(sp)" : "=r"(val));
            debug_info!("0xe8: {:x}",val);
            llvm_asm!("ld $0, -30*8(sp)" : "=r"(val));
            debug_info!("x30: {:x}",val);
    
        }
    };
}

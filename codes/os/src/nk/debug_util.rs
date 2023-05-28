
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
        println!("============[debug]=============");
        println!("[debug] current reg info:");
        println!("SATP: {:?}",satp::read());
        let sp: usize;
        unsafe {
            llvm_asm!("mv $0, sp" : "=r"(sp));
        }
        println!("sp: {:x}",sp);
        println!("================================");
    };
}

#[macro_export]
macro_rules! debug_context_info{
    () => {
        unsafe{
            println!("============[debug]=============");
            println!("[debug] nk proxy context info:");
            println!("SATP: {}",PROXYCONTEXT().nk_satp);
            println!("sp: {:x}",PROXYCONTEXT().nk_register[2]);
        
            println!("[debug] ok proxy context info:");
            println!("SATP: {}",PROXYCONTEXT().outer_satp);
            println!("sp: {:x}",PROXYCONTEXT().outer_register[2]);
            println!("================================");
        }
    };
}

#[macro_export]
macro_rules! debug_stack_info{
    () => {
        let mut val: usize = 0x99;
        unsafe{
        println!("============[debug]=============");
        println!("[debug] stack info:");
        llvm_asm!("ld $0, 0(sp)" : "=r"(val));
        println!("0x00: {:x}",val);
        llvm_asm!("ld $0, 1*8(sp)" : "=r"(val));
        println!("0x08: {:x}",val);
        llvm_asm!("ld $0, 2*8(sp)" : "=r"(val));
        println!("0x10: {:x}",val);
        llvm_asm!("ld $0, 3*8(sp)" : "=r"(val));
        println!("0x18: {:x}",val);
        llvm_asm!("ld $0, 4*8(sp)" : "=r"(val));
        println!("0x20: {:x}",val);
        llvm_asm!("ld $0, 5*8(sp)" : "=r"(val));
        println!("0x28: {:x}",val);
        llvm_asm!("ld $0, 6*8(sp)" : "=r"(val));
        println!("0x30: {:x}",val);
        llvm_asm!("ld $0, 7*8(sp)" : "=r"(val));
        println!("0x38: {:x}",val);
        llvm_asm!("ld $0, 8*8(sp)" : "=r"(val));
        println!("0x40: {:x}",val);

        llvm_asm!("ld $0, 9*8(sp)" : "=r"(val));
        println!("0x48: {:x}",val);
        llvm_asm!("ld $0, 10*8(sp)" : "=r"(val));
        println!("0x50: {:x}",val);
        llvm_asm!("ld $0, 11*8(sp)" : "=r"(val));
        println!("0x58: {:x}",val);
        llvm_asm!("ld $0, 12*8(sp)" : "=r"(val));
        println!("0x60: {:x}",val);
        llvm_asm!("ld $0, 13*8(sp)" : "=r"(val));
        println!("0x68: {:x}",val);
        llvm_asm!("ld $0, 14*8(sp)" : "=r"(val));
        println!("0x70: {:x}",val);
        llvm_asm!("ld $0, 15*8(sp)" : "=r"(val));
        println!("0x78: {:x}",val);
        llvm_asm!("ld $0, 16*8(sp)" : "=r"(val));
        println!("0x80: {:x}",val);

        llvm_asm!("ld $0, 17*8(sp)" : "=r"(val));
        println!("0x88: {:x}",val);
        llvm_asm!("ld $0, 18*8(sp)" : "=r"(val));
        println!("0x90: {:x}",val);
        llvm_asm!("ld $0, 19*8(sp)" : "=r"(val));
        println!("0x98: {:x}",val);
        llvm_asm!("ld $0, 20*8(sp)" : "=r"(val));
        println!("0xa0: {:x}",val);
        llvm_asm!("ld $0, 21*8(sp)" : "=r"(val));
        println!("0xa8: {:x}",val);
        llvm_asm!("ld $0, 22*8(sp)" : "=r"(val));
        println!("0xb0: {:x}",val);
        llvm_asm!("ld $0, 23*8(sp)" : "=r"(val));
        println!("0xb8: {:x}",val);
        llvm_asm!("ld $0, 24*8(sp)" : "=r"(val));
        println!("0xc0: {:x}",val);

        llvm_asm!("ld $0, 25*8(sp)" : "=r"(val));
        println!("0xc8: {:x}",val);
        llvm_asm!("ld $0, 26*8(sp)" : "=r"(val));
        println!("0xd0: {:x}",val);
        llvm_asm!("ld $0, 27*8(sp)" : "=r"(val));
        println!("0xd8: {:x}",val);
        llvm_asm!("ld $0, 28*8(sp)" : "=r"(val));
        println!("0xe0: {:x}",val);
        llvm_asm!("ld $0, 29*8(sp)" : "=r"(val));
        println!("0xe8: {:x}",val);
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
            println!("============[debug]=============");
            println!("[debug] register info:");
            llvm_asm!("ld $0, 0(sp)" : "=r"(val));
            println!("x0: {:x}",val);
            llvm_asm!("ld $0, -1*8(sp)" : "=r"(val));
            println!("x1: {:x}",val);
            llvm_asm!("ld $0, -2*8(sp)" : "=r"(val));
            println!("x2: {:x}",val);
            llvm_asm!("ld $0, -3*8(sp)" : "=r"(val));
            println!("x3: {:x}",val);
            llvm_asm!("ld $0, -4*8(sp)" : "=r"(val));
            println!("x4: {:x}",val);
            llvm_asm!("ld $0, -5*8(sp)" : "=r"(val));
            println!("x5: {:x}",val);
            llvm_asm!("ld $0, -6*8(sp)" : "=r"(val));
            println!("0x30: {:x}",val);
            llvm_asm!("ld $0, -7*8(sp)" : "=r"(val));
            println!("0x38: {:x}",val);
            llvm_asm!("ld $0, -8*8(sp)" : "=r"(val));
            println!("0x40: {:x}",val);
    
            llvm_asm!("ld $0, -9*8(sp)" : "=r"(val));
            println!("0x48: {:x}",val);
            llvm_asm!("ld $0, -10*8(sp)" : "=r"(val));
            println!("x10: {:x}",val);
            llvm_asm!("ld $0, -11*8(sp)" : "=r"(val));
            println!("0x58: {:x}",val);
            llvm_asm!("ld $0, -12*8(sp)" : "=r"(val));
            println!("0x60: {:x}",val);
            llvm_asm!("ld $0, -13*8(sp)" : "=r"(val));
            println!("0x68: {:x}",val);
            llvm_asm!("ld $0, -14*8(sp)" : "=r"(val));
            println!("0x70: {:x}",val);
            llvm_asm!("ld $0, -15*8(sp)" : "=r"(val));
            println!("x15: {:x}",val);
            llvm_asm!("ld $0, -16*8(sp)" : "=r"(val));
            println!("0x80: {:x}",val);
    
            llvm_asm!("ld $0, -17*8(sp)" : "=r"(val));
            println!("0x88: {:x}",val);
            llvm_asm!("ld $0, -18*8(sp)" : "=r"(val));
            println!("0x90: {:x}",val);
            llvm_asm!("ld $0, -19*8(sp)" : "=r"(val));
            println!("0x98: {:x}",val);
            llvm_asm!("ld $0, -20*8(sp)" : "=r"(val));
            println!("x20: {:x}",val);
            llvm_asm!("ld $0, -21*8(sp)" : "=r"(val));
            println!("0xa8: {:x}",val);
            llvm_asm!("ld $0, -22*8(sp)" : "=r"(val));
            println!("0xb0: {:x}",val);
            llvm_asm!("ld $0, -23*8(sp)" : "=r"(val));
            println!("0xb8: {:x}",val);
            llvm_asm!("ld $0, -24*8(sp)" : "=r"(val));
            println!("0xc0: {:x}",val);
    
            llvm_asm!("ld $0, -25*8(sp)" : "=r"(val));
            println!("x25: {:x}",val);
            llvm_asm!("ld $0, -26*8(sp)" : "=r"(val));
            println!("0xd0: {:x}",val);
            llvm_asm!("ld $0, -27*8(sp)" : "=r"(val));
            println!("0xd8: {:x}",val);
            llvm_asm!("ld $0, -28*8(sp)" : "=r"(val));
            println!("0xe0: {:x}",val);
            llvm_asm!("ld $0, -29*8(sp)" : "=r"(val));
            println!("0xe8: {:x}",val);
            llvm_asm!("ld $0, -30*8(sp)" : "=r"(val));
            println!("x30: {:x}",val);
    
        }
    };
}

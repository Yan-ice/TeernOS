
use riscv::{register::{satp}, addr::PhysAddr};
use crate::nk::{PROXYCONTEXT};
use core::slice::{from_raw_parts};

pub fn debug_register_info(){
    println!("============[debug]=============");
    println!("[debug] current reg info:");
    println!("SATP: {:?}",satp::read());
    let sp: usize;
    unsafe {
        llvm_asm!("mv $0, sp" : "=r"(sp));
    }
    println!("sp: {:x}",sp);
    println!("================================");
}

pub fn debug_context_info(){
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
}
pub fn debug_stack_content(){
    let mut val: usize = 0;
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
    }
}
pub fn debug_all_registers(){
    let mut val: usize = 0;
    unsafe{
        println!("============[debug]=============");
        println!("[debug] all reg info:");
        llvm_asm!("mv $0, x1" : "=r"(val));
        println!("x1: {:x}",val);
        llvm_asm!("mv $0, x2" : "=r"(val));
        println!("x2: {:x}",val);
        llvm_asm!("mv $0, x3" : "=r"(val));
        println!("x3: {:x}",val);
        llvm_asm!("mv $0, x4" : "=r"(val));
        println!("x4: {:x}",val);
        llvm_asm!("mv $0, x5" : "=r"(val));
        println!("x5: {:x}",val);
        llvm_asm!("mv $0, x6" : "=r"(val));
        println!("x6: {:x}",val);
        llvm_asm!("mv $0, x7" : "=r"(val));
        println!("x7: {:x}",val);
        llvm_asm!("mv $0, x8" : "=r"(val));
        println!("x8: {:x}",val);
        llvm_asm!("mv $0, x9" : "=r"(val));
        println!("x9: {:x}",val);
        llvm_asm!("mv $0, x10" : "=r"(val));
        println!("x10: {:x}",val);
        llvm_asm!("mv $0, x11" : "=r"(val));
        println!("x11: {:x}",val);
        llvm_asm!("mv $0, x12" : "=r"(val));
        println!("x12: {:x}",val);
        llvm_asm!("mv $0, x13" : "=r"(val));
        println!("x13: {:x}",val);
        llvm_asm!("mv $0, x14" : "=r"(val));
        println!("x14: {:x}",val);
        llvm_asm!("mv $0, x15" : "=r"(val));
        println!("x15: {:x}",val);
        llvm_asm!("mv $0, x16" : "=r"(val));
        println!("x16: {:x}",val);
        llvm_asm!("mv $0, x17" : "=r"(val));
        println!("x17: {:x}",val);
        llvm_asm!("mv $0, x18" : "=r"(val));
        println!("x18: {:x}",val);
        llvm_asm!("mv $0, x19" : "=r"(val));
        println!("x19: {:x}",val);
        llvm_asm!("mv $0, x20" : "=r"(val));
        println!("x20: {:x}",val);
        llvm_asm!("mv $0, x21" : "=r"(val));
        println!("x21: {:x}",val);
        llvm_asm!("mv $0, x22" : "=r"(val));
        println!("x22: {:x}",val);
        llvm_asm!("mv $0, x23" : "=r"(val));
        println!("x23: {:x}",val);
        llvm_asm!("mv $0, x24" : "=r"(val));
        println!("x24: {:x}",val);
        llvm_asm!("mv $0, x25" : "=r"(val));
        println!("x25: {:x}",val);
        llvm_asm!("mv $0, x26" : "=r"(val));
        println!("x26: {:x}",val);
        llvm_asm!("mv $0, x27" : "=r"(val));
        println!("x27: {:x}",val);
        llvm_asm!("mv $0, x28" : "=r"(val));
        println!("x28: {:x}",val);
        llvm_asm!("mv $0, x29" : "=r"(val));
        println!("x29: {:x}",val);
        llvm_asm!("mv $0, x30" : "=r"(val));
        println!("x30: {:x}",val);
        llvm_asm!("mv $0, x30" : "=r"(val));
        println!("x31: {:x}",val);
        println!("================================");
    }
}

pub fn debug_print_raw_data(addr: usize, len: usize){
    println!("============[debug]=============");
    unsafe{
        println!("loading data in address {:x}", addr);
        for i in 0..len{
            let mut src_data = from_raw_parts(addr as *const u8, len);
            if src_data[i] != 0 {
                println!("data in address {:x}+{} is {:x}",addr, i, src_data[i]);
            }
            
        }
        
    }
    println!("================================");
}
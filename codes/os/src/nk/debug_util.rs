
use riscv::{register::{satp}, addr::PhysAddr};
use crate::nk::{ProxyContext,PROXYCONTEXT};
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
    println!("============[debug]=============");
    println!("[debug] nk proxy context info:");
    println!("SATP: {}",PROXYCONTEXT.lock().nk_satp);
    println!("sp: {:x}",PROXYCONTEXT.lock().nk_register[2]);

    println!("[debug] ok proxy context info:");
    println!("SATP: {}",PROXYCONTEXT.lock().outer_satp);
    println!("sp: {:x}",PROXYCONTEXT.lock().outer_register[2]);
    println!("================================");
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

use riscv::{register::{satp}, addr::PhysAddr};
use crate::nk::{ProxyContext,PROXYCONTEXT};
use core::slice::{from_raw_parts};

pub fn register_info(){
    println!("============[debug]=============");
    println!("[debug] current reg info:");
    println!("SATP: {:?}",satp::read());
    let sp: usize;
    unsafe {
        llvm_asm!("mv $0, sp" : "=r"(sp));
    }
    println!("sp: {:x}",sp);
}

pub fn context_info(){
    println!("============[debug]=============");
    println!("[debug] nk proxy context info:");
    println!("SATP: {}",PROXYCONTEXT.lock().nk_satp);
    println!("sp: {:x}",PROXYCONTEXT.lock().nk_register[2]);

    println!("[debug] ok proxy context info:");
    println!("SATP: {}",PROXYCONTEXT.lock().outer_satp);
    println!("sp: {:x}",PROXYCONTEXT.lock().outer_register[2]);
}

pub fn print_raw_data(addr: usize){
    unsafe{
        let mut src_data = from_raw_parts(addr as *const u8, 1);
        println!("data in {:x} is {:x}",addr, src_data[0])
    }
}
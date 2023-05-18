
use riscv::register::{satp};
use crate::nk::{ProxyContext,PROXYCONTEXT};

pub fn register_info(){
    println!("[debug] current reg info:");
    println!("SATP: {:?}",satp::read());
    let sp: usize;
    unsafe {
        llvm_asm!("mv $0, sp" : "=r"(sp));
    }
    println!("sp: {:x}",sp);
}

pub fn context_info(){
    println!("[debug] nk proxy context info:");
    println!("SATP: {}",PROXYCONTEXT.lock().nk_satp);
    println!("sp: {:x}",PROXYCONTEXT.lock().nk_register[2]);

    println!("[debug] ok proxy context info:");
    println!("SATP: {}",PROXYCONTEXT.lock().outer_satp);
    println!("sp: {:x}",PROXYCONTEXT.lock().outer_register[2]);
}
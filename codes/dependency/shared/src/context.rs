use riscv::register::sstatus::{Sstatus, self, SPP};
use crate::config::*;


#[repr(C)]
#[derive(Debug, Clone)]
pub struct TrapContext {
    pub x: [usize; 32],
    pub sstatus: Sstatus,
    pub sepc: usize,
    //pub kernel_satp: usize,
    pub kernel_sp: usize,
    pub trap_handler: usize,
}

impl TrapContext {
    pub fn set_sp(&mut self, sp: usize) { self.x[2] = sp; }
    pub fn get_sp(& self)->usize { self.x[2] }

    pub fn app_init_context(
        // 只有三个函数调用过这个方法，在初始化的时候
        //，也就是从elf得到pcb的时候，trap context要一起初始化，这里初始化为elf的header
        entry: usize, // trap之前的上一条指令
        sp: usize, // 当前用户栈的栈顶
        //kernel_satp: usize,  // 未理解的内核页表，这东西在干啥
        kernel_sp: usize  // 内核栈栈顶
    ) -> Self {
        let mut sstatus = sstatus::read();
        // set CPU privilege to User after trapping back
        //Yan_ice: If it is supervisor mode, it can use sret successfully.
        sstatus.set_spp(SPP::User);
        unsafe{
            let mut cx = Self {
                x: [0; 32],
                sstatus,
                sepc: entry,
                kernel_sp,
                trap_handler: PROXYCONTEXT().usr_trap_handler
            };
            cx.set_sp(sp);
            cx
        }
        
    }

}

#[repr(C)]
#[derive(Debug, Clone)]
pub struct ProxyContext{
    pub nk_register: [usize; 32], //nk的寄存器
    //_+32*8
    pub outer_register: [usize; 32], //outer kernel的寄存器 注意初始化的时候把栈指针设置好
    //_+64*8
    pub nk_satp: usize, // nk的satp
    pub outer_satp: usize, // outer的satp

    //_+66*8
    pub nkapi_vec: [usize; 24],
    
    //_+90*8
    pub delegate: usize,

    //_+91*8
    pub nkapi_enable: usize,

    //_+92*8
    pub usr_trap_handler: usize,
    pub usr_trap_return: usize,

    //94*8
    pub signal_handler: usize,

    pub allocator_start: usize,
    pub allocator_end: usize,
}

pub fn PROXYCONTEXT() -> &'static mut ProxyContext{
    unsafe{ 
        &mut *(crate::PROXY_CONTEXT as usize 
        as *mut usize 
        as *mut ProxyContext) 
    }
}
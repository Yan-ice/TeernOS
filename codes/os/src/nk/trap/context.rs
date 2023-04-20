use riscv::register::sstatus::{Sstatus, self, SPP};
use super::trap_handler;

#[repr(C)]
#[derive(Debug, Clone)]
pub struct TrapContext {
    pub x: [usize; 32],
    pub sstatus: Sstatus,
    pub sepc: usize,
    pub kernel_satp: usize,
    pub kernel_sp: usize,
    pub trap_handler: usize,

    //Yan_ice: trap_handler
    //WHY address of trap handler here?
    // 离谱，这个trap handler是trap context在进行trap上下文切换的时候动态装载进去的，虽然是个写死的
    // 详见 trap.S的汇编里面Load的位置，trap handler没有任何一个函数直接去调用触发
}

impl TrapContext {
    pub fn set_sp(&mut self, sp: usize) { self.x[2] = sp; }
    pub fn get_sp(& self)->usize { self.x[2] }
    pub fn app_init_context(
        entry: usize,
        sp: usize,
        kernel_satp: usize,
        kernel_sp: usize
) -> Self {
        let mut sstatus = sstatus::read();
        // set CPU privilege to User after trapping back
        sstatus.set_spp(SPP::User);
        let mut cx = Self {
            x: [0; 32],
            sstatus,
            sepc: entry,
            kernel_satp,
            kernel_sp,
            trap_handler: trap_handler as usize};
        cx.set_sp(sp);
        cx
    }

}

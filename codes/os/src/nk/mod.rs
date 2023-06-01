mod mm;   
mod trap;
mod debug_util;
pub mod tests;

use crate::{outer_kernel_init, nk::{trap::PROXYCONTEXT, tests::{mem_access_timecost, nkapi_gatetest}}, 
syscall::syscall, return_value, return_ref, return_some, return_void, OUTER_KERNEL_SPACE};
use alloc::slice::{from_raw_parts, from_raw_parts_mut};

use crate::{debug_stack_info, debug_context_info, entry_gate};

pub use trap::{TrapContext as TrapContext, 
    user_trap_return};

use mm::nkapi;

#[macro_use]

pub use debug_util::*;

pub use mm::{VirtPageNum as VirtPageNum, 
            VirtAddr as VirtAddr, 
            PhysPageNum as PhysPageNum,
            PhysAddr as PhysAddr, 
            KERNEL_SPACE as KERNEL_SPACE, 
            MapPermission as MapPermission,
            MapType as MapType,
            PTEFlags as PTEFlags,
            KERNEL_MMAP_AREA as KERNEL_MMAP_AREA,
            KERNEL_TOKEN as KERNEL_TOKEN,
            PageTableEntry as PageTableEntry,
            MmapArea as MmapArea,
            PageTable as PageTable,
            StackFrameAllocator as StackFrameAllocator,
            FrameAllocator as FrameAllocator,
            StepByOne as StepByOne,
            VPNRange as VPNRange,

            //以下接口暂时未知。
            add_free as add_free, 
            print_free_pages as print_free_pages,

            //DANGER
            nkapi_vun_getpt as nkapi_vun_getpt
};


global_asm!(include_str!("nk_gate.S"));
global_asm!(include_str!("context.S"));

fn get_time() -> usize {
    let mut time:usize = 0;
    unsafe{
        asm!(
            "rdtime a0",
            inout("a0") time
        );
    }
    time
}

pub fn nkapi_time() -> usize{
    entry_gate!(nkapi::NKAPI_TIME);
    return_value!(usize);
}

pub fn nkapi_translate(pt_handle: usize, vpn:VirtPageNum, write: bool) -> Option<PhysPageNum>{
    entry_gate!(nkapi::NKAPI_TRANSLATE,pt_handle,vpn,write);
    return_some!(PhysPageNum);
}

pub fn nkapi_translate_va(pt_handle: usize, va: VirtAddr) -> Option<PhysAddr>{
    // if let Some(ppn) = nkapi_translate(pt_handle,va.clone().floor(),false) {
    //     let pa: PhysAddr = PhysAddr{0: ppn.0*crate::config::PAGE_SIZE + va.page_offset()};
    //     return Some(pa);
    // }
    // None
    entry_gate!(nkapi::NKAPI_TRANSLATE_VA,pt_handle,va);
    return_some!(PhysAddr);
}

pub fn nkapi_alloc(pt_handle:usize, vpn: VirtPageNum, map_type: MapType, perm: MapPermission)-> PhysPageNum{
    entry_gate!(nkapi::NKAPI_ALLOC, pt_handle, vpn, usize::from(map_type), perm);
    return_value!(PhysPageNum);
}

pub fn nkapi_pt_init(pt_handle: usize){
    entry_gate!(nkapi::NKAPI_PT_INIT,pt_handle);
    return_void!();
}

pub fn nkapi_dealloc(pt_handle: usize, vpn: VirtPageNum){
    entry_gate!(nkapi::NKAPI_DEALLOC, pt_handle, vpn);
    return_void!();
}

pub fn nkapi_activate(pt_handle: usize){
    entry_gate!(nkapi::NKAPI_ACTIVATE, pt_handle);
    return_void!();
}

pub fn nkapi_copyTo(pt_handle: usize, mut current_vpn: VirtPageNum, data: &[u8; crate::config::PAGE_SIZE], offset:usize){
    entry_gate!(nkapi::NKAPI_COPY_TO,pt_handle, current_vpn, data as *const [u8] as *const usize as usize, offset);
    return_void!();
}


pub fn nkapi_set_permission(pt_handle: usize, vpn:VirtPageNum, flags: usize){
    entry_gate!(nkapi::NKAPI_SET_PERM, pt_handle, vpn, flags);
    return_void!();
}


pub fn id() -> usize {
    let cpu_id;
    unsafe {
        llvm_asm!("mv $0, tp" : "=r"(cpu_id));
    }
    cpu_id
}

fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    (sbss as usize..ebss as usize).for_each(|a| {
        unsafe { (a as *mut u8).write_volatile(0) }
    });
}
extern "C" {
    pub fn nk_entry();
    pub fn nk_exit();
}

#[no_mangle]
pub fn nk_main(){
    let core = id();
    if core != 0 {
        loop{}
    }
    clear_bss();
    
    mm::init();
    mm::remap_test();
    println!("rmap test success.");
    
    nkapi::init_vec();
    println!("nkapi call init success.");
    trap::init();
    println!("trap init success.");

    //init page for outer kernel.
    nkapi_pt_init(0);
    OUTER_KERNEL_SPACE().lock();
    println!("outer kernel pagetable init success.");

    nkapi_gatetest();

    unsafe{
        let mut proxy = PROXYCONTEXT();
        proxy.nk_satp = KERNEL_SPACE.lock().token();
        proxy.outer_satp = crate::nk::nkapi_vun_getpt(0).token();
        proxy.outer_register[1] = outer_kernel_init as usize; //let ra be outer kernel init
        proxy.outer_register[2] = eokernelstack as usize; // 初始化 outer kernel的栈指针
    }

    //trap::enable_timer_interrupt();

    extern "C"{
        fn nk_kernel_stack_top();
        fn eokernelstack();
        fn __exit_gate();
        fn snkheap();
        fn enkheap();
        fn sokheap();
        fn eokheap();
    }

    println!("copying heap");
    unsafe{
        let total_size = enkheap as usize - snkheap as usize;
        let unit_size = 1024;
        let from_addr = snkheap as usize;
        let to_addr = sokheap as usize;

        for part in 0..(total_size/unit_size){
            let a1 = from_addr+unit_size*part;
            let a2 = to_addr+unit_size*part;
            let mut src_data = from_raw_parts(a1 as *const u8, unit_size);
            let mut dst_data = from_raw_parts_mut(a2 as *mut u8, unit_size);
            dst_data.copy_from_slice(src_data);
        }  
    }

    println!("Nesked kernel init success");
    mem_access_timecost();

    unsafe{
        crate::nk::mm::NKAPI_ENABLE = true;
        nk_exit();
        panic!("not reachable");
    }

}


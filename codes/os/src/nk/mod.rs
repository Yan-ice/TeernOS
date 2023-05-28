mod mm;   
mod trap;
mod debug_util;

use crate::{outer_kernel_init, nk::{trap::PROXYCONTEXT}, syscall::syscall, return_value, return_ref, return_some, return_void, OUTER_KERNEL_SPACE};
use alloc::slice::{from_raw_parts, from_raw_parts_mut};
use lazy_static::lazy_static;
use crate::config::NK_TRAMPOLINE;

use crate::{debug_stack_info, debug_context_info, entry_gate};

pub use trap::{TrapContext as TrapContext, 
    user_trap_return, ProxyContext};



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

            //nkapi_pt_init as nkapi_pt_init,
            //nkapi_alloc as nkapi_alloc,
            //nkapi_dealloc as nkapi_dealloc,
            //nkapi_activate as nkapi_activate,
            //nkapi_copyTo as nkapi_copyTo,

            //io_map as io_map
            //io_unmap as io_unmap
            //nkapi_mmap as nkapi_mmap,
            //nkapi_unmap as nkapi_unmap,
            //nkapi_set_permission as nkapi_set_permission,
            //nkapi_translate as nkapi_translate,
            //nkapi_translate_va as nkapi_translate_va,

            //以下接口暂时未知。
            add_free as add_free, 
            print_free_pages as print_free_pages,

            //DANGER
            nkapi_vun_getpt as nkapi_vun_getpt
};


global_asm!(include_str!("nk_gate.S"));
global_asm!(include_str!("nk_gate_copy.S"));
global_asm!(include_str!("context.S"));

extern "C"{
    pub fn entry_gate2();
}

pub fn nkapi_gatetest_entry(){
    if let Some(adr) = nkapi_gatetest(0x666, MapPermission::R, PhysAddr::from(0x555), 0x123) {
        println!("test finished with return value: {:?}", adr);
    }
}

pub fn nkapi_gatetest(pt_handle: usize, va: MapPermission, pa: PhysAddr, oth: usize) -> Option<PhysAddr>{
    entry_gate!(nkapi_gatetest_impl,pt_handle,va,pa,oth);
    return_some!(PhysAddr);
}

pub fn nkapi_gatetest_impl(pt_handle: usize, va: MapPermission, pa: PhysAddr, oth: usize) -> Option<PhysAddr>{
    println!("callee received: {:x} {:?} {:?} {:x}", pt_handle, va, pa, oth);
    return Some(PhysAddr::from(0x999))
}


pub fn nkapi_translate(pt_handle: usize, vpn:VirtPageNum, write: bool) -> Option<PhysPageNum>{
    entry_gate!(mm::nkapi_translate,pt_handle,vpn,write);
    return_some!(PhysPageNum);
}

pub fn nkapi_translate_va(pt_handle: usize, va: VirtAddr) -> Option<PhysAddr>{
    entry_gate!(mm::nkapi_translate_va,pt_handle,va);
    return_some!(PhysAddr);
}

pub fn nkapi_alloc(pt_handle:usize, vpn: VirtPageNum, map_type: MapType, perm: MapPermission)-> PhysPageNum{
    entry_gate!(mm::nkapi_alloc,pt_handle,vpn, map_type, perm);
    return_value!(PhysPageNum);
}

pub fn nkapi_pt_init(pt_handle: usize){
    entry_gate!(mm::nkapi_pt_init,pt_handle);
    return_void!();
}

pub fn nkapi_dealloc(pt_handle: usize, vpn: VirtPageNum){
    entry_gate!(mm::nkapi_dealloc,pt_handle, vpn);
    return_void!();
}

pub fn nkapi_activate(pt_handle: usize){
    entry_gate!(mm::nkapi_activate,pt_handle);
    return_void!();
}

pub fn nkapi_copyTo(pt_handle: usize, mut current_vpn: VirtPageNum, data: &[u8; crate::config::PAGE_SIZE], offset:usize){
    entry_gate!(mm::nkapi_copyTo,pt_handle, current_vpn, data as *const [u8] as *const usize as usize, offset);
    return_void!();
}

// pub fn nkapi_mmap(pt_handle: usize, vpn:VirtPageNum, ppn: PhysPageNum, perm:MapPermission){
//     entry_gate!(mm::nkapi_mmap,pt_handle, vpn, ppn, perm.bits());
//     return_void!();
// }
// pub fn nkapi_unmap(pt_handle: usize, vpn:VirtPageNum){
//     entry_gate!(mm::nkapi_unmap,pt_handle, vpn);
//     return_void!();
// }

pub fn nkapi_set_permission(pt_handle: usize, vpn:VirtPageNum, flags: usize){
    entry_gate!(mm::nkapi_set_permission,pt_handle, vpn, flags);
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
    fn nk_entry(
        proxy_address: *const usize,
    );
    pub fn nk_entry2();
}

// syscall结束后直接执行这个，没有参数，因为syscall是被nk_exit_gate调用出去的，调用时就已经设置好了ra，然后执行exit_gate的东西
// pub fn nk_entry_gate(function_address: usize){
//     // 交换页表
//     //KERNEL_SPACE.lock().activate();
//     // println!("2");
//     // // 禁用中断
//     // unsafe {
//     //     llvm_asm!("csrci sstatus, 2");
//     // }
//     // println!("3");
//     // 先恢复寄存器，再换栈
//     // unsafe {
//     //     nk_entry(&(PROXYCONTEXT().lock().nk_register) as *const usize);
//     // }

//     unsafe {

//         llvm_asm!("addi x28, $0, 0" :: "r"(PROXYCONTEXT().get_mut() as *const ProxyContext as *const usize));
//         nk_entry2();
//     }

//     println!("enter nk");
// }

extern "C" {
    pub fn nk_exit(
        proxy_address: *const usize,
        function_address: usize
    );
    pub fn nk_exit2();
}

// fn nk_exit_gate(PROXYCONTEXT(): *const usize, function_address: usize){

//     println!("exit nk");

//     // //if to outer kernel:
//     // //开启中断
//     // unsafe {
//     //     llvm_asm!("csrsi sstatus, 2");
//     // }

//     // //先保存寄存器，再换栈，再设置好ra，再换页表
//     // unsafe {
//     //     nk_exit(PROXYCONTEXT(), function_address);
//     // }

//     unsafe {
//         llvm_asm!("addi x28, $0, 0" :: "r"(PROXYCONTEXT()));
//         nk_exit2();
//     }

//     //TODO: 进程页表/内核页表
//     //if to user: 暂时未写
//     // trap return (so here ignore)
// }

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
    
    trap::init();
    println!("trap init success.");

    //init page for outer kernel.
    mm::nkapi_pt_init(0);

    OUTER_KERNEL_SPACE().lock();
    println!("outer kernel pagetable init success.");

    unsafe{
        let mut proxy = PROXYCONTEXT();
        println!("Nesked kernel [0]");
        proxy.nk_satp = KERNEL_SPACE.lock().token();
        println!("Nesked kernel [1]");
        proxy.outer_satp = crate::nk::nkapi_vun_getpt(0).token();
        println!("Nesked kernel [2]");
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

    
    unsafe{
        crate::nk::mm::NKAPI_ENABLE = true;
        extern "C"{
            fn nk_exit2();
        }
        println!("exit ready");
        nk_exit2();
        panic!("not reachable");
    }

}


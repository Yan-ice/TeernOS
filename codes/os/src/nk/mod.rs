mod mm;   
mod trap;
mod debug_util;

use crate::{outer_kernel_init, nk::{trap::PROXYCONTEXT}, syscall::syscall};
use alloc::slice::{from_raw_parts, from_raw_parts_mut};
use crate::config::NK_TRAMPOLINE;

pub use trap::{TrapContext as TrapContext, 
    user_trap_return, ProxyContext};

pub use debug_util::*;

pub use mm::{VirtPageNum as VirtPageNum, 
            VirtAddr as VirtAddr, 
            PhysPageNum as PhysPageNum,
            PhysAddr as PhysAddr, 
            KERNEL_SPACE as KERNEL_SPACE, 
            OUTER_KERNEL_SPACE as OUTER_KERNEL_SPACE,
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
            nkapi_dealloc as nkapi_dealloc,
            nkapi_activate as nkapi_activate,
            nkapi_copyTo as nkapi_copyTo,

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

extern "C"{
    pub fn entry_gate2();
}

pub fn nkapi_translate(pt_handle: usize, vpn:VirtPageNum, write: bool) -> Option<PhysPageNum>{
    println!("NKAPI: nkapi_trans occurs");
    unsafe{
        let target_func: *const usize = mm::nkapi_translate as *const usize;
        llvm_asm!("addi x28, $0, 0" :: "r"(NK_TRAMPOLINE as usize));
        llvm_asm!("mv x29, $0" :: "r"(target_func));
        nk_entry2();
    }
    panic!("unreachable");
}
pub fn nkapi_translate_va(pt_handle: usize, va: VirtAddr) -> Option<PhysAddr>{
    unsafe{
       println!("NKAPI: nkapi_trans_va occurs");
       println!("params expected: {:?} {:?}", pt_handle, va);
       let target_func: usize = mm::nkapi_translate_va as usize;
       llvm_asm!("mv x28, $0" :: "r"(NK_TRAMPOLINE as usize));
       llvm_asm!("mv x29, $0" :: "r"(target_func));
       // llvm_asm!("jalr x1, x29, 0");

       let test: usize;
       llvm_asm!("mv $0, x12" : "=r"(test));
       println!("pt_handle: {:x} x12: {:x}",pt_handle, test);
       panic!("stop@");
       llvm_asm!("j nk_entry2");
   }
   panic!("unreachable");
}

pub fn nkapi_alloc(pt_handle:usize, vpn: VirtPageNum, map_type: MapType, perm: MapPermission)-> PhysPageNum{
     println!("NKAPI: nkapi_alloc occurs");
     unsafe{
        let target_func: *const usize = mm::nkapi_alloc as *const usize;
        llvm_asm!("addi x28, $0, 0" :: "r"(NK_TRAMPOLINE as usize));
        llvm_asm!("mv x29, $0" :: "r"(target_func));
        nk_entry2();

        print!("Warn: more step needed when returning.");
        let ret_val: usize;
        llvm_asm!("mv $0, x10" : "=r"(ret_val));
        return PhysPageNum::from(ret_val);
    }
    
}
pub fn nkapi_pt_init(pt_handle: usize){
    //mm::nkapi_pt_init(pt_handle);
    unsafe{
        let target_func: *const usize = mm::nkapi_pt_init as *const usize;
        
        llvm_asm!("addi x28, $0, 0" :: "r"(NK_TRAMPOLINE as usize));
        llvm_asm!("mv x29, $0" :: "r"(target_func));
        nk_entry2();
    }
}

pub fn nkapi_mmap(pt_handle: usize, vpn:VirtPageNum, ppn: PhysPageNum, perm:MapPermission){
    unsafe{
        let target_func: *const usize = mm::nkapi_mmap as *const usize;
        llvm_asm!("addi x28, $0, 0" :: "r"(NK_TRAMPOLINE as usize));
        llvm_asm!("mv x29, $0" :: "r"(target_func));
        nk_exit2();
    }
}
pub fn nkapi_unmap(pt_handle: usize, vpn:VirtPageNum){
    unsafe{
        let target_func: *const usize = mm::nkapi_unmap as *const usize;
        
        llvm_asm!("addi x28, $0, 0" :: "r"(NK_TRAMPOLINE as usize));
        llvm_asm!("mv x29, $0" :: "r"(target_func));
        nk_entry2();
    }
}

pub fn nkapi_set_permission(pt_handle: usize, vpn:VirtPageNum, flags: usize){
    unsafe{
        let target_func: *const usize = mm::nkapi_set_permission as *const usize;
        llvm_asm!("addi x28, $0, 0" :: "r"(NK_TRAMPOLINE as usize));
        llvm_asm!("mv x29, $0" :: "r"(target_func));
        nk_entry2();
    }
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

global_asm!(include_str!("nk_gate.S"));
global_asm!(include_str!("nk_gate_copy.S"));

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
    unsafe{
        PROXYCONTEXT().nk_satp = KERNEL_SPACE.lock().token();
        PROXYCONTEXT().outer_satp = OUTER_KERNEL_SPACE.lock().token();
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

    use crate::nk::mm::memory_set::kernel_pt;
    println!("Nesked kernel init success");
    unsafe{
        println!("proxy addr: {:x} == {:?}]",PROXYCONTEXT() as *const ProxyContext as usize, kernel_pt().translate_va(VirtAddr::from(NK_TRAMPOLINE as usize)));

        println!("nk_satp get: {:x}, {:?}", NK_TRAMPOLINE, (*(NK_TRAMPOLINE as *const ProxyContext)).nk_satp);
    }
    
    debug_context_info();

    unsafe{
        extern "C"{
            fn nk_exit2();
        }
        let mut proxy = PROXYCONTEXT();
        proxy.outer_register[1] = outer_kernel_init as usize; //let ra be outer kernel init
        proxy.outer_register[2] = eokernelstack as usize; // 初始化 outer kernel的栈指针
        llvm_asm!("mv x28, $0" :: "r"(proxy as *const ProxyContext as *const usize));
        println!("Exiting.");
        nk_exit2();
        panic!("not reachable");
    }

}


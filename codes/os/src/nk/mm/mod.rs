mod heap_allocator;
mod frame_allocator;
mod page_table;
mod memory_set;
mod trap_handle;

use crate::{debug_info};
use riscv::register::{
    mtvec::TrapMode,
    scause::{
        self,
        Trap,
        Exception,
        Interrupt,
    },
    stval,
    stvec,
};


use alloc::{sync::Arc, boxed::Box};
use lazy_static::*;
use spin::Mutex;

use alloc::vec::Vec;

use crate::task::{current_task, Signals};
use crate::{outer_frame_alloc};

use page_table::*;

use crate::shared::*;
use crate::config::*;

pub use frame_allocator::{
    StackFrameAllocator, 
    FrameAllocator,
    add_free, 
    print_free_pages, 
    outer_print_free_pages, 
    frame_add_ref, 
    enquire_refcount
};



//nk内部的就不暴露啦
use frame_allocator::{
    frame_alloc,
    frame_dealloc
};

pub use page_table::{
    PageTable,
    PageTableEntry
};

pub use memory_set::{MemorySet, KERNEL_SPACE, KERNEL_TOKEN, kernel_token};
pub use heap_allocator::HEAP_ALLOCATOR;
pub use frame_allocator::FRAME_ALLOCATOR;


use trap_handle::{handle_nk_trap};

use self::memory_set::KernelToken;

use super::TrapContext;
extern "C" {
    fn stext();
    fn etext();
    fn srodata();
    fn erodata();
    fn sdata();
    fn edata();
    fn sbss_with_stack();
    fn ebss();
    fn ekernel();
    fn sproxy();
    fn strampoline();
    fn ssignaltrampoline();
    fn snktrampoline();
}



pub fn init() {

    heap_allocator::init_heap();  // 堆空间分配器

    frame_allocator::init_frame_allocator();  // 物理页帧分配器
    // KERNEL_SPACE是个lazy启动的，启动时将pagetable等数据写好
    
    KERNEL_SPACE.lock().activate();  // 切换页表
    //KERNEL_SPACE.lock().print_pagetable();
    // unsafe{
    //     PROXYCONTEXT().nk_satp = KERNEL_SPACE.lock().token();
    // }
    debug_info!("kernel table init success.");
    init_vec();
}

pub fn init_othercore(){

    KERNEL_SPACE.lock().activate();
}

lazy_static! {
    pub static ref PAGE_TABLE_LIST: Mutex<Vec<PageTableRecord>> = Mutex::new(
        Vec::<PageTableRecord>::new()
    );
    pub static ref current_pt: Mutex<Box<usize>> = Mutex::new(Box::new(0));
}

macro_rules! pt_operate {
    ($handle:expr, $target:ident, $oper:block) => {
        let mut _find = false;
        for tar in PAGE_TABLE_LIST.lock().iter_mut(){
            if tar.id() == $handle {
                _find = true;
                let $target: &mut PageTableRecord = tar;
                $oper
            }
        }
        if !_find {
            panic!("Cannot find pagetable with handle [{}]!",$handle);
        }
    };
}


pub fn init_vec(){
    let proxy = PROXYCONTEXT();

    proxy.nkapi_enable = 1;
    proxy.nkapi_vec[NKAPI_TRAP_HANDLE] = nkapi_traphandle as usize;
    proxy.nkapi_vec[NKAPI_CONFIG] = nkapi_config as usize;
    proxy.nkapi_vec[NKAPI_PT_INIT] = nkapi_pt_init as usize;
    proxy.nkapi_vec[NKAPI_ALLOC] = nkapi_alloc as usize;
    proxy.nkapi_vec[NKAPI_DEALLOC] = nkapi_dealloc as usize;
    proxy.nkapi_vec[NKAPI_ACTIVATE] = nkapi_activate as usize;
    proxy.nkapi_vec[NKAPI_COPY_TO] = nkapi_copy_to as usize;
    proxy.nkapi_vec[NKAPI_TRANSLATE] = nkapi_translate as usize;
    proxy.nkapi_vec[NKAPI_TRANSLATE_VA] = nkapi_translate_va as usize;
    proxy.nkapi_vec[NKAPI_SET_PERM] = nkapi_set_permission as usize;
    proxy.nkapi_vec[NKAPI_TIME] = nkapi_time as usize;
    proxy.nkapi_vec[NKAPI_DEBUG] = nkapi_print_pt as usize;

    proxy.delegate = 0;

}




fn nkapi_time() -> usize {
    let mut time:usize = 0;
    unsafe{
        asm!(
            "rdtime a0",
            inout("a0") time
        );
    }
    time
}



pub fn pt_current() -> usize {
    current_pt.lock().as_ref().clone()
}

fn nkapi_traphandle(ctx: &TrapContext){

    let scause: scause::Scause = scause::read();
    let stval = stval::read();
    match scause.cause() {
        Trap::Exception(Exception::UserEnvCall) |
        Trap::Exception(Exception::InstructionFault) |
        Trap::Exception(Exception::InstructionPageFault) |        
        Trap::Exception(Exception::IllegalInstruction) |
        Trap::Interrupt(Interrupt::SupervisorTimer) => {
            panic!("Should be handled by Outer Kernel. {:?}, stval = {:#x}!", scause.cause(), stval);
        }
        Trap::Exception(Exception::LoadFault) |
        Trap::Exception(Exception::StoreFault) |
        Trap::Exception(Exception::StorePageFault) |
        Trap::Exception(Exception::LoadPageFault) => {
            handle_nk_trap(scause, stval as usize);
        }
        _ => {
            panic!("Unsupported trap {:?}, stval = {:#x}!", scause.cause(), stval);
        }
    }

}

//the function below would expose to outer kernel
fn nkapi_config(t: usize, val: usize){
    debug_info!("Entering config.");
    let proxy = PROXYCONTEXT();

    match t{
        NKCFG_DELEGATE =>{
            proxy.delegate = val;
        }
        NKCFG_SIGNAL => {
            proxy.signal_handler = val;
        }
        _ => {
            debug_info!("Unknown config ID: {}", t);
        }
    }
}

//the function below would expose to outer kernel
fn nkapi_print_pt(pt_handle: usize, from: usize, to: usize){
    pt_operate! (pt_handle, target_pt, {
        target_pt.trace_address(from.into());
        debug_info!("printing pagetable [{}]", pt_handle);
        target_pt.print_pagetable(from, to);
    });
    // if let Some(mut target_pt) = pt_get(pt_handle){
    //     target_pt.trace_address(from.into());
    //     debug_info!("printing pagetable [{}]", pt_handle);
    //     target_pt.print_pagetable(from, to);
    // }
    
}

// fn current_pt() -> usize {
    
// }
fn nkapi_pt_init(pt_handle: usize, re_generate: bool){
    
    if re_generate{
        nkapi_pt_destroy(pt_handle);
    }
    for i in PAGE_TABLE_LIST.lock().iter(){
        if i.id() == pt_handle {
            debug_info!("WARN: Pagetable [{}] already exists.",pt_handle);
            //pagetable with this handle already exist
            return;
        }
    }

    //Yan_ice: here we create a new pagetable,
    let mut pt = PageTableRecord::new(pt_handle);
    debug_info!("Creating user PageTable [{}] with token {:x}.",pt_handle, pt.token());

    pt.map(VirtAddr::from(SIGNAL_TRAMPOLINE).into(),
        PhysAddr::from(ssignaltrampoline as usize).into(),
        PTEFlags::R | PTEFlags::X | PTEFlags::U,
    );

    // mapping trampoline
    pt.map(VirtAddr::from(TRAMPOLINE).into(), 
        PhysAddr::from(strampoline as usize).into(),
        PTEFlags::R | PTEFlags::X);

    unsafe{
        pt.map(VirtAddr::from(NK_TRAMPOLINE).into(), 
        PhysAddr::from(sproxy as *const ProxyContext as usize).into(),
        PTEFlags::R | PTEFlags::W);
    }

    if pt_handle != 0{
        pt_operate!(0,pt_kernel,{
            pt.map_kernel_shared(pt_kernel);
        });
    }

    PAGE_TABLE_LIST.lock().push(pt);

    if pt_current() == pt_handle {
        nkapi_activate(pt_handle);
    }
    return;
}

// pub fn nkapi_pt_copy(pt_handle: usize, parent_handle: usize){
//     nkapi_pt_init(pt_handle);

//     let mut parent = None;
//     for i in PAGE_TABLE_LIST.into_iter(){
//         if i.id() == parent_handle {
//             parent = Some(i);
//         }
//     }

// }

fn nkapi_set_permission(pt_handle: usize, vpn: VirtPageNum, flags: usize){
    // find target pagetable
    pt_operate! (pt_handle, target_pt, {
        if target_pt.translate(vpn).is_none() {
            debug_info!("WARN: entry not valid while setting permission.");
        }
        target_pt.set_pte_flags(vpn, flags);
        return;
    });
}

fn nkapi_pt_destroy(pt_handle: usize){
    let mut ptlist = PAGE_TABLE_LIST.lock();
    for tar in 0..ptlist.len(){
        if ptlist[tar].id() == pt_handle {
            ptlist.remove(tar).destroy();
            return;
        }
    }
}

fn nkapi_alloc(pt_handle: usize, vpn: VirtPageNum, map_type_u: usize, perm: MapPermission) -> PhysPageNum{
    let map_type = MapType::from(map_type_u);
    let pte_flags = PTEFlags::from_bits(perm.bits()).unwrap();
    
    //debug_info!("nkapi_alloc [{}] {:?} {:?}", pt_handle, vpn, map_type);

    pt_operate! (pt_handle, target_pt, {
        // get target ppn
        let target_ppn;
        match map_type{
            MapType::Framed => {
                if let Some(ppn) = outer_frame_alloc(){
                    //debug_info!("outer allocating: {:?}", ppn);
                    target_ppn = ppn;
                }else{
                    outer_print_free_pages();
                    panic!("No more memory in Outer Kernel!");
                }
            }
            MapType::FramedInNK => {
                if let Some(ppn) = frame_alloc(){
                    target_ppn = ppn;
                }else{
                    print_free_pages();
                    panic!("No more memory in Nested Kernel!");
                }
            }
            MapType::Identical => {
                target_ppn = PhysPageNum::from(vpn.0);
            }
            MapType::Specified(ppn) => {
                target_ppn = ppn;
            }
        }

        //clean the page frame
        if map_type == MapType::Framed || map_type == MapType::FramedInNK{
            let bytes_array = target_ppn.get_bytes_array();
            for i in bytes_array {
                *i = 0;
            }
        }
        
        // modify pagetable entry
        target_pt.map(vpn, target_ppn, pte_flags);
        return target_ppn
    });
    debug_info!("nkapi_alloc: cannot find pagetable!");
    return PhysPageNum{0: vpn.0};

}

fn nkapi_dealloc(pt_handle: usize, vpn: VirtPageNum){
    pt_operate! (pt_handle, target_pt, {
        target_pt.unmap(vpn);
        return;
    });
    debug_info!("nk_dealloc: cannot find pagetable!");
}

// while translating COW with write==True, it would start alloc and copy.
fn nkapi_translate(pt_handle: usize, vpn: VirtPageNum, write: bool) -> Option<PhysPageNum>{

    pt_operate! (pt_handle, pt, {
        if let Some(pte) = pt.translate(vpn){
            if pte.is_valid() {
                let former_ppn = pte.ppn();

                if pte.is_cow() & write{

                    //the code copy from memoryset::cow_alloc
                    if enquire_refcount(former_ppn) == 1 {
                        pt.reset_cow(vpn);
                        // change the flags of the src_pte
                        pt.set_flags(
                            vpn, pt.translate(vpn).unwrap().flags() | PTEFlags::W
                        );
                    }

                    let ppn = frame_alloc().unwrap();
                    pt.remap_cow(vpn, ppn, former_ppn);
                    return Some(ppn);

                }else{
                    return Some(former_ppn);
                }
                
            }
        }
        debug_info!("WARN: cannot translate {:?}", vpn);
    });
    None
}

fn nkapi_translate_va(pt_handle: usize, va: VirtAddr) -> Option<PhysAddr>{
    pt_operate! (pt_handle, target_pt, {
        let pa = target_pt.translate_va(va);
        //debug_info!("VA->PA: {:?} {:?}", va, pa);
        return pa;
    });
    None
}


fn nkapi_copy_to(pt_handle: usize, vpn: VirtPageNum, data_ptr: usize, offset:usize) {
    unsafe{
        let former_pa = nkapi_translate_va(pt_current(), data_ptr.into()).unwrap();

        pt_operate! (pt_handle, target_pt, {

            //debug_info!("nk_copy: copying data from {:x}", former_pa.0);
            let data = &*(former_pa.0 as *const usize as *mut [u8; PAGE_SIZE]);

            let mut ppn = &mut target_pt.translate(vpn).unwrap().ppn();
            //debug_info!("nkapi_copy: copying {} datas to {:?}",PAGE_SIZE - offset, ppn);

            let src = &data[0..(PAGE_SIZE - offset)];
            let dst = &mut ppn.get_bytes_array()[offset..PAGE_SIZE];
            dst.copy_from_slice(src);

        });
    }
}

//use crate::task::__switch;
pub fn nkapi_activate(pt_handle: usize) {
    pt_operate! (pt_handle, target_pt, {
        let satp = target_pt.token();
        // nk_entry_gate();
        // unsafe {
        //     satp::write(satp);
        //     llvm_asm!("sfence.vma" :::: "volatile");
        // }

        // debug_info!("outer kernel's table switch.");
        debug_info!("nkapi: pagetable [{}] activated.", pt_handle);
        *current_pt.lock().as_mut() = pt_handle;

        unsafe{
            (&mut PROXYCONTEXT()).outer_satp = satp;
        }

        return;
    });
}

// this function is temporaily used. it is vulunerable!
pub fn nkapi_vun_getpt(pt_handle: usize) -> PageTable{
    pt_operate! (pt_handle, target_pt, {
        return target_pt.into();
    });
    panic!("not found!");
}

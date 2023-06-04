mod heap_allocator;
mod address;
mod frame_allocator;
mod page_table;
pub mod nkapi;
pub mod memory_set;
mod vma;
mod trap_handle;

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
use riscv::register::satp;

use crate::{nk::nkapi::ProxyContext, task::{current_task, Signals}};
use crate::{outer_frame_alloc, debug_stack_info, StaticThings, OUTER_KERNEL_SPACE};

pub use nkapi::{
    API_ENABLE as NKAPI_ENABLE,
    PROXYCONTEXT as PROXYCONTEXT
};

pub use address::{PhysAddr, VirtAddr, PhysPageNum, VirtPageNum, StepByOne, VPNRange};
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
    frame_alloc
};

pub use page_table::{
    PageTable,
    PageTableEntry,
    PTEFlags
};

pub use vma::{MmapArea, MmapSpace};
pub use memory_set::{MemorySet, KERNEL_SPACE, KERNEL_MMAP_AREA, KERNEL_TOKEN, kernel_token};
pub use memory_set::remap_test;
pub use heap_allocator::HEAP_ALLOCATOR;
pub use frame_allocator::FRAME_ALLOCATOR;

use crate::config::*;

use trap_handle::{handle_outer_trap, handle_nk_trap};

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

#[derive(Copy, Clone, PartialEq, Debug)]
pub enum MapType {
    Identical,
    Framed,
    FramedInNK,
    Specified(PhysPageNum)
}
impl From<MapType> for usize {
    fn from(v: MapType) -> Self {
        match v {
            MapType::Identical =>{
                return usize::MAX-1;
            }
            MapType::Framed =>{
                return usize::MAX-2;
            }
            MapType::FramedInNK =>{
                return usize::MAX-3;
            }
            MapType::Specified(ppn) =>{
                return ppn.0;
            }
        }
    }
}
impl From<usize> for MapType{
    fn from(v: usize) -> Self {
        unsafe{
             if v == usize::MAX-1 {
            MapType::Identical
        }else if v == usize::MAX-2 {
            MapType::Framed
        }else if v == usize::MAX-3 {
            MapType::FramedInNK
        }else{
            MapType::Specified(PhysPageNum::from(v))
        }
        }
    }
}



bitflags! {
    pub struct MapPermission: u8 {
        const R = 1 << 1;  // read
        const W = 1 << 2;  // write
        const X = 1 << 3;  // execute
        const U = 1 << 4;
    }
    
}

impl From<MapPermission> for usize{
    fn from(v: MapPermission) -> Self{
        v.bits().into()
    }
}

impl From<usize> for MapPermission{
    fn from(v: usize) -> Self{
        MapPermission { bits: v as u8}
    }
}

impl MapPermission{
    pub fn flags(self) -> PTEFlags{
        PTEFlags::from_bits(self.bits).unwrap()
    }
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
}

pub fn init_othercore(){

    KERNEL_SPACE.lock().activate();
}

lazy_static! {
    pub static ref PAGE_TABLE_LIST: Mutex<Vec<PageTable>> = Mutex::new(
        Vec::<PageTable>::new()
    );
    pub static ref current_pt: Mutex<Box<usize>> = Mutex::new(Box::new(0));
}


//get the Pagetable from its handle(id)
pub fn pt_get(pt_handle: usize) -> Option<PageTable>{

    for i in PAGE_TABLE_LIST.lock().clone().into_iter(){
        if i.id() == pt_handle {
            return Some(i.clone());
        }
    }
    return None
}

pub fn pt_current() -> usize {
    current_pt.lock().as_ref().clone()
}

fn nkapi_traphandle(ctx: &TrapContext){

    let scause: scause::Scause = scause::read();
    let stval = stval::read();
    match scause.cause() {

        Trap::Exception(Exception::InstructionFault) |
        Trap::Exception(Exception::InstructionPageFault) |        
        Trap::Exception(Exception::IllegalInstruction) |
        Trap::Interrupt(Interrupt::SupervisorTimer) => {
            handle_outer_trap(scause, stval as usize);
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
fn nkapi_assert_eq_and_echo(t1: PhysAddr, t2: VirtAddr) -> Option<usize>{
    println!("Entering nkapi_test.");
    assert_eq!(t1.0, t2.0, "asserting in nkapi_assert.");
    return Some(t1.0);
}

//the function below would expose to outer kernel
fn nkapi_print_pt(pt_handle: usize, from: usize, to: usize){
    if let Some(mut target_pt) = pt_get(pt_handle){
        target_pt.trace_address(from.into());
        println!("printing pagetable [{}]", pt_handle);
        target_pt.print_pagetable(from, to);
    }
    
}

// fn current_pt() -> usize {
    
// }
fn nkapi_pt_init(pt_handle: usize){
    
    for i in PAGE_TABLE_LIST.lock().clone().into_iter(){
        if i.id() == pt_handle {
            println!("Pagetable [{}] already exists.",pt_handle);
            //pagetable with this handle already exist
            return;
        }
    }

    //Yan_ice: here we create a new pagetable,
    let mut pt = PageTable::new(pt_handle);
    println!("Creating user PageTable [{}] with token {:x}.",pt_handle, pt.token());

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
        pt.map_kernel_shared();
    }

    PAGE_TABLE_LIST.lock().push(pt);
    println!("Creating Pagetable success.");
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
    if let Some(mut target_pt) = pt_get(pt_handle){
        if target_pt.translate(vpn).is_none() {
            println!("WARN: entry not valid while setting permission.");
        }
        target_pt.set_pte_flags(vpn, flags);
        return;
    }
    println!("nk_set_perm: cannot find pagetable!");
}

fn pt_destroy(pt_handle: usize){
    // TODO
}

fn nkapi_alloc(pt_handle: usize, vpn: VirtPageNum, map_type_u: usize, perm: MapPermission) -> PhysPageNum{
    let map_type = MapType::from(map_type_u);
    let pte_flags = PTEFlags::from_bits(perm.bits()).unwrap();
    
    if let Some(mut target_pt) = pt_get(pt_handle){
        // get target ppn
        let target_ppn;
        match map_type{
            MapType::Framed => {
                if let Some(ppn) = outer_frame_alloc(){
                    //println!("outer allocating: {:?}", ppn);
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
    }
    println!("nkapi_alloc: cannot find pagetable!");
    return PhysPageNum{0: vpn.0};

}

fn nkapi_dealloc(pt_handle: usize, vpn: VirtPageNum){
    if let Some(mut pt) = pt_get(pt_handle){
        pt.unmap(vpn);
        return;
    }
    println!("nk_dealloc: cannot find pagetable!");
}

// while translating COW with write==True, it would start alloc and copy.
fn nkapi_translate(pt_handle: usize, vpn: VirtPageNum, write: bool) -> Option<PhysPageNum>{

    if let Some(mut pt) = pt_get(pt_handle){
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
        println!("WARN: cannot translate {:?}", vpn);
    }
    None
}

fn nkapi_translate_va(pt_handle: usize, va: VirtAddr) -> Option<PhysAddr>{
    if let Some(pt) = pt_get(pt_handle){
        let pa = pt.translate_va(va);
        //println!("VA->PA: {:?} {:?}", va, pa);
        return pa;
    }
    panic!("nk_translate_va: cannot find pagetable!");
}


fn nkapi_copy_to(pt_handle: usize, vpn: VirtPageNum, data_ptr: usize, offset:usize) {
    
    unsafe{
        if let Some(pt) = pt_get(pt_handle){

            let former_pa = nkapi_translate_va(pt_current(), data_ptr.into()).unwrap();
            //println!("nk_copy: copying data from {:x}", former_pa.0);
            let data = &*(former_pa.0 as *const usize as *mut [u8; PAGE_SIZE]);

            let mut ppn = &mut pt.translate(vpn).unwrap().ppn();
            //println!("nkapi_copy: copying {} datas to {:?}",PAGE_SIZE - offset, ppn);

            let src = &data[0..(PAGE_SIZE - offset)];
            let dst = &mut ppn.get_bytes_array()[offset..PAGE_SIZE];
            dst.copy_from_slice(src);
            //println!("nkapi_copy: copy success.");

            return;
        }
        println!("nk_copyTo: cannot find pagetable!");
    }

}

//use crate::task::__switch;
pub fn nkapi_activate(pt_handle: usize) {
    if let Some(page_table) = pt_get(pt_handle) {
        let satp = page_table.token();
        // nk_entry_gate();
        // unsafe {
        //     satp::write(satp);
        //     llvm_asm!("sfence.vma" :::: "volatile");
        // }

        // println!("outer kernel's table switch.");
        println!("nkapi: pagetable [{}] activated.", pt_handle);
        println!("(satp: {:x} => {:x})", (&PROXYCONTEXT()).outer_satp, satp);
        *current_pt.lock().as_mut() = pt_handle;

        unsafe{
            (&mut PROXYCONTEXT()).outer_satp = satp;
        }
        
        // unsafe {
        //     __switch(
        //         start,
        //         end,
        //     );
        // }
        return;
    }
    println!("nk_activate: cannot find pagetable!");
}

// this function is temporaily used. it is vulunerable!
pub fn nkapi_vun_getpt(pt_handle: usize) -> PageTable{
    if let Some(pt) = pt_get(pt_handle) {
        return pt;
    }
    panic!("nk_vun_getpt: Pagetable handle not exist.");
}

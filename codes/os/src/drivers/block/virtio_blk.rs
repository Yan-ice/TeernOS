
use virtio_drivers::{VirtIOBlk, VirtIOHeader};
use crate::nk::{
    PhysAddr,
    VirtAddr,
    nkapi_translate_va,
    PhysPageNum,
    StepByOne,
};
use crate::{
    outer_frame_alloc,
    outer_frame_dealloc
};

use super::BlockDevice;
use spin::Mutex;
use alloc::vec::Vec;
use lazy_static::*;

#[allow(unused)]
const VIRTIO0: usize = 0x10001000;

pub struct VirtIOBlock(Mutex<VirtIOBlk<'static>>);

lazy_static! {
    static ref QUEUE_FRAMES: Mutex<Vec<PhysPageNum>> = Mutex::new(Vec::new());
}

impl BlockDevice for VirtIOBlock {
    fn read_block(&self, block_id: usize, buf: &mut [u8]) {
        // println!("{}",block_id);
        self.0.lock().read_block(block_id, buf).expect("Error when reading VirtIOBlk");
    }
    fn write_block(&self, block_id: usize, buf: &[u8]) {
        self.0.lock().write_block(block_id, buf).expect("Error when writing VirtIOBlk");
    }
}


use crate::timer::get_time;
impl VirtIOBlock {
    #[allow(unused)]
    pub fn new() -> Self {
        let vb = Self(Mutex::new(VirtIOBlk::new(
            unsafe { &mut *(VIRTIO0 as *mut VirtIOHeader) }
        ).unwrap()));
        //vb.wtest();
        vb
    }

    pub fn wtest(&self){
        let mut buf = [0u8;512];
        self.read_block(0, &mut buf);
        let start = get_time();
        for i in 1..1000 {
            //println!("wtest");
            self.write_block(0, &buf);
        }
        let end = get_time();
        println!("[vblk writing test]: {}", end - start);
    }
}

#[no_mangle]
pub extern "C" fn virtio_dma_alloc(pages: usize) -> PhysAddr {
    let mut ppn_base = PhysPageNum(0);
    for i in 0..pages {
        let frame_ppn = outer_frame_alloc().unwrap();
        if i == 0 { ppn_base = frame_ppn; }
        QUEUE_FRAMES.lock().push(ppn_base);
    }
    ppn_base.into()
}

#[no_mangle]
pub extern "C" fn virtio_dma_dealloc(pa: PhysAddr, pages: usize) -> i32 {
    let mut ppn_base: PhysPageNum = pa.into();
    for _ in 0..pages {
        outer_frame_dealloc(ppn_base);
        ppn_base.step();
    }
    0
}


// #[derive(Copy,Clone)]
// struct MPair{
//     va: VirtAddr,
//     pa: PhysAddr
// }
// lazy_static! {
//     static ref RECORD: Mutex<Vec<MPair>> = Mutex::new(Vec::new());
// }

#[no_mangle]
pub extern "C" fn virtio_phys_to_virt(paddr: PhysAddr) -> VirtAddr {
    // for p in RECORD.lock().clone().into_iter(){
    //     if p.pa == paddr{
    //         return p.va.clone();
    //     }
    // }
    VirtAddr(paddr.0)
}

#[no_mangle]
pub extern "C" fn virtio_virt_to_phys(vaddr: VirtAddr) -> PhysAddr {
    if let Some(pa) = nkapi_translate_va(0, vaddr){
        // for p in RECORD.lock().clone().into_iter(){
        //     if p.va == vaddr{
        //         return pa.clone();
        //     }
        // }
        // RECORD.lock().push(MPair{va:vaddr,pa});
        return pa;
    }else{
        return PhysAddr{0: vaddr.0};
    }
}

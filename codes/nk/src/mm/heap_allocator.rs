use buddy_system_allocator::LockedHeap;

use shared::debug_error;
use crate::config::*;

static mut HEAP_SPACE: [u8; NK_HEAP_SIZE] = [0; NK_HEAP_SIZE];

#[global_allocator]
pub static HEAP_ALLOCATOR: LockedHeap = LockedHeap::empty();

#[alloc_error_handler]
pub fn handle_alloc_error(layout: core::alloc::Layout) -> ! {
    debug_error!("[handle_alloc_error]: May have no enough heap memory!");
    panic!("NK Heap allocation error, layout = {:?}", layout);
}

pub fn init_heap() {
    unsafe {
        HEAP_ALLOCATOR
            .lock()
            .init(HEAP_SPACE.as_ptr() as usize, NK_HEAP_SIZE);
    }
}


// #[allow(unused)]
// pub fn heap_test() {
//     use alloc::boxed::Box;
//     use alloc::vec::Vec;
//     extern "C" {
//         fn sbss();
//         fn ebss();
//     }
//     let bss_range = sbss as usize..ebss as usize;
//     let a = Box::new(5);
//     assert_eq!(*a, 5);
//     assert!(bss_range.contains(&(a.as_ref() as *const _ as usize)));
//     drop(a);
//     let mut v: Vec<usize> = Vec::new();
//     for i in 0..500 {
//         v.push(i);
//     }
//     for i in 0..500 {
//         assert_eq!(v[i], i);
//     }
//     assert!(bss_range.contains(&(v.as_ptr() as usize)));
//     drop(v);
//     debug_info!("heap_test passed!");
// }


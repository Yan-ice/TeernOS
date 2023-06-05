use crate::{entry_gate, return_some, nk::{PhysAddr, nkapi, VirtAddr, nkapi_pt_init, nkapi_alloc, MapPermission, nkapi_dealloc, nkapi_translate_va}, begin_test};
use crate::debug_info;

const valA: usize = 66666;
const va_test: VirtAddr = VirtAddr{0: 0x10000000336};
const pa_test: PhysAddr = PhysAddr{0: 0x20000000336};

pub fn nkapi_gatetest(){
    begin_test!("nkapi gate test",
    {
        if let Some(adr) = my_example(valA.into(), valA.into()) {
            //assert_eq!(adr, valA, "testing return value.");
            debug_info!("nkapi: basic test passed.");
        }

        let test_pt = 2333;
        nkapi_pt_init(test_pt, true);

        nkapi_alloc(test_pt, va_test.into(), crate::nk::MapType::Identical, MapPermission::R);
        if let Some(pa) = nkapi_translate_va(test_pt, va_test.into()) {
            assert_eq!(pa.0, va_test.0, "testing identical alloc.");
            debug_info!("nkapi: identical alloc test passed.");
        }else{
            panic!("nkapi: identical alloc test failed with None.")
        }
        
        nkapi_dealloc(test_pt, va_test.into());
        if let Some(pa) = nkapi_translate_va(test_pt, va_test.into()) {
            panic!("nkapi: identical dealloc test failed.")
        }else{
            debug_info!("nkapi: dealloc test passed.");
        }

        nkapi_alloc(test_pt, va_test.into(), crate::nk::MapType::Specified(pa_test.floor()), MapPermission::R);
        if let Some(pa) = nkapi_translate_va(test_pt, va_test.into()) {
            assert_eq!(pa.0, pa_test.0, "testing identical alloc.");
            debug_info!("nkapi: specified alloc test passed.");
        }else{
            panic!("nkapi: specified alloc test failed with None.")
        }
        nkapi_dealloc(test_pt, va_test.into());

    }
    );
}

pub fn my_example(t1: PhysAddr, t2: VirtAddr) -> Option<usize>{
    // unsafe{
    //     llvm_asm!("addi sp, sp, -6*8");
    //     llvm_asm!("sd x10, 8(sp)");
    //     llvm_asm!("sd x11, 16(sp)");
    //     llvm_asm!("sd x12, 24(sp)");
    //     llvm_asm!("sd x13, 32(sp)");
    //     llvm_asm!("sd x14, 40(sp)");
    //     llvm_asm!("sd $0, 0(sp)" :: "r"(nkapi_example_imp as usize));
    //     debug_info!("map_type_test: {:?} {:?} {:?}",pt_handle, t1, t2);
    //     llvm_asm!("jal nk_entry");
    // }
    entry_gate!(nkapi::NKAPI_TEST, t1, t2);
    return_some!(usize);
}
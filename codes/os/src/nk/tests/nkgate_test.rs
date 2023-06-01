use crate::{entry_gate, return_some, nk::{PhysAddr, nkapi, VirtAddr, nkapi_pt_init, nkapi_alloc, MapPermission, nkapi_dealloc, nkapi_translate_va}, begin_test};


const valA: usize = 66666;

pub fn nkapi_gatetest(){
    begin_test!("nkapi gate test",
    {
        if let Some(adr) = my_example(valA.into(), valA.into()) {
            assert_eq!(adr, valA, "testing return value.");
            println!("nkapi: basic test passed.");
        }

        let test_pt = 2333;
        nkapi_pt_init(test_pt);

        nkapi_alloc(test_pt, 0x100000.into(), crate::nk::MapType::Identical, MapPermission::R);
        if let Some(pa) = nkapi_translate_va(test_pt, 0x100000336.into()) {
            assert_eq!(pa.0, 0x100000336, "testing identical alloc.");
            println!("nkapi: identical alloc test passed.");
        }else{
            panic!("nkapi: identical alloc test failed with None.")
        }
        
        nkapi_dealloc(test_pt, 0x100000.into());
        if let Some(pa) = nkapi_translate_va(test_pt, 0x100000336.into()) {
            panic!("nkapi: identical dealloc test failed.")
        }else{
            println!("nkapi: dealloc test passed.");
        }

        nkapi_alloc(test_pt, 0x100000.into(), crate::nk::MapType::Specified(0x200000.into()), MapPermission::R);
        if let Some(pa) = nkapi_translate_va(test_pt, 0x100000336.into()) {
            assert_eq!(pa.0, 0x200000336, "testing identical alloc.");
            println!("nkapi: specified alloc test passed.");
        }else{
            panic!("nkapi: specified alloc test failed with None.")
        }
        nkapi_dealloc(test_pt, 0x100000.into());

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
    //     println!("map_type_test: {:?} {:?} {:?}",pt_handle, t1, t2);
    //     llvm_asm!("jal nk_entry");
    // }
    entry_gate!(nkapi::NKAPI_TEST, t1, t2);
    return_some!(usize);
}
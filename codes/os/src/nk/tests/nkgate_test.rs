use riscv::paging::MapToError;

use crate::{entry_gate, return_some, nk::{PhysAddr, MapType}, begin_test};


const valA: usize = 66666;
const valB: usize = 55555;
const valC: usize = 23333;

pub fn nkapi_gatetest(){
    begin_test!("nkapi gate test",
    {
        if let Some(adr) = my_example(valA, valB.into(), MapType::Specified(valC.into())) {
            //assert_eq!(adr.0, valC, "testing return value.");
            println!("nkapi_gatetest passed.");
        }
    }
    );
}

pub fn my_example(pt_handle: usize, t1: PhysAddr, t2: MapType) -> Option<PhysAddr>{
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
    entry_gate!(nkapi_example_imp,pt_handle, t1, usize::from(t2));
    return_some!(PhysAddr);
}

fn nkapi_example_imp(pt_handle: usize, t1: PhysAddr, t2: usize) -> Option<PhysAddr>{
    assert_eq!(pt_handle, valA, "testing parameter with type usize.");
    assert_eq!(t1.0, valB, "testing parameter with type PhysAddr.");
    assert_eq!(MapType::from(t2), MapType::Specified(valC.into()), "testing parameter with type MapType.");
    return Some(PhysAddr::from(valC))
}
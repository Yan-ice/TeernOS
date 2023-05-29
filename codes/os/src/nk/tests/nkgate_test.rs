use crate::{entry_gate, return_some, nk::{PhysAddr}, begin_test};


const valA: usize = 66666;
const valB: usize = 55555;
const valC: usize = 23333;

pub fn nkapi_gatetest(){
    begin_test!("nkapi gate test",
    {
        if let Some(adr) = nkapi_example(valA, PhysAddr::from(valB)) {
            assert_eq!(adr.0, valC, "testing return value.");
            println!("nkapi_gatetest passed.");
        }
    }
    );
}

fn nkapi_example(pt_handle: usize, pa: PhysAddr) -> Option<PhysAddr>{
    entry_gate!(nkapi_example_impl,pt_handle,pa);
    return_some!(PhysAddr);
}

fn nkapi_example_impl(pt_handle: usize, pa: PhysAddr) -> Option<PhysAddr>{
    assert_eq!(pt_handle, valA, "testing parameter with type usize.");
    assert_eq!(pa.0, valB, "testing parameter with type PhysAddr.");
    return Some(PhysAddr::from(valC))
}
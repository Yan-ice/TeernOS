use crate::{begin_test};
use crate::debug_info;
use crate::shared::*; use crate::config::*;

const valA: usize = 66666;
const test_pt: usize = 2333;
const va_test: VirtAddr = VirtAddr{0: 0x10000000336};
const pa_test: PhysAddr = PhysAddr{0: 0x20000000336};

pub fn nkapi_gatetest(){
    begin_test!("nkapi gate test",
    {

        nkapi_pt_init(test_pt, true);

        nkapi_alloc(test_pt, va_test.into(), crate::shared::MapType::Identical, MapPermission::R);
        if let Some(pa) = nkapi_translate_va(test_pt, va_test.into()) {
            assert_eq!(pa.0, va_test.0, "testing identical alloc.");
            debug_info!("nkapi: identical alloc test passed.");
        }else{
            panic!("nkapi: identical alloc test failed with None.")
        }
        
        nkapi_dealloc(test_pt, va_test.into());
        if let Some(_) = nkapi_translate_va(test_pt, va_test.into()) {
            panic!("nkapi: identical dealloc test failed.")
        }else{
            debug_info!("nkapi: dealloc test passed.");
        }

        nkapi_alloc(test_pt, va_test.into(), crate::shared::MapType::Specified(pa_test.floor()), MapPermission::R);
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
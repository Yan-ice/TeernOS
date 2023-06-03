use crate::{nk::{nkapi_alloc, nkapi_pt_init, nkapi_dealloc, VirtAddr, MapPermission}, begin_test};

use crate::nk::mm::PROXYCONTEXT;

pub fn mem_access_timecost(){
    nkapi_pt_init(999);
    begin_test!("mem_access_time",
    {
        unsafe{
            println!("enable status: {}",PROXYCONTEXT().nkapi_enable);
            for i in 0..1024{
                nkapi_alloc(999, VirtAddr::from(0x1000000000).into(), 
                crate::nk::MapType::Identical, MapPermission::R | MapPermission::W);
                nkapi_dealloc(999, VirtAddr::from(0x1000000000).into());
            }
            println!("operated 102400 times memory access.");
        }
    }
    );

}
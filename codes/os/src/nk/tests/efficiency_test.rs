// use crate::{nk::{nkapi_alloc, nkapi_pt_init, nkapi_dealloc, VirtAddr, MapPermission}, begin_test};

// use crate::nk::mm::PROXYCONTEXT;
// use crate::debug_info;
// pub fn mem_access_timecost(){
//     return;
//     nkapi_pt_init(999, true);
//     begin_test!("mem_access_time",
//     {
//         unsafe{
//             debug_info!("enable status: {}",PROXYCONTEXT().nkapi_enable);
//             for i in 0..1024{
//                 nkapi_alloc(999, VirtAddr::from(0x1000000000).into(), 
//                 crate::nk::MapType::Identical, MapPermission::R | MapPermission::W);
//                 nkapi_dealloc(999, VirtAddr::from(0x1000000000).into());
//             }
//             debug_info!("operated 102400 times memory access.");
//         }
//     }
//     );

// }
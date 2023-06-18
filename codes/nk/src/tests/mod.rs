//mod efficiency_test;
mod nkgate_test;
use crate::debug_info;
//pub use efficiency_test::mem_access_timecost as mem_access_timecost;
pub use nkgate_test::nkapi_gatetest as nkapi_gatetest;

#[macro_export]
macro_rules! begin_test {
    ($name:expr, $code:block) => {
        debug_info!("===========[TEST {}]============",$name);
        // let mut __time = crate::timer::get_time_ms();
        $code
        // let __duration = crate::timer::get_time_ms() - __time;
        // debug_info!(">>>>> time usage: {} ms",__duration);
        debug_info!("=================================");
    };
}
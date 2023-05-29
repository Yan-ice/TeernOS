mod efficiency_test;
mod nkgate_test;

pub use efficiency_test::mem_access_timecost as mem_access_timecost;
pub use nkgate_test::nkapi_gatetest as nkapi_gatetest;

#[macro_export]
macro_rules! begin_test {
    ($name:expr, $code:block) => {
        println!("===========[TEST {}]============",$name);
        let mut __time = crate::timer::get_time_ms();
        $code
        let __duration = crate::timer::get_time_ms() - __time;
        println!(">>>>> time usage: {} ms",__duration);
        println!("=================================");
    };
}
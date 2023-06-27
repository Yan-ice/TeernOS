#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;

use user_lib::{fork, wait, exit, get_time};

const MAX_CHILD: usize = 30;

#[no_mangle]
pub fn main() -> i32 {
    let time0 = get_time();
    for a in 0..1000 {
    	println!("Forktest {}/1000.",a);
	    for i in 0..MAX_CHILD {
		let pid = fork();
		if pid == 0 {
		    print!("{} ", i);
		    exit(0);
		}
		assert!(pid > 0);
	    }
	    let mut exit_code: i32 = 0;
	    for _ in 0..MAX_CHILD {
		if wait(&mut exit_code) <= 0 {
		    panic!("wait stopped early");
		}
	    }
	    if wait(&mut exit_code) > 0 {
		panic!("wait got too many");
	    }
	    println!("END");
    }
    let time1 = get_time();
    println!("Forktest pass. Time cost: {}", time1-time0);
    0
}

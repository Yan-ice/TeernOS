#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;

use user_lib::{
    fork,
    wait,
    exec,
    yield_,
};

#[no_mangle]
fn main() -> i32 {
    println!{"[user] initproc executed."}
    if fork() == 0 {
        // println!{"fork == 0..."};
        println!{"ready to execute shell"};
        exec("user_shell\0", &[0 as *const u8]);
        println!{"exec shell finish..."}
    } else {
        // println!{"fork != 0..."};
        loop {
            let mut exit_code: i32 = 0;
            println!("wait for child");
            let pid = wait(&mut exit_code);
            if pid == -1 {
            	println!("ready to yield.");
                yield_();
                continue;
            }
            println!(
                "[initproc] Released a zombie process, pid={}, exit_code={}",
                pid,
                exit_code,
            );
        }
    }
    0
}

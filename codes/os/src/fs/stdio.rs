use super::File;
use crate::util::mm_util::{UserBuffer};
use crate::shared::sbi::console_getchar;
use crate::task::suspend_current_and_run_next;
use lazy_static::*;
use spin::Mutex;
use crate::debug_os;
//use crate::task::get_core_id;



pub struct Stdin;

pub struct Stdout;

lazy_static!{
    pub static ref STDOUTLOCK:Mutex<usize> = Mutex::new(0);
    pub static ref STDINLOCK:Mutex<usize> = Mutex::new(0);
}

impl File for Stdin {
    fn readable(&self) -> bool { true }
    fn writable(&self) -> bool { false }
    fn read(&self, mut user_buf: UserBuffer) -> usize {
        //assert_eq!(user_buf.len(), 1);
        let lock = STDINLOCK.lock();
        // busy loop
        let mut c: usize;
        let mut count = 0;
        if user_buf.len() > 1{
            return 0;
        }
        loop {
            c = console_getchar();
            if c == 0 {
                suspend_current_and_run_next();
                continue;
            } else {
                break;
            }
        }
        let ch = c as u8;
        unsafe { 
            user_buf.buffers[0].as_mut_ptr().write_volatile(ch); 
            //user_buf.write_at(count, ch);
        }
        return 1
        /* 
        loop {
            if count == user_buf.len(){
                break;
            }
            loop {
                c = console_getchar();
                if c == 0 {
                    suspend_current_and_run_next();
                    continue;
                } else {
                    break;
                }
            }
            let ch = c as u8;
            if ch as char == '\n' {
                break;
            }
            unsafe { 
                //user_buf.buffers[0].as_mut_ptr().write_volatile(ch); 
                user_buf.write_at(count, ch);
            }
            count += 1;
        }
        count*/
    }
    fn write(&self, _user_buf: UserBuffer) -> usize {
        panic!("Cannot write to stdin!");
    }
}

impl File for Stdout {
    fn readable(&self) -> bool { false }
    fn writable(&self) -> bool { true }
    fn read(&self, _user_buf: UserBuffer) -> usize{
        panic!("Cannot read from stdout!");
    }
    fn write(&self, user_buf: UserBuffer) -> usize {
        let lock = STDOUTLOCK.lock();
        for buffer in user_buf.buffers.iter() {
            print!("{}", core::str::from_utf8(*buffer).unwrap());
        }
        user_buf.len()
    }
}


/// Legacy standard input/output
pub trait LegacyStdio: Send {
    /// Get a character from legacy stdin
    fn getchar(&mut self) -> u8;
    /// Put a character into legacy stdout
    fn putchar(&mut self, ch: u8);
}

/// Use serial in `embedded-hal` as legacy standard input/output
struct EmbeddedHalSerial<T> {
    inner: T,
}

impl<T> EmbeddedHalSerial<T> {
    /// Create a wrapper with a value
    fn new(inner: T) -> Self {
        Self { inner }
    }
}



struct Fused<T, R>(T, R);

use alloc::boxed::Box;

lazy_static::lazy_static! {
    static ref LEGACY_STDIO: Mutex<Option<Box<dyn LegacyStdio>>> =
        Mutex::new(None);
}



use core::fmt;

//struct Stdout;

impl fmt::Write for Stdout {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        if let Some(stdio) = LEGACY_STDIO.lock().as_mut() {
            for byte in s.as_bytes() {
                stdio.putchar(*byte)
            }
        }
        Ok(())
    }
}

#[doc(hidden)]
pub fn _print(args: fmt::Arguments) {
    use fmt::Write;
    Stdout.write_fmt(args).unwrap();
}

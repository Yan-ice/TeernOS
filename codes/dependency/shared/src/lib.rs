#![no_std]
#![feature(llvm_asm)]
#![feature(asm)]
#![feature(global_asm)]

#[macro_use]
pub mod console;
#[macro_use]
pub mod monitor;
#[macro_use]
extern crate bitflags;

pub mod address;
pub mod flags;
pub mod context;
pub mod nkapi;
pub mod sbi;
pub mod config;

pub use address::*;
pub use flags::*;
pub use context::*;
pub use nkapi::*;
pub use sbi::*;
pub use config::*;
pub use monitor::*;

global_asm!(include_str!("nk_gate.S"));

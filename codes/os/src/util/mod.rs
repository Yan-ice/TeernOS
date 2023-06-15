pub mod mm_util;
pub mod o_memory_set;

pub use mm_util::{
    translated_array_copy,
    translated_array_ref
};

pub use o_memory_set::{MemorySet};

#[macro_use]

#[macro_export]
macro_rules! debug_info {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        print!("{} {}", format_args!("\x1b[{}m[info]", 32), format_args!("\x1b[{}m", 37));
        $crate::console::print(format_args!(concat!($fmt, "\x1b[0m\n") $(, $($arg)+)?));
        //$crate::fs::_print(format_args!(core::concat!($fmt, "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! debug_warn {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        print!("{} {}", format_args!("\x1b[{}m[debug]", 33), format_args!("\x1b[{}m", 37));
        $crate::console::print(format_args!(concat!($fmt, "\x1b[0m\n") $(, $($arg)+)?));
        //$crate::fs::_print(format_args!(core::concat!($fmt, "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! debug_error {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        print!("{} {}", format_args!("\x1b[{}m[debug]", 31), format_args!("\x1b[{}m", 37));
        $crate::console::print(format_args!(concat!($fmt, "\x1b[0m\n") $(, $($arg)+)?));
        //$crate::fs::_print(format_args!(core::concat!($fmt, "\n") $(, $($arg)+)?));
    }
}
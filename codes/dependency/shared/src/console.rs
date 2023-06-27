use core::fmt::{self, Write};
use super::sbi::console_putchar;

struct Stdout;

impl Write for Stdout {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        for c in s.chars() {
            console_putchar(c as usize);
        }
        Ok(())
    }
}

pub fn print(args: fmt::Arguments) {

    //here accessible
    Stdout.write_fmt(args).unwrap();
}

//#[cfg(feature = "board_qemu")]
#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!($fmt $(, $($arg)+)?));
        //$crate::fs::_print(format_args!($fmt $(, $($arg)+)?));
    }
}

//#[cfg(feature = "board_qemu")]
#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {

        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?));

        //$crate::fs::_print(format_args!(core::concat!($fmt, "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! debug_info {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!("\x1b[{}m[info] \x1b[{}m", 32, 37));
        $crate::console::print(format_args!(concat!($fmt, "\x1b[0m\n") $(, $($arg)+)?));
        //$crate::fs::_print(format_args!(core::concat!($fmt, "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! debug_os {
    ($fmt: literal $(, $($arg: tt)+)?) => {

        for c in $fmt.chars() {
            $crate::sbi::console_putchar(c as usize);
        }
        $crate::sbi::console_putchar('\n' as usize);
        // $crate::console::print(format_args!("\x1b[{}m[info] \x1b[{}m", 32, 37));
        // $crate::console::print(format_args!(concat!($fmt, "\x1b[0m\n") $(, $($arg)+)?));
        //$crate::fs::_print(format_args!(core::concat!($fmt, "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! debug_warn {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!("\x1b[{}m[warn] \x1b[{}m", 33, 37));
        $crate::console::print(format_args!(concat!($fmt, "\x1b[0m\n") $(, $($arg)+)?));
        //$crate::fs::_print(format_args!(core::concat!($fmt, "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! debug_error {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!("\x1b[{}m[error] \x1b[{}m", 31, 37));
        $crate::console::print(format_args!(concat!($fmt, "\x1b[0m\n") $(, $($arg)+)?));
        //$crate::fs::_print(format_args!(core::concat!($fmt, "\n") $(, $($arg)+)?));
    }
}


/* 
#[cfg(feature = "board_k210")]
#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!($fmt $(, $($arg)+)?));
        //$crate::fs::_print(format_args!($fmt $(, $($arg)+)?));
    }
}

#[cfg(feature = "board_k210")]
#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?));
        //$crate::fs::_print(format_args!(core::concat!($fmt, "\n") $(, $($arg)+)?));
    }
}*/



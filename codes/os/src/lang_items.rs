use core::panic::PanicInfo;
use crate::shared::sbi::shutdown;
use crate::debug_error;

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    if let Some(location) = info.location() {
        debug_error!("[kernel] Panicked at {}:{} {}", location.file(), location.line(), info.message().unwrap());
    } else {
        debug_error!("[kernel] Panicked: {}", info.message().unwrap());
    }
    shutdown()
}

#[macro_export]
macro_rules! color_text {
    ($text:expr, $color:expr) => {{
        format_args!("\x1b[{}m{}\x1b[0m", $color, $text)
    }};
}

pub trait Bytes<T>{
    fn as_bytes(&self) -> &[u8] {
        let size = core::mem::size_of::<T>();
        unsafe {
            core::slice::from_raw_parts(
                self as *const _ as *const T as usize as *const u8,
                size,
            )
        }
    }
    
    fn as_bytes_mut(&mut self) -> &mut [u8] {
        let size = core::mem::size_of::<T>();
        unsafe {
            core::slice::from_raw_parts_mut(
                self as *mut _ as *mut T as usize as *mut u8,
                size,
            )
        }
    }
}

#[cfg(feature = "musl")]
mod sys_musl;

#[cfg(feature = "musl")]
pub use sys_musl::*;

#[cfg(feature = "gnu")]
mod sys_gnu;

#[cfg(feature = "gnu")]
pub use sys_gnu::*;

mod fs;
mod process;
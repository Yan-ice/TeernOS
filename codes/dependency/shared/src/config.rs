#[allow(unused)]

// pub const O_RDONLY: usize = 0x000;
// pub const O_WRONLY: usize = 0x001;
// pub const O_RDWR: usize = 0x002; // 可读可写
// //#define O_CREATE 0x200
// pub const O_CREATE: usize = 0x40;
// pub const O_DIRECTORY: usize = 0x0200000;

// for mmap
pub const PROT_NONE: usize = 0;
pub const PROT_READ: usize = 1;
pub const PROT_WRITE: usize = 2;
pub const PROT_EXEC: usize = 4;
pub const PROT_GROWSDOWN: usize = 0x01000000;
pub const PROT_GROWSUP: usize = 0x02000000;

pub const MAP_FILE: usize = 0;
pub const MAP_SHARED: usize = 0x01;
pub const MAP_PRIVATE: usize = 0x02;
pub const MAP_ANONYMOUS: usize = 0x20;
pub const MAP_FIXED: usize = 0x10;

pub const MAP_FAILED: isize = -1;

// Memory management
pub const PAGE_SIZE: usize = 0x1000;//should not change
pub const PAGE_SIZE_BITS: usize = 0xc;
pub const SIGNAL_STACK_SIZE: usize = PAGE_SIZE;

 pub const KMMAP_BASE: usize = 0x90000000;
 pub const MMAP_BASE: usize = 0x60000000;
 
 pub const NK_TRAMPOLINE: usize = usize::MAX - PAGE_SIZE + 1;
 pub const TRAMPOLINE: usize = usize::MAX - 2*PAGE_SIZE + 1;
 pub const PROXY_CONTEXT: usize = usize::MAX - 3*PAGE_SIZE + 1;
 
 pub const SIGNAL_TRAMPOLINE: usize = 0x80000000 - PAGE_SIZE;
 pub const TRAP_CONTEXT: usize = SIGNAL_TRAMPOLINE - PAGE_SIZE;
 pub const USER_STACK: usize = TRAP_CONTEXT - PAGE_SIZE;

 
///////////////////////////////////
/// 
/// the value below is NK call number.
/// 

pub const NKAPI_CONFIG: usize = 0;
pub const NKAPI_TRAP_HANDLE: usize = 1;
pub const NKAPI_PT_INIT: usize = 2;
pub const NKAPI_ALLOC: usize = 3;
pub const NKAPI_DEALLOC: usize = 4;
pub const NKAPI_ACTIVATE: usize = 5;
pub const NKAPI_COPY_TO: usize = 6;
pub const NKAPI_TRANSLATE: usize = 7;
pub const NKAPI_GET_PTE: usize = 8;
pub const NKAPI_FORK_PTE: usize = 9;
pub const NKAPI_SET_PERM: usize = 10;
pub const NKAPI_TIME: usize = 11;
pub const NKAPI_DEBUG: usize = 12;
///
///////////////////////////////////

///////////////////////////////////
/// 
/// the value below is NK_TRAP_HANDLE param.
/// 

pub const NKCFG_DELEGATE: usize = 1; // config the trap delegation target address.
pub const NKCFG_SIGNAL: usize = 2;
pub const NKCFG_ALLOCATOR_START: usize = 3;
pub const NKCFG_ALLOCATOR_END: usize = 4;
///
///////////////////////////////////
/// 

// Execution of programs
pub const  AT_NULL      : usize = 0 ;    /* end of vector */
pub const  AT_IGNORE    : usize = 1 ;    /* entry should be ignored */
pub const  AT_EXECFD    : usize = 2 ;    /* file descriptor of program */
pub const  AT_PHDR      : usize = 3 ;    /* program headers for program */
pub const  AT_PHENT     : usize = 4 ;    /* size of program header entry */
pub const  AT_PHNUM     : usize = 5 ;    /* number of program headers */
pub const  AT_PAGESZ    : usize = 6 ;    /* system page size */
pub const  AT_BASE      : usize = 7 ;    /* base address of interpreter */
pub const  AT_FLAGS     : usize = 8 ;    /* flags */
pub const  AT_ENTRY     : usize = 9 ;    /* entry point of program */
pub const  AT_NOTELF    : usize = 10;    /* program is not ELF */
pub const  AT_UID       : usize = 11;    /* real uid */
pub const  AT_EUID      : usize = 12;    /* effective uid */
pub const  AT_GID       : usize = 13;    /* real gid */
pub const  AT_EGID      : usize = 14;    /* effective gid */
pub const  AT_PLATFORM  : usize = 15;  /* string identifying CPU for optimizations */
pub const  AT_HWCAP     : usize = 16;    /* arch dependent hints at CPU capabilities */
pub const  AT_CLKTCK    : usize = 17;    /* frequency at which times() increments */
/* AT_* values 18 through 22 are reserved */
pub const AT_SECURE     : usize = 23;   /* secure mode boolean */
pub const AT_BASE_PLATFORM : usize = 24;     /* string identifying real platform, may
                                 * differ from AT_PLATFORM. */
pub const AT_RANDOM     : usize = 25;    /* address of 16 random bytes */
pub const AT_HWCAP2     : usize = 26;    /* extension of AT_HWCAP */

pub const AT_EXECFN     : usize = 31;   /* filename of program */
/* Pointer to the global system page used for system calls and other
   nice things.  */
pub const AT_SYSINFO	: usize = 32;
pub const AT_SYSINFO_EHDR: usize = 	33;

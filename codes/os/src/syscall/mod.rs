const SYSCALL_READ: usize = 0;
const SYSCALL_WRITE: usize = 1;
const SYSCALL_OPEN: usize = 2;
const SYSCALL_CLOSE: usize = 3;
const SYSCALL_NEWSTAT: usize = 4;
const SYSCALL_NEWFSTAT: usize = 5;
const SYSCALL_NEWLSTAT: usize = 6;
const SYSCALL_POLL: usize = 7;
const SYSCALL_LSEEK: usize = 8;
const SYSCALL_MMAP: usize = 9;
const SYSCALL_MPROTECT: usize = 10;
const SYSCALL_MUNMAP: usize = 11;
const SYSCALL_BRK: usize = 12;
const SYSCALL_RT_SIGACTION: usize = 13;
const SYSCALL_RT_SIGPROCMASK: usize = 14;
const STUB_RT_SIGRETURN: usize = 15;
const SYSCALL_IOCTL: usize = 16;
const SYSCALL_PREAD64: usize = 17;
const SYSCALL_PWRITE64: usize = 18;
const SYSCALL_READV: usize = 19;
const SYSCALL_WRITEV: usize = 20;
const SYSCALL_ACCESS: usize = 21;
const SYSCALL_PIPE: usize = 22;
const SYSCALL_SELECT: usize = 23;
const SYSCALL_SCHED_YIELD: usize = 24;
const SYSCALL_MREMAP: usize = 25;
const SYSCALL_MSYNC: usize = 26;
const SYSCALL_MINCORE: usize = 27;
const SYSCALL_MADVISE: usize = 28;
const SYSCALL_SHMGET: usize = 29;
const SYSCALL_SHMAT: usize = 30;
const SYSCALL_SHMCTL: usize = 31;
const SYSCALL_DUP: usize = 32;
const SYSCALL_DUP2: usize = 33;
const SYSCALL_PAUSE: usize = 34;
const SYSCALL_NANOSLEEP: usize = 35;
const SYSCALL_GETITIMER: usize = 36;
const SYSCALL_ALARM: usize = 37;
const SYSCALL_SETITIMER: usize = 38;
const SYSCALL_GETPID: usize = 39;
const SYSCALL_SENDFILE64: usize = 40;
const SYSCALL_SOCKET: usize = 41;
const SYSCALL_CONNECT: usize = 42;
const SYSCALL_ACCEPT: usize = 43;
const SYSCALL_SENDTO: usize = 44;
const SYSCALL_RECVFROM: usize = 45;
const SYSCALL_SENDMSG: usize = 46;
const SYSCALL_RECVMSG: usize = 47;
const SYSCALL_SHUTDOWN: usize = 48;
const SYSCALL_BIND: usize = 49;
const SYSCALL_LISTEN: usize = 50;
const SYSCALL_GETSOCKNAME: usize = 51;
const SYSCALL_GETPEERNAME: usize = 52;
const SYSCALL_SOCKETPAIR: usize = 53;
const SYSCALL_SETSOCKOPT: usize = 54;
const SYSCALL_GETSOCKOPT: usize = 55;
const STUB_CLONE: usize = 56;
const STUB_FORK: usize = 57;
const STUB_VFORK: usize = 58;
const STUB_EXECVE: usize = 59;
const SYSCALL_EXIT: usize = 60;
const SYSCALL_WAIT4: usize = 61;
const SYSCALL_KILL: usize = 62;
const SYSCALL_NEWUNAME: usize = 63;
const SYSCALL_SEMGET: usize = 64;
const SYSCALL_SEMOP: usize = 65;
const SYSCALL_SEMCTL: usize = 66;
const SYSCALL_SHMDT: usize = 67;
const SYSCALL_MSGGET: usize = 68;
const SYSCALL_MSGSND: usize = 69;
const SYSCALL_MSGRCV: usize = 70;
const SYSCALL_MSGCTL: usize = 71;
const SYSCALL_FCNTL: usize = 72;
const SYSCALL_FLOCK: usize = 73;
const SYSCALL_FSYNC: usize = 74;
const SYSCALL_FDATASYNC: usize = 75;
const SYSCALL_TRUNCATE: usize = 76;
const SYSCALL_FTRUNCATE: usize = 77;
const SYSCALL_GETDENTS: usize = 78;
const SYSCALL_GETCWD: usize = 79;
const SYSCALL_CHDIR: usize = 80;
const SYSCALL_FCHDIR: usize = 81;
const SYSCALL_RENAME: usize = 82;
const SYSCALL_MKDIR: usize = 83;
const SYSCALL_RMDIR: usize = 84;
const SYSCALL_CREAT: usize = 85;
const SYSCALL_LINK: usize = 86;
const SYSCALL_UNLINK: usize = 87;
const SYSCALL_SYMLINK: usize = 88;
const SYSCALL_READLINK: usize = 89;
const SYSCALL_CHMOD: usize = 90;
const SYSCALL_FCHMOD: usize = 91;
const SYSCALL_CHOWN: usize = 92;
const SYSCALL_FCHOWN: usize = 93;
const SYSCALL_LCHOWN: usize = 94;
const SYSCALL_UMASK: usize = 95;
const SYSCALL_GETTIMEOFDAY: usize = 96;
const SYSCALL_GETRLIMIT: usize = 97;
const SYSCALL_GETRUSAGE: usize = 98;
const SYSCALL_SYSINFO: usize = 99;
const SYSCALL_TIMES: usize = 100;
const SYSCALL_PTRACE: usize = 101;
const SYSCALL_GETUID: usize = 102;
const SYSCALL_SYSLOG: usize = 103;
const SYSCALL_GETGID: usize = 104;
const SYSCALL_SETUID: usize = 105;
const SYSCALL_SETGID: usize = 106;
const SYSCALL_GETEUID: usize = 107;
const SYSCALL_GETEGID: usize = 108;
const SYSCALL_SETPGID: usize = 109;
const SYSCALL_GETPPID: usize = 110;
const SYSCALL_GETPGRP: usize = 111;
const SYSCALL_SETSID: usize = 112;
const SYSCALL_SETREUID: usize = 113;
const SYSCALL_SETREGID: usize = 114;
const SYSCALL_GETGROUPS: usize = 115;
const SYSCALL_SETGROUPS: usize = 116;
const SYSCALL_SETRESUID: usize = 117;
const SYSCALL_GETRESUID: usize = 118;
const SYSCALL_SETRESGID: usize = 119;
const SYSCALL_GETRESGID: usize = 120;
const SYSCALL_GETPGID: usize = 121;
const SYSCALL_SETFSUID: usize = 122;
const SYSCALL_SETFSGID: usize = 123;
const SYSCALL_GETSID: usize = 124;
const SYSCALL_CAPGET: usize = 125;
const SYSCALL_CAPSET: usize = 126;
const SYSCALL_RT_SIGPENDING: usize = 127;
const SYSCALL_RT_SIGTIMEDWAIT: usize = 128;
const SYSCALL_RT_SIGQUEUEINFO: usize = 129;
const SYSCALL_RT_SIGSUSPEND: usize = 130;
const SYSCALL_SIGALTSTACK: usize = 131;
const SYSCALL_UTIME: usize = 132;
const SYSCALL_MKNOD: usize = 133;
const 聽: usize = 134;
const SYSCALL_PERSONALITY: usize = 135;
const SYSCALL_USTAT: usize = 136;
const SYSCALL_STATFS: usize = 137;
const SYSCALL_FSTATFS: usize = 138;
const SYSCALL_SYSFS: usize = 139;
const SYSCALL_GETPRIORITY: usize = 140;
const SYSCALL_SETPRIORITY: usize = 141;
const SYSCALL_SCHED_SETPARAM: usize = 142;
const SYSCALL_SCHED_GETPARAM: usize = 143;
const SYSCALL_SCHED_SETSCHEDULER: usize = 144;
const SYSCALL_SCHED_GETSCHEDULER: usize = 145;
const SYSCALL_SCHED_GET_PRIORITY_MAX: usize = 146;
const SYSCALL_SCHED_GET_PRIORITY_MIN: usize = 147;
const SYSCALL_SCHED_RR_GET_INTERVAL: usize = 148;
const SYSCALL_MLOCK: usize = 149;
const SYSCALL_MUNLOCK: usize = 150;
const SYSCALL_MLOCKALL: usize = 151;
const SYSCALL_MUNLOCKALL: usize = 152;
const SYSCALL_VHANGUP: usize = 153;
const SYSCALL_MODIFY_LDT: usize = 154;
const SYSCALL_PIVOT_ROOT: usize = 155;
const SYSCALL_SYSCTL: usize = 156;
const SYSCALL_PRCTL: usize = 157;
const SYSCALL_ARCH_PRCTL: usize = 158;
const SYSCALL_ADJTIMEX: usize = 159;
const SYSCALL_SETRLIMIT: usize = 160;
const SYSCALL_CHROOT: usize = 161;
const SYSCALL_SYNC: usize = 162;
const SYSCALL_ACCT: usize = 163;
const SYSCALL_SETTIMEOFDAY: usize = 164;
const SYSCALL_MOUNT: usize = 165;
const SYSCALL_UMOUNT: usize = 166;
const SYSCALL_SWAPON: usize = 167;
const SYSCALL_SWAPOFF: usize = 168;
const SYSCALL_REBOOT: usize = 169;
const SYSCALL_SETHOSTNAME: usize = 170;
const SYSCALL_SETDOMAINNAME: usize = 171;
const STUB_IOPL: usize = 172;
const SYSCALL_IOPERM: usize = 173;

const SYSCALL_INIT_MODULE: usize = 175;
const SYSCALL_DELETE_MODULE: usize = 176;


const SYSCALL_QUOTACTL: usize = 179;






const SYSCALL_GETTID: usize = 186;
const SYSCALL_READAHEAD: usize = 187;
const SYSCALL_SETXATTR: usize = 188;
const SYSCALL_LSETXATTR: usize = 189;
const SYSCALL_FSETXATTR: usize = 190;
const SYSCALL_GETXATTR: usize = 191;
const SYSCALL_LGETXATTR: usize = 192;
const SYSCALL_FGETXATTR: usize = 193;
const SYSCALL_LISTXATTR: usize = 194;
const SYSCALL_LLISTXATTR: usize = 195;
const SYSCALL_FLISTXATTR: usize = 196;
const SYSCALL_REMOVEXATTR: usize = 197;
const SYSCALL_LREMOVEXATTR: usize = 198;
const SYSCALL_FREMOVEXATTR: usize = 199;
const SYSCALL_TKILL: usize = 200;
const SYSCALL_TIME: usize = 201;
const SYSCALL_FUTEX: usize = 202;
const SYSCALL_SCHED_SETAFFINITY: usize = 203;
const SYSCALL_SCHED_GETAFFINITY: usize = 204;

const SYSCALL_IO_SETUP: usize = 206;
const SYSCALL_IO_DESTROY: usize = 207;
const SYSCALL_IO_GETEVENTS: usize = 208;
const SYSCALL_IO_SUBMIT: usize = 209;
const SYSCALL_IO_CANCEL: usize = 210;

const SYSCALL_LOOKUP_DCOOKIE: usize = 212;
const SYSCALL_EPOLL_CREATE: usize = 213;


const SYSCALL_REMAP_FILE_PAGES: usize = 216;
const SYSCALL_GETDENTS64: usize = 217;
const SYSCALL_SET_TID_ADDRESS: usize = 218;
const SYSCALL_RESTART_SYSCALL: usize = 219;
const SYSCALL_SEMTIMEDOP: usize = 220;
const SYSCALL_FADVISE64: usize = 221;
const SYSCALL_TIMER_CREATE: usize = 222;
const SYSCALL_TIMER_SETTIME: usize = 223;
const SYSCALL_TIMER_GETTIME: usize = 224;
const SYSCALL_TIMER_GETOVERRUN: usize = 225;
const SYSCALL_TIMER_DELETE: usize = 226;
const SYSCALL_CLOCK_SETTIME: usize = 227;
const SYSCALL_CLOCK_GETTIME: usize = 228;
const SYSCALL_CLOCK_GETRES: usize = 229;
const SYSCALL_CLOCK_NANOSLEEP: usize = 230;
const SYSCALL_EXIT_GROUP: usize = 231;
const SYSCALL_EPOLL_WAIT: usize = 232;
const SYSCALL_EPOLL_CTL: usize = 233;
const SYSCALL_TGKILL: usize = 234;
const SYSCALL_UTIMES: usize = 235;

const SYSCALL_MBIND: usize = 237;
const SYSCALL_SET_MEMPOLICY: usize = 238;
const SYSCALL_GET_MEMPOLICY: usize = 239;
const SYSCALL_MQ_OPEN: usize = 240;
const SYSCALL_MQ_UNLINK: usize = 241;
const SYSCALL_MQ_TIMEDSEND: usize = 242;
const SYSCALL_MQ_TIMEDRECEIVE: usize = 243;
const SYSCALL_MQ_NOTIFY: usize = 244;
const SYSCALL_MQ_GETSETATTR: usize = 245;
const SYSCALL_KEXEC_LOAD: usize = 246;
const SYSCALL_WAITID: usize = 247;
const SYSCALL_ADD_KEY: usize = 248;
const SYSCALL_REQUEST_KEY: usize = 249;
const SYSCALL_KEYCTL: usize = 250;
const SYSCALL_IOPRIO_SET: usize = 251;
const SYSCALL_IOPRIO_GET: usize = 252;
const SYSCALL_INOTIFY_INIT: usize = 253;
const SYSCALL_INOTIFY_ADD_WATCH: usize = 254;
const SYSCALL_INOTIFY_RM_WATCH: usize = 255;
const SYSCALL_MIGRATE_PAGES: usize = 256;
const SYSCALL_OPENAT: usize = 257;
const SYSCALL_MKDIRAT: usize = 258;
const SYSCALL_MKNODAT: usize = 259;
const SYSCALL_FCHOWNAT: usize = 260;
const SYSCALL_FUTIMESAT: usize = 261;
const SYSCALL_NEWFSTATAT: usize = 262;
const SYSCALL_UNLINKAT: usize = 263;
const SYSCALL_RENAMEAT: usize = 264;
const SYSCALL_LINKAT: usize = 265;
const SYSCALL_SYMLINKAT: usize = 266;
const SYSCALL_READLINKAT: usize = 267;
const SYSCALL_FCHMODAT: usize = 268;
const SYSCALL_FACCESSAT: usize = 269;
const SYSCALL_PSELECT6: usize = 270;
const SYSCALL_PPOLL: usize = 271;
const SYSCALL_UNSHARE: usize = 272;
const SYSCALL_SET_ROBUST_LIST: usize = 273;
const SYSCALL_GET_ROBUST_LIST: usize = 274;
const SYSCALL_SPLICE: usize = 275;
const SYSCALL_TEE: usize = 276;
const SYSCALL_SYNC_FILE_RANGE: usize = 277;
const SYSCALL_VMSPLICE: usize = 278;
const SYSCALL_MOVE_PAGES: usize = 279;
const SYSCALL_UTIMENSAT: usize = 280;
const SYSCALL_EPOLL_PWAIT: usize = 281;
const SYSCALL_SIGNALFD: usize = 282;
const SYSCALL_TIMERFD_CREATE: usize = 283;
const SYSCALL_EVENTFD: usize = 284;
const SYSCALL_FALLOCATE: usize = 285;
const SYSCALL_TIMERFD_SETTIME: usize = 286;
const SYSCALL_TIMERFD_GETTIME: usize = 287;
const SYSCALL_ACCEPT4: usize = 288;
const SYSCALL_SIGNALFD4: usize = 289;
const SYSCALL_EVENTFD2: usize = 290;
const SYSCALL_EPOLL_CREATE1: usize = 291;
const SYSCALL_DUP3: usize = 292;
const SYSCALL_PIPE2: usize = 293;
const SYSCALL_INOTIFY_INIT1: usize = 294;
const SYSCALL_PREADV: usize = 295;
const SYSCALL_PWRITEV: usize = 296;
const SYSCALL_RT_TGSIGQUEUEINFO: usize = 297;
const SYSCALL_PERF_EVENT_OPEN: usize = 298;
const SYSCALL_RECVMMSG: usize = 299;
const SYSCALL_FANOTIFY_INIT: usize = 300;
const SYSCALL_FANOTIFY_MARK: usize = 301;
const SYSCALL_PRLIMIT64: usize = 302;
const SYSCALL_NAME_TO_HANDLE_AT: usize = 303;
const SYSCALL_OPEN_BY_HANDLE_AT: usize = 304;
const SYSCALL_CLOCK_ADJTIME: usize = 305;
const SYSCALL_SYNCFS: usize = 306;
const SYSCALL_SENDMMSG: usize = 307;
const SYSCALL_SETNS: usize = 308;
const SYSCALL_GETCPU: usize = 309;
const SYSCALL_PROCESS_VM_READV: usize = 310;
const SYSCALL_PROCESS_VM_WRITEV: usize = 311;
const SYSCALL_KCMP: usize = 312;
const SYSCALL_FINIT_MODULE: usize = 313;


// const SYSCALL_GETCWD: usize = 17;
// const SYSCALL_DUP: usize = 23;
// const SYSCALL_DUP3:usize = 24;
// const SYSCALL_FCNTL:usize = 25;
// const SYSCALL_IOCTL:usize = 29;
// const SYSCALL_MKDIRAT: usize = 34;
// const SYSCALL_UNLINKAT: usize = 35;
// const SYSCALL_LINKAT: usize = 37;
// const SYSCALL_UMOUNT2: usize = 39;
// const SYSCALL_MOUNT: usize = 40;
// const SYSCALL_FACCESSAT: usize = 48;
// const SYSCALL_CHDIR: usize = 49;
// const SYSCALL_OPENAT: usize = 56;
// const SYSCALL_CLOSE: usize = 57;
// const SYSCALL_PIPE: usize = 59;
// const SYSCALL_GETDENTS64: usize = 61;
// const SYSCALL_LSEEK: usize = 62;
// const SYSCALL_READ: usize = 63;
// const SYSCALL_WRITE: usize = 64;
// const SYSCALL_WRITEV: usize = 66;
// const SYSCALL_SENDFILE: usize = 71;
// const SYSCALL_PSELECT6: usize = 72;
// const SYSCALL_READLINKAT: usize = 78;
// const SYSCALL_NEW_FSTATAT: usize = 79;
// const SYSCALL_FSTAT:usize = 80;
// const SYSCALL_FSYNC:usize = 82;
// const SYSCALL_UTIMENSAT:usize = 88;
// const SYSCALL_EXIT: usize = 93;
// const SYSCALL_EXIT_GRUOP: usize = 94;
// const SYSCALL_SET_TID_ADDRESS: usize = 96;
// const SYSCALL_NANOSLEEP: usize = 101;
// const SYSCALL_GETITIMER: usize = 102;
// const SYSCALL_SETITIMER: usize = 103;
// const SYSCALL_CLOCK_GETTIME: usize = 113;
// const SYSCALL_YIELD: usize = 124;
// const SYSCALL_KILL: usize = 129;
// const SYSCALL_SIGACTION: usize = 134;
// const SYSCALL_SIGRETURN: usize = 139;
// const SYSCALL_TIMES: usize = 153;
// const SYSCALL_UNAME: usize = 160;
// const SYSCALL_GETRUSAGE: usize = 165;
// const SYSCALL_GET_TIME_OF_DAY: usize = 169;
// const SYSCALL_GETPID: usize = 172;
// const SYSCALL_GETPPID: usize = 173;
// const SYSCALL_GETUID: usize = 174;
// const SYSCALL_GETEUID: usize = 175;
// const SYSCALL_GETGID: usize = 176;
// const SYSCALL_GETEGID: usize = 177;
// const SYSCALL_GETTID: usize = 177;
// const SYSCALL_SBRK: usize = 213;
// const SYSCALL_BRK: usize = 214;
// const SYSCALL_MUNMAP: usize = 215;
// const SYSCALL_CLONE: usize = 220;
// const SYSCALL_EXEC: usize = 221;
// const SYSCALL_MMAP: usize = 222;
// const SYSCALL_MPROTECT: usize = 226;
// const SYSCALL_WAIT4: usize = 260;
// const SYSCALL_PRLIMIT: usize = 261;
// const SYSCALL_RENAMEAT2: usize = 276;

// // Not standard POSIX sys_call
// const SYSCALL_LS: usize = 500;
// const SYSCALL_SHUTDOWN: usize = 501;
// const SYSCALL_CLEAR: usize = 502;

mod fs;
mod process;

pub use fs::*;
use process::*;
use crate::gdb_print;
use crate::monitor::*;
use crate::shared::sbi::shutdown;
use crate::task::current_task;
use crate::task::current_user_id;
use crate::timer::get_timeval;
use crate::debug_os;
//use crate::fs::Dirent;

pub fn test() {
    if sys_getpid() == 1{
        let start = get_timeval();
        // debug_os!("test: run sys_getppid 1000000 times, start {:?}",start);
        for _ in 0..1000000{
            syscall(SYSCALL_GETPPID,[0,0,0,0,0,0]);
            // unsafe{
            //     asm!(
            //         "sfence.vma",
            //     );
            // }
        }
        let end = get_timeval();
        // debug_os!("test: run sys_getppid 1000000 times, end {:?}",end);
        debug_os!("test: run sys_getppid + sfence.vma 1000000 times, spent {:?}",end-start);
    }
}

pub fn syscall(syscall_id: usize, args: [usize; 6]) -> isize {
    gdb_print!(SYSCALL_ENABLE,"syscall-({}) arg0 = {}, arg1 = {}\n",syscall_id, args[0] as isize, args[1] as isize);
    //if syscall_id != 64 && syscall_id != 63 && syscall_id != 61 {
    //    gdb_print!(SYSCALL_ENABLE,"syscall-({}) arg0 = {}, arg1 = {}\n",syscall_id, args[0] as isize, args[1] as isize);
    //    //debug_os!("syscallid-{}", syscall_id);
    //} else {
    //    if args[0] != 0 && args[0] != 1 && args[0] != 2{
    //        // gdb_print!(SYSCALL_ENABLE,"syscall-({}) arg0 = {}, arg1 = {}\n",syscall_id, args[0] as isize, args[1] as isize);
    //    }
    //}
    if syscall_id == 999 {
        
        debug_info!("syscall test: {}",args[0]);
        return 0;
    }
    // if sys_getpid() == 1{
    //     test();
    // }
    if current_user_id() > 2 {
        debug_info!("SYSCALL [{}] params: {:?}",syscall_id, args);
    }
    
    
    match syscall_id {
        SYSCALL_SIGRETURN => sys_sigreturn(),
        SYSCALL_GETCWD=> sys_getcwd(args[0] as *mut u8, args[1] as usize),
        SYSCALL_DUP=> sys_dup(args[0]),
        SYSCALL_DUP3=> sys_dup3(args[0] as usize, args[1] as usize),
        
        SYSCALL_FCNTL=> fcntl(args[0], args[1] as u32, args[3]),
        SYSCALL_IOCTL=> sys_ioctl(args[0], args[1] as u32, args[2]),
        SYSCALL_MKDIRAT=> sys_mkdir(args[0] as isize, args[1] as *const u8, args[2] as u32),
        //SYSCALL_UNLINKAT=> sys_unlinkat(args[0] as i32, args[1] as *const u8, args[2] as i32,args[3] as *const u8,args[4] as u32),
        SYSCALL_UNLINKAT=> sys_unlinkat(args[0] as i32, args[1] as *const u8, args[2] as u32),
        SYSCALL_GETITIMER => sys_getitimer(args[0] as isize, args[1] as *mut u8),
        SYSCALL_SETITIMER => sys_setitimer(args[0] as isize, args[1] as *mut usize, args[2] as *mut u8),
        SYSCALL_UMOUNT2=> sys_umount(args[0] as *const u8, args[1] as usize),
        SYSCALL_MOUNT=> sys_mount(args[0] as *const u8, args[1] as *const u8, args[2] as *const u8, args[3] as usize, args[4] as *const u8),
        /* faccessat is fake */
        SYSCALL_FACCESSAT => sys_utimensat(args[0], args[1] as *const u8, args[2], 0),
        SYSCALL_CHDIR=> sys_chdir(args[0] as *const u8),
        //SYSCALL_OPEN => sys_open(args[0] as *const u8, args[1] as u32),
        SYSCALL_OPENAT=> sys_open_at(args[0] as isize, args[1] as *const u8, args[2] as u32, args[3] as u32),
        SYSCALL_CLOSE => sys_close(args[0]),
        SYSCALL_PIPE => sys_pipe(args[0] as *mut u32, args[1] as usize),
        
        SYSCALL_GETDENTS64 => sys_getdents64(args[0] as isize, args[1] as *mut u8, args[2] as usize),
        SYSCALL_LSEEK=> sys_lseek(args[0] as usize, args[1] as isize, args[2] as i32),
        SYSCALL_READ => sys_read(args[0], args[1] as *const u8, args[2]),
        SYSCALL_WRITE => sys_write(args[0], args[1] as *const u8, args[2]),
        SYSCALL_WRITEV => sys_writev(args[0], args[1], args[2]),
        SYSCALL_SENDFILE=> sys_sendfile(args[0] as isize, args[1] as isize, args[2] as *mut usize, args[3] as usize),
        SYSCALL_PSELECT6=> {
            unsafe {
                //llvm_asm!("sfence.vma" :::: "volatile");
            }
            sys_pselect(
            args[0] as usize, args[1] as *mut u8, 
            args[2] as *mut u8, args[3] as *mut u8, 
            args[4] as *mut usize
        )},
        SYSCALL_READLINKAT=> sys_readlinkat(args[0] as isize, args[1] as *const u8, args[2] as *mut u8, args[3] as usize),
        SYSCALL_NEW_FSTATAT => sys_newfstatat(args[0] as isize, args[1] as *const u8, args[2] as *mut u8, args[3] as u32),
        SYSCALL_FSTAT=> sys_fstat(args[0] as isize, args[1] as *mut u8),
        SYSCALL_FSYNC=> 0,//panic!("not support fsync yet"),
        SYSCALL_UTIMENSAT => sys_utimensat(args[0], args[1] as *const u8, args[2], args[3] as u32),

        SYSCALL_SET_TID_ADDRESS => sys_set_tid_address(args[0] as usize),
        SYSCALL_EXIT => {
            unsafe {
                //llvm_asm!("sfence.vma" :::: "volatile");
            }
            sys_exit(args[0] as i32)
        },
        SYSCALL_EXIT_GRUOP => {
            unsafe {
                //llvm_asm!("sfence.vma" :::: "volatile");
            }
            sys_exit(args[0] as i32)
        },
        SYSCALL_NANOSLEEP => sys_sleep(args[0] as *mut u64, args[1] as *mut u64),
        SYSCALL_CLOCK_GETTIME => {
            unsafe {
                //llvm_asm!("sfence.vma" :::: "volatile");
            }
            sys_clock_get_time(args[0] as usize, args[1] as *mut u64)
        },
        SYSCALL_YIELD => sys_yield(),
        SYSCALL_KILL => sys_kill(args[0] as isize, args[1] as isize),
        SYSCALL_SIGACTION => sys_sigaction(args[0] as isize, args[1] as *mut usize, args[2] as *mut usize),
        SYSCALL_TIMES => sys_times(args[0] as *mut i64),
        SYSCALL_UNAME => sys_uname(args[0] as *mut u8),
        // SYSCALL_GETRUSAGE => sys_getrusage(args[0] as isize, args[1] as *mut u8),
        SYSCALL_GET_TIME_OF_DAY => sys_get_time_of_day(args[0] as *mut u64),
        SYSCALL_SBRK => sys_sbrk(args[0] as isize, args[1] as usize),
        SYSCALL_BRK => sys_brk(args[0]),

        SYSCALL_GETPID => sys_getpid(),
        SYSCALL_GETPPID => sys_getppid(),
        SYSCALL_GETUID => sys_getuid(),
        SYSCALL_GETEUID => sys_geteuid(),
        SYSCALL_GETGID => sys_getgid(),
        SYSCALL_GETEGID => sys_getegid(),
        SYSCALL_GETTID => sys_gettid(),

        SYSCALL_CLONE => {
            unsafe {
                //llvm_asm!("sfence.vma" :::: "volatile");
            }
            sys_fork(args[0] as usize, args[1] as  usize, args[2] as  usize, args[3] as  usize, args[4] as usize)
        },
        SYSCALL_EXEC => {
            unsafe {
                //llvm_asm!("sfence.vma" :::: "volatile");
            }
            sys_exec(args[0] as *const u8, args[1] as *const usize)
        },
        SYSCALL_WAIT4 => {
            unsafe {
                //llvm_asm!("sfence.vma" :::: "volatile");
            }
            sys_wait4(args[0] as isize, args[1] as *mut i32, args[2] as isize)
        },
        SYSCALL_PRLIMIT => 0,
        
        SYSCALL_RENAMEAT2 => sys_renameat2(
            args[0] as isize, args[1] as *const u8,
            args[2] as isize, args[3] as *const u8, args[4] as u32
        ),
        
        // SYSCALL_WAITPID => sys_waitpid(args[0] as isize, args[1] as *mut i32),
        SYSCALL_MMAP => {
            unsafe {
                //llvm_asm!("sfence.vma" :::: "volatile");
            }
            sys_mmap(args[0] as usize, args[1] as usize, args[2] as usize, 
            args[3] as usize, args[4] as isize, args[5] as usize)
        },
        SYSCALL_MUNMAP => { 
            unsafe {
                //llvm_asm!("sfence.vma" :::: "volatile");
            }
            sys_munmap(args[0] as usize, args[1] as usize) 
        },
        SYSCALL_MPROTECT => {sys_mprotect(args[0] as usize, args[1] as usize, args[2] as isize)},
        SYSCALL_LS => sys_ls(args[0] as *const u8),
        SYSCALL_SHUTDOWN => shutdown(),
        SYSCALL_CLEAR => sys_clear(args[0] as *const u8),
        _ => 0
        //_ => {debug_os!("Unsupported syscall_id:{}, arg0={} arg1={}", syscall_id, args[0], args[1]); 0}
        //_ => panic!("Unsupported syscall_id: {}", syscall_id),

    }
}


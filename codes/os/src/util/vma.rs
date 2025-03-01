use crate::shared::{VirtAddr};
use crate::config::PAGE_SIZE;
use crate::fs::{File, FileClass};
use crate::task::FdTable;
use alloc::vec::Vec;

use crate::util::mm_util::{UserBuffer, translated_raw};

bitflags! {
    pub struct MmapProts: usize {
        const PROT_NONE = 0;
        const PROT_READ = 1;
        const PROT_WRITE = 2;
        const PROT_EXEC = 4;
        const PROT_GROWSDOWN = 0x01000000;
        const PROT_GROWSUP = 0x02000000;
    }
}

bitflags! {
    pub struct MmapFlags: usize {
        const MAP_FILE = 0;
        const MAP_SHARED= 0x01;
        const MAP_PRIVATE = 0x02;
        const MAP_FIXED = 0x10;
        const MAP_ANONYMOUS = 0x20;
    }
}

pub struct MmapArea {
    pub mmap_start: VirtAddr,
    pub mmap_top: VirtAddr,
    pub mmap_set: Vec<MmapSpace>,
}

impl MmapArea {
    pub fn new(
        mmap_start: VirtAddr,
        mmap_top: VirtAddr
    ) -> Self {
        Self {
            mmap_start,
            mmap_top,
            mmap_set: Vec::new(),
        }
    }

    pub fn get_mmap_top(&mut self) -> VirtAddr { self.mmap_top }

    pub fn lazy_map_page(&mut self, stval: usize, fd_table: FdTable, id: usize) {
        for mmap_space in self.mmap_set.iter_mut() {
            if stval >= mmap_space.oaddr.0 && stval < mmap_space.oaddr.0 + mmap_space.length {
                // let va: VirtAddr = stval.into();
                let page_start: VirtAddr = (stval & !(PAGE_SIZE - 1)).into();
                mmap_space.lazy_map_page(page_start, fd_table, id);
                return 
            }
        }
    }

    pub fn push_kernel(&mut self, start: usize, len: usize, prot: usize, flags: usize,
        fd: isize, offset: usize, fd_table: FdTable, id: usize) -> usize {

        let start_addr = start.into();

        let mut mmap_space = MmapSpace::new(start_addr, len, prot, flags, 0, fd, offset);
        mmap_space.map_file(start_addr, len, offset, fd_table, id);
        // debug_os!{"The start addr is {:X}", start_addr.0};

        self.mmap_set.push(mmap_space);

        // update mmap_top
        if self.mmap_top == start_addr{
            self.mmap_top = (start_addr.0 + len).into();
        }

        start_addr.0
    }

    pub fn push(&mut self, start: usize, len: usize, prot: usize, flags: usize,
                fd: isize, offset: usize, fd_table: FdTable, token: usize) -> usize {
        
        let start_addr = start.into();

        let mut mmap_space = MmapSpace::new(start_addr, len, prot, flags, 0, fd, offset);
        // mmap_space.map_file(start_addr, len, offset, fd_table, token);
        // debug_os!{"The start addr is {:X}", start_addr.0};

        self.mmap_set.push(mmap_space);

        // update mmap_top
        if self.mmap_top == start_addr{
            self.mmap_top = (start_addr.0 + len).into();
        }

        start_addr.0
    }

    pub fn remove(&mut self, start: usize, len: usize) -> isize {
        let pair = self.mmap_set.iter().enumerate()
            .find(|(_, p)| { p.oaddr.0 == start });
        if let Some((idx, _)) = pair {
            if self.mmap_top == VirtAddr::from(start + len) {
                self.mmap_top = VirtAddr::from(start);
            }
            self.mmap_set.remove(idx);
            return 0;
        }

        debug_warn!("No matched Mmap Space for {:x}!", start as usize);
        return -1;
    }
}

pub struct MmapSpace {
    // pub addr: VirtAddr,
    pub oaddr: VirtAddr,
    pub valid: usize,
    // pub length: usize,
    pub length: usize,
    pub prot: usize,
    pub flags: usize,
    pub fd: isize,
    pub offset: usize,
}

impl MmapSpace{
    pub fn new(
        oaddr: VirtAddr,
        length: usize,
        prot: usize,
        flags: usize,
        valid: usize,
        fd: isize,
        offset: usize,
    ) -> Self {
        Self {oaddr, length, prot, flags, valid, fd, offset}
    }

    pub fn lazy_map_page(&mut self, page_start: VirtAddr, fd_table: FdTable, pt_id: usize) {
        let offset: usize = self.offset - self.oaddr.0 + page_start.0;
        //debug_os!("map file 0x{:X} = 0x{:X} - 0x{:X} + 0x{:X}", offset, self.offset, self.oaddr.0, page_start.0);
        self.map_file(page_start, PAGE_SIZE, offset, fd_table, pt_id);
    }

    pub fn map_file(&mut self, va_start: VirtAddr, len: usize, offset: usize, fd_table: FdTable, pt_id: usize) -> isize {
        let flags = MmapFlags::from_bits(self.flags).unwrap();
        // print!("map_file: va_strat:0x{:X} flags:{:?}",va_start.0, flags);
        if flags.contains(MmapFlags::MAP_ANONYMOUS)
            && self.fd == -1 
            && offset == 0{
            // print!("[map_anonymous_file]");
            return 1;
        }
        
        if self.fd as usize >= fd_table.len() { return -1; }

        if let Some(file) = &fd_table[self.fd as usize] {
            match &file.fclass {
                FileClass::File(f)=>{
                    f.set_offset(offset);
                    if !f.readable() { return -1; }
                    //debug_os!{"The va_start is 0x{:X}, offset of file is {}", va_start.0, offset};
                    let read_len = f.read(UserBuffer::new(translated_raw(pt_id, va_start.0 as *const u8, len)));
                    //debug_os!{"read {} bytes", read_len};
                },
                _ => { return -1; },
            };
        } else { return -1 };
        return 1;
    }
}
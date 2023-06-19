
use crate::debug_os;
use crate::eokernel;
use crate::shared::*;
use crate::util::MmapArea;   

use alloc::collections::BTreeMap;
use alloc::sync::Arc;
//use alloc::string::ToString;
use alloc::vec::Vec;
use spin::Mutex;
use crate::lazy_static; 
use crate::task::AuxHeader;
use crate::shared::*;


extern "C" {
    fn stext();
    fn etext();
    fn srodata();
    fn erodata();
    fn sdata();
    fn edata();
    fn sbss_with_stack();
    fn ebss();

    fn ekernel();
}


lazy_static! {
    pub static ref KERNEL_SPACE: Arc<Mutex<MemorySet>> = Arc::new(Mutex::new(
        MemorySet::new_kernel()
    ));

    pub static ref KERNEL_MMAP_AREA: Arc<Mutex<MmapArea>> = Arc::new(Mutex::new(
        MmapArea::new(VirtAddr::from(KMMAP_BASE), VirtAddr::from(KMMAP_BASE))
    ));

}

pub struct MemorySet {
    id: usize,   // 这个也找不到
    //page_table: PageTable,
    areas: Vec<MapArea>,  // 常规的Maparea
    chunks: ChunkArea,  // lazy优化，详见文档
    stack_chunks: ChunkArea,  // check_lazy这个方法是唯一用到这两个地方的位置
    mmap_chunks: Vec<ChunkArea>  // 用lazy做的优化
}

impl MemorySet {
    pub fn id(&self) -> usize{
        self.id
    }
    pub fn clone_areas(&self) -> Vec<MapArea> {
        self.areas.clone()
    }
    pub fn new_bare(id: usize) -> Self {
        nkapi_pt_init(id, true);
        Self {
            id,
            //page_table: PageTable::new(id),
            areas: Vec::new(),
            chunks: ChunkArea::new(MapType::Framed,
                                MapPermission::R | MapPermission::W | MapPermission::U),
            mmap_chunks: Vec::new(),
            stack_chunks: ChunkArea::new(MapType::Framed,
                                MapPermission::R | MapPermission::W | MapPermission::U)
        }
    }
    // pub fn set_cow(&mut self, vpn: VirtPageNum) {
    //     self.page_table.set_cow(vpn);
    // }
    // pub fn reset_cow(&mut self, vpn: VirtPageNum) {
    //     self.page_table.reset_cow(vpn);
    // }
    // fn remap_cow(&mut self, vpn: VirtPageNum, ppn: PhysPageNum, former_ppn: PhysPageNum) {
    //     self.page_table.remap_cow(vpn, ppn, former_ppn);
    // }

    /// Assume that no conflicts.
    pub fn insert_framed_area(&mut self, start_va: VirtAddr, end_va: VirtAddr, permission: MapPermission) {
        self.push_mmap(MapArea::new(
            start_va,
            end_va,
            MapType::Framed,
            permission,
        ), None);
    }

    pub fn insert_kernel_mmap_area(&mut self, start_va: VirtAddr, end_va: VirtAddr, permission: MapPermission) {
        // debug_os!{"insert kernel mmap_area: {:X} {:X}", start_va.0, end_va.0}
        self.push_mmap(MapArea::new(
            start_va,
            end_va,
            MapType::Framed,
            permission,
        ), None);
    }
    pub fn insert_mmap_area(&mut self, start_va: VirtAddr, end_va: VirtAddr, permission: MapPermission) {
        let mut new_chunk_area = ChunkArea::new(MapType::Framed, permission,);
        new_chunk_area.set_mmap_range(start_va, end_va);
        self.mmap_chunks.push(new_chunk_area);

        //self.push_mmap(MapArea::new(
        //    start_va,
        //    (end_va.0).into(),  // bin lazy (X
        //    MapType::Framed,
        //    permission,
        //), None);
    }


    pub fn remove_area_with_start_vpn(&mut self, start_vpn: VirtPageNum) {
        if let Some((idx, area)) = self.areas.iter_mut().enumerate()
            .find(|(_, area)| area.vpn_range.get_start() == start_vpn) {
            area.unmap(self.id);
            self.areas.remove(idx);
        }

        let chunks_len = self.mmap_chunks.len();
        for i in 0..chunks_len {
            let chunk = &self.mmap_chunks[i];
            if (chunk.mmap_start.0 >> 12) == start_vpn.0 {
                //debug_os!("remove mmap_chunk 0x{:X}", chunk.mmap_start.0);
                self.mmap_chunks.remove(i);
                break;
            }
        }
    }

    fn push_mmap(&mut self, mut map_area: MapArea, data: Option<&[u8]>) {
        // debug_os!{"2"}
        map_area.map(self.id);
        if let Some(data) = data {
            map_area.copy_data(self.id, data, 0);
        }
        self.areas.push(map_area);
    }

    fn push_mapped(&mut self, mut map_area: MapArea) {
        self.areas.push(map_area);
    }

    fn push_chunk(&mut self, vpn: VirtPageNum) {
        // self.chunks.vpn_table.push(vpn);
        // self.chunks.map_one(&mut self.page_table, vpn);
        self.chunks.push_vpn(vpn, self.id)
    }
    fn push_stack_chunk(&mut self, vpn: VirtPageNum) {
        self.stack_chunks.push_vpn(vpn, self.id)
    }

    fn push_with_offset(&mut self, mut map_area: MapArea, offset: usize, data: Option<&[u8]>){
        // debug_os!{"3"}
        map_area.map(self.id);
        if let Some(data) = data {
            map_area.copy_data(self.id, data, offset);
        }
        self.areas.push(map_area);
    }


    // fn map_kernel_shared(&mut self){
    //     self.page_table.map_kernel_shared();
    // }

    fn push(&mut self, mut map_area: MapArea, data: Option<&[u8]>) {
        // debug_os!{"2"}
        map_area.map(self.id);
        if let Some(data) = data {
            map_area.copy_data(self.id, data, 0);
        }
        self.areas.push(map_area);
    }
    
    pub fn new_kernel() -> Self {
        let mut memory_set = Self::new_bare(0);

        // debug_os!("mapping outer kernel");

        // map trampoline
        // memory_set.map_trampoline();  //映射trampoline
        // map kernel sections

        debug_os!("mapping nk space (readonly)");
        // memory_set.push(MapArea::new(
        //     (NKSPACE_START as usize).into(),
        //     NKSPACE_END.into(),
        //     MapType::Identical,
        //     MapPermission::R | MapPermission::W | MapPermission::X,
        // ), None);


        //debug_os!("mapping .text section");
        memory_set.push(MapArea::new(
            (stext as usize).into(),
            (etext as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::X,
        ), None);
        // debug_os!("mapping .rodata section");
        memory_set.push(MapArea::new(
            (srodata as usize).into(),
            (erodata as usize).into(),
            MapType::Identical,
            MapPermission::R,
        ), None);
        // debug_os!("mapping .data section");
        memory_set.push(MapArea::new(
            (sdata as usize).into(),
            (edata as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ), None);

        // debug_os!("mapping .bss section");
        memory_set.push(MapArea::new(
            (sbss_with_stack as usize).into(),
            (ebss as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W, 
            //temporiliy cannot be readonly
        ), None);

        // debug_os!("mapping heap");
        // memory_set.push(MapArea::new(
        //     (sokheap as usize).into(),
        //     (eokheap as usize).into(),
        //     MapType::Identical,
        //     MapPermission::R | MapPermission::W,
        // ), None);

        // debug_os!("mapping outer kernel space");
        memory_set.push(MapArea::new(
            (eokernel as usize).into(),
            OKSPACE_END.into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ), None);

        // debug_os!("mapping memory-mapped registers");
        for pair in MMIO {  // 这里是config硬编码的管脚地址
            memory_set.push(MapArea::new(
                (*pair).0.into(),
                ((*pair).0 + (*pair).1).into(),
                MapType::Identical,
                MapPermission::R | MapPermission::W,
            ), None);
        }

        // debug_os!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
        // debug_os!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
        // debug_os!(".data [{:#x}, {:#x})", sdata as usize, edata as usize);
        // debug_os!(".bss [{:#x}, {:#x})", sbss_with_stack as usize, ebss as usize);
        //debug_os!("okheap [{:#x}, {:#x})", sokheap as usize, eokheap as usize);
        memory_set

    }

    // /// Mention that trampoline is not collected by areas.
    // /// Different from trampoline: this dosen't need to be mapped in kernel(executed in user)
    // fn map_signal_trampoline(&mut self) {
    //     nkapi_mmap(self.id, 
    //         VirtAddr::from(SIGNAL_TRAMPOLINE).into(), 
    //         PhysAddr::from(ssignaltrampoline as usize).into(),
    //         MapPermission::R | MapPermission::X | MapPermission::U);
    // }

    // fn map_kernel_shared(&mut self){
    //     self.page_table.map_kernel_shared();
    // }

    /// Include sections in elf and trampoline and TrapContext and user stack,
    /// also returns user_sp and entry point.
    /// 倒数第二个是trap context的entry point
    pub fn from_elf(elf_data: &[u8], pid: usize) -> (Self, usize, usize, usize, Vec<AuxHeader>) {
        let mut auxv:Vec<AuxHeader> = Vec::new();
        let mut memory_set = Self::new_bare(pid);
        // map program headers of elf, with U flag
        let elf = xmas_elf::ElfFile::new(elf_data).unwrap();
        let elf_header = elf.header;
        // let comment_sec = elf.find_section_by_name(".comment").unwrap();
        // debug_os!(".comment offset: {}", comment_sec.offset());
        

        let magic = elf_header.pt1.magic;
        assert_eq!(magic, [0x7f, 0x45, 0x4c, 0x46], "invalid elf!");
        let ph_count = elf_header.pt2.ph_count();
        let mut max_end_vpn = VirtPageNum(0);
        let mut head_va = 0; // top va of ELF which points to ELF header
        // push ELF related auxv
        auxv.push(AuxHeader{aux_type: AT_PHENT, value: elf.header.pt2.ph_entry_size() as usize});// ELF64 header 64bytes
        auxv.push(AuxHeader{aux_type: AT_PHNUM, value: ph_count as usize});
        auxv.push(AuxHeader{aux_type: AT_PAGESZ, value: PAGE_SIZE as usize});
        auxv.push(AuxHeader{aux_type: AT_BASE, value: 0 as usize});
        auxv.push(AuxHeader{aux_type: AT_FLAGS, value: 0 as usize});
        auxv.push(AuxHeader{aux_type: AT_ENTRY, value: elf.header.pt2.entry_point() as usize});
        auxv.push(AuxHeader{aux_type: AT_UID, value: 0 as usize});
        auxv.push(AuxHeader{aux_type: AT_EUID, value: 0 as usize});
        auxv.push(AuxHeader{aux_type: AT_GID, value: 0 as usize});
        auxv.push(AuxHeader{aux_type: AT_EGID, value: 0 as usize});
        auxv.push(AuxHeader{aux_type: AT_PLATFORM, value: 0 as usize});
        auxv.push(AuxHeader{aux_type: AT_HWCAP, value: 0 as usize});
        auxv.push(AuxHeader{aux_type: AT_CLKTCK, value: 100 as usize});
        auxv.push(AuxHeader{aux_type: AT_SECURE, value: 0 as usize});
        auxv.push(AuxHeader{aux_type: AT_NOTELF, value: 0x112d as usize});

        // denotes if .comment should be mapped
        let mut comment_flag = true;

        for ph in elf.program_iter(){
            if ph.get_type().unwrap() == xmas_elf::program::Type::Load {
                let start_va: VirtAddr = (ph.virtual_addr() as usize).into();
                let end_va: VirtAddr = ((ph.virtual_addr() + ph.mem_size()) as usize).into();
                let offset = start_va.0 - start_va.floor().0 * PAGE_SIZE;

                if start_va.0 == 0{
                    comment_flag = false;
                } 

                //debug_os!("[elf] ph={:?}", ph.to_string());
                let mut map_perm = MapPermission::U;
                let ph_flags = ph.flags();
                if ph_flags.is_read() { map_perm |= MapPermission::R; }
                if ph_flags.is_write() { map_perm |= MapPermission::W; }
                if ph_flags.is_execute() { map_perm |= MapPermission::X; }

                //debug_os!("[elf] start_va = 0x{:X}; end_va = 0x{:X}, offset = 0x{:X} perm = {:?}", 
                //        ph.virtual_addr() as usize, ph.virtual_addr() + ph.mem_size(), offset, map_perm);
                
                let map_area = MapArea::new(
                    start_va,
                    end_va,
                    MapType::Framed,
                    map_perm,
                );
                //debug_os!("[elf] map elfinput:\n    from 0x{:X} to 0x{:X}", ph.offset(), ph.offset() + ph.file_size());
                max_end_vpn = map_area.vpn_range.get_end();
                
                if offset == 0 {
                    head_va = start_va.into();
                    memory_set.push_mmap( 
                        map_area,
                        Some(&elf.input[ph.offset() as usize..(ph.offset() + ph.file_size()) as usize])
                    );
                } else {
                    memory_set.push_with_offset( 
                        map_area,
                        offset,
                        Some(&elf.input[ph.offset() as usize..(ph.offset() + ph.file_size()) as usize])
                    );
                }
            }
        }

        // Get ph_head addr for auxv
        let ph_head_addr = head_va + elf.header.pt2.ph_offset() as usize;
        auxv.push(AuxHeader{aux_type: AT_PHDR, value: ph_head_addr as usize});


        //map user heap
        let max_end_va: VirtAddr = max_end_vpn.into();
        let mut user_heap_bottom: usize = max_end_va.into();
        //guard page
        user_heap_bottom += PAGE_SIZE;
        let user_heap_top: usize = user_heap_bottom + USER_HEAP_SIZE;
        // maparea1: user_heap
        memory_set.push(MapArea::new(
            user_heap_bottom.into(),
            user_heap_top.into(),
            MapType::Framed,
            MapPermission::R | MapPermission::W | MapPermission::U,
        ), None);

        // maparea2: TrapContext
        memory_set.push_mmap(MapArea::new(
            TRAP_CONTEXT.into(),
            (TRAP_CONTEXT+PAGE_SIZE).into(),
            MapType::Framed,
            MapPermission::R | MapPermission::W,
        ), None);

        // map user stack with U flags
        // maparea3: user_stack
        let max_top_va: VirtAddr = TRAP_CONTEXT.into();
        let mut user_stack_top: usize = TRAP_CONTEXT - PAGE_SIZE;

        let user_stack_bottom: usize = user_stack_top - USER_STACK_SIZE_MIN; 
        memory_set.push_mmap(MapArea::new(
            user_stack_bottom.into(),
            user_stack_top.into(),
            MapType::Framed,
            MapPermission::R | MapPermission::W | MapPermission::U,
        ), None);

        // map signal user stack with U flags
        // maparea4: signal_user_stack
        let mut signal_stack_top: usize = USER_SIGNAL_STACK;
        let signal_stack_bottom: usize = signal_stack_top - SIGNAL_STACK_SIZE;
        memory_set.push_mmap(MapArea::new(
            signal_stack_bottom.into(),
            signal_stack_top.into(),
            MapType::Framed,
            MapPermission::R | MapPermission::W | MapPermission::U,
        ), None);
        
        (memory_set, user_stack_top, user_heap_bottom, elf.header.pt2.entry_point() as usize, auxv)
    }
 
    //这个方法完全没有用到过
    // pub fn from_existed_user(user_space: &MemorySet, pid: usize) -> MemorySet {
    //     let mut memory_set = Self::new_bare(2,pid);
    //     // map trampoline
    //     // memory_set.map_trampoline();
    //     memory_set.map_signal_trampoline();
    //     // copy data sections/trap_context/user_stack
    //     for area in user_space.areas.iter() {
    //         let new_area = MapArea::from_another(area);
    //         memory_set.push(new_area, None);
    //         // copy data from another space
    //         for vpn in area.vpn_range {
    //             let src_ppn = user_space.translate(vpn).unwrap().ppn();
    //             let dst_ppn = memory_set.translate(vpn).unwrap().ppn();
    //             dst_ppn.get_bytes_array().copy_from_slice(src_ppn.get_bytes_array());
    //         }
    //     }
    //     for vpn in user_space.chunks.vpn_table.iter() {
    //         let vpn_copy: VirtPageNum = vpn.0.into();
    //         memory_set.push_chunk(vpn_copy);
    //         let src_ppn = user_space.translate(vpn_copy).unwrap().ppn();
    //         let dst_ppn = memory_set.translate(vpn_copy).unwrap().ppn();
    //         dst_ppn.get_bytes_array().copy_from_slice(src_ppn.get_bytes_array());
    //     }
    //     for vpn in user_space.stack_chunks.vpn_table.iter() {
    //         let vpn_copy: VirtPageNum = vpn.0.into();
    //         memory_set.push_chunk(vpn_copy);
    //         let src_ppn = user_space.translate(vpn_copy).unwrap().ppn();
    //         let dst_ppn = memory_set.translate(vpn_copy).unwrap().ppn();
    //         dst_ppn.get_bytes_array().copy_from_slice(src_ppn.get_bytes_array());
    //     }
    //     for mmap_chunk in user_space.mmap_chunks.iter() {
    //         let mut new_mmap_area = ChunkArea::new(mmap_chunk.map_type, mmap_chunk.map_perm);
    //         new_mmap_area.set_mmap_range(mmap_chunk.mmap_start, mmap_chunk.mmap_end);
    //         for vpn in mmap_chunk.vpn_table.iter() {
    //             let vpn_copy: VirtPageNum = vpn.0.into();
    //             new_mmap_area.push_vpn(vpn_copy, &mut memory_set.page_table);
    //             let src_ppn = user_space.translate(vpn_copy).unwrap().ppn();
    //             let dst_ppn = memory_set.translate(vpn_copy).unwrap().ppn();
    //             dst_ppn.get_bytes_array().copy_from_slice(src_ppn.get_bytes_array());
    //         }
    //         memory_set.mmap_chunks.push(new_mmap_area);
    //     }
    //     memory_set.map_kernel_shared();
    //     memory_set
    // }

    pub fn from_copy_on_write(user_space: &mut MemorySet, mut split_addr: usize, pid: usize) -> MemorySet {
        
        //split_addr: addr bigger than split_addr would not copy_on_write.

        split_addr = 0;
        // Yan_ice: temporarily change split_addr to 0, means EVERYTHING is not copy on write!

        let old_pid: usize = user_space.id();
        let new_pid: usize = pid;

        // create a new memory_set
        let mut memory_set = Self::new_bare(pid);

        // This part is not for Copy on Write.
        // Including:   Trampoline
        //              Trap_Context
        //              User_Stack

        for area in user_space.areas.iter() {
            let head_vpn = area.vpn_range.get_start();
            let user_split_addr: VirtAddr = split_addr.into();

            if head_vpn < user_split_addr.floor() {

                //smaller than split_addr: copy on write.

                // let mut new_area = MapArea::from_another(area);
                // // map the former physical address
                // for vpn in area.vpn_range {
                //     //change the map permission of both pagetable
                //     // get the former flags and ppn
                //     let pte = origin_page_table.translate(vpn).unwrap();
                //     let pte_flags = pte.flags() & !PTEFlags::W;
                //     let src_ppn = pte.ppn();
                //     //frame_add_ref(src_ppn);
                //     // change the flags of the src_pte
                //     origin_page_table.set_flags(vpn, pte_flags);
                //     origin_page_table.set_cow(vpn);
                //     // map the cow page table to src_ppn
                //     target_page_table.map(vpn, src_ppn, pte_flags);
                //     target_page_table.set_cow(vpn);
                //     new_area.insert_map(vpn, src_ppn);
                // }
                // memory_set.push_mapped(new_area);

                continue;
            }else{

                //bigger than split_addr: NOT copy on write, directly copy.

                let new_area = MapArea::from_another(area);
                memory_set.push_mmap(new_area, None);
                for vpn in area.vpn_range {
                    let s_ppn = nkapi_translate(user_space.id(),vpn,false);
                    let d_ppn = nkapi_translate(memory_set.id(),vpn,false);
                    if s_ppn.is_some() & d_ppn.is_some() {
                        let src_ppn = s_ppn.unwrap();
                        let dst_ppn = d_ppn.unwrap();
                        //debug_os!{"forking {:?} -> {:?} (old: {:?})", vpn, dst_ppn, src_ppn};
                        unsafe{
                            let data: &mut [u8] = core::slice::from_raw_parts_mut(VirtAddr::from(vpn).0 as *mut u8, 4096);
                            nkapi_copyTo(memory_set.id(),vpn, data, 0);
                        }
                        
                    }
                    
                }

            }
            
        }

        for vpn in user_space.chunks.vpn_table.iter() {
            let vpn_copy: VirtPageNum = vpn.0.into();
            memory_set.push_chunk(vpn_copy);
            let s_ppn = nkapi_translate(user_space.id(),vpn_copy,false);
            let d_ppn = nkapi_translate(memory_set.id(),vpn_copy,false);
            if s_ppn.is_some() & d_ppn.is_some() {
                let src_ppn = s_ppn.unwrap();
                let dst_ppn = d_ppn.unwrap();
                // debug_os!{"mapping {:?} --- {:?}, src: {:?}", vpn, dst_ppn, src_ppn};
                dst_ppn.get_bytes_array().copy_from_slice(src_ppn.get_bytes_array());
            }
        }
        for vpn in user_space.stack_chunks.vpn_table.iter() {
            let vpn_copy: VirtPageNum = vpn.0.into();
            memory_set.push_chunk(vpn_copy);
            let s_ppn = nkapi_translate(user_space.id(),vpn_copy,false);
            let d_ppn = nkapi_translate(memory_set.id(),vpn_copy,false);
            if s_ppn.is_some() & d_ppn.is_some() {
                let src_ppn = s_ppn.unwrap();
                let dst_ppn = d_ppn.unwrap();
                // debug_os!{"mapping {:?} --- {:?}, src: {:?}", vpn, dst_ppn, src_ppn};
                dst_ppn.get_bytes_array().copy_from_slice(src_ppn.get_bytes_array());
            }
        }
        for mmap_chunk in user_space.mmap_chunks.iter() {
            let mut new_mmap_area = ChunkArea::new(mmap_chunk.map_type, mmap_chunk.map_perm);
            new_mmap_area.set_mmap_range(mmap_chunk.mmap_start, mmap_chunk.mmap_end);
            for vpn in mmap_chunk.vpn_table.iter() {
                let vpn_copy: VirtPageNum = vpn.0.into();
                // memory_set.chunks.vpn_table.push(vpn_copy);
                // memory_set.chunks.map_one(&mut memory_set.page_table, vpn_copy);
                new_mmap_area.push_vpn(vpn_copy, memory_set.id);
                let s_ppn = nkapi_translate(user_space.id(),vpn_copy,false);
                let d_ppn = nkapi_translate(memory_set.id(),vpn_copy,false);
                if s_ppn.is_some() & d_ppn.is_some() {
                    let src_ppn = s_ppn.unwrap();
                    let dst_ppn = d_ppn.unwrap();
                    // debug_os!{"mapping {:?} --- {:?}, src: {:?}", vpn, dst_ppn, src_ppn};
                    dst_ppn.get_bytes_array().copy_from_slice(src_ppn.get_bytes_array());
                }
            }
            memory_set.mmap_chunks.push(new_mmap_area);
        }

        memory_set
    }

    // #[no_mangle]
    // pub fn cow_alloc(&mut self, vpn: VirtPageNum, former_ppn: PhysPageNum) -> usize {
    //     if enquire_refcount(former_ppn) == 1 {
    //         self.page_table.reset_cow(vpn);
    //         // change the flags of the src_pte
    //         self.page_table.set_flags(
    //             vpn, 
    //             self.page_table.translate(vpn).unwrap().flags() | PTEFlags::W
    //         );
    //         return 0
    //     }
    //     let frame = frame_alloc().unwrap();
    //     let ppn = frame.ppn;
    //     self.remap_cow(vpn, ppn, former_ppn);
    //     for area in self.areas.iter_mut() {
    //         let head_vpn = area.vpn_range.get_start();
    //         let tail_vpn = area.vpn_range.get_end();
    //         if vpn <= tail_vpn && vpn >= head_vpn {
    //             area.data_frames.insert(vpn, frame);
    //             break;
    //         }
    //     }
    //     0
    // }

    pub fn lazy_alloc_heap (&mut self, vpn: VirtPageNum) -> usize {
        self.push_chunk(vpn);
        0
    }

    pub fn lazy_alloc_stack (&mut self, vpn: VirtPageNum) -> usize {
        self.push_stack_chunk(vpn);
        0
    }

    pub fn lazy_mmap (&mut self, stval: VirtAddr) -> isize {
        for mmap_chunk in self.mmap_chunks.iter() {
            if stval >= mmap_chunk.mmap_start && stval < mmap_chunk.mmap_end {
                // read only can also be mapped!!??
                //if (mmap_chunk.map_perm & MapPermission::W).bits == 0 {
                //    return -1;
                //}
                self.push_chunk(stval.floor());
                return 0
            }
        }
        0
    }

    pub fn set_pte_flags(&mut self, vpn: VirtPageNum, flags: usize){
        nkapi_set_permission(self.id, vpn, flags);
    }

    ///修改satp，切换到该页表
    pub fn activate(&self) {
        nkapi_activate(self.id);
    }

    pub fn translate(&self, vpn: VirtPageNum, write: bool) -> Option<PhysPageNum> {
        nkapi_translate(self.id, vpn, write)
    }

    pub fn recycle_data_pages(&mut self) {
        self.areas.clear();
    }

}

#[derive(Clone)]
pub struct MapArea {
    vpn_range: VPNRange,
    data_frames: BTreeMap<VirtPageNum, PhysPageNum>,
    map_type: MapType,
    map_perm: MapPermission,
}

pub struct ChunkArea {
    vpn_table: Vec<VirtPageNum>,
    data_frames: BTreeMap<VirtPageNum, PhysPageNum>,
    map_type: MapType,
    map_perm: MapPermission,
    mmap_start: VirtAddr,
    mmap_end: VirtAddr,
}

impl ChunkArea {
    pub fn new(
        map_type: MapType,
        map_perm: MapPermission
    ) -> Self {
        Self {
            vpn_table: Vec::new(),
            data_frames: BTreeMap::new(),
            map_type,
            map_perm,
            mmap_start: 0.into(),
            mmap_end: 0.into(),
        }
    }

    pub fn set_mmap_range(&mut self, start: VirtAddr, end: VirtAddr) {
        self.mmap_start = start;
        self.mmap_end = end;
    }

    pub fn push_vpn(&mut self, vpn: VirtPageNum, pt_handle: usize) {
        self.vpn_table.push(vpn);
        self.map_one(pt_handle, vpn);
    }

    pub fn from_another(another: &ChunkArea) -> Self {
        Self {
            vpn_table: another.vpn_table.clone(),
            data_frames: BTreeMap::new(),
            map_type: another.map_type,
            map_perm: another.map_perm,
            mmap_start: another.mmap_start,
            mmap_end: another.mmap_end,
        }
    }

    // Alloc and map one page
    pub fn map_one(&mut self, pt_handle: usize, vpn: VirtPageNum) {
        // if let Some(p) = nkapi_translate(pt_handle, vpn, false){
        //     nkapi_dealloc(pt_handle, vpn)
        // }
        let ppn: PhysPageNum = nkapi_alloc(pt_handle, vpn, self.map_type, self.map_perm);
        self.data_frames.insert(vpn, ppn);
    }

    pub fn unmap_one(&mut self, pt_handle: usize, vpn: VirtPageNum) {
        self.data_frames.remove(&vpn);
        nkapi_dealloc(pt_handle, vpn);
    }
    
    // Alloc and map all pages
    // pub fn map(&mut self, page_table: &mut PageTable) {
    //     for vpn in self.vpn_table {
    //         self.map_one(page_table, vpn);
    //     }
    // }
    // pub fn unmap(&mut self, page_table: &mut PageTable) {
    //     for vpn in self.vpn_table {
    //         self.unmap_one(page_table, vpn);
    //     }
    // }

}

impl MapArea {
    pub fn new(
        start_va: VirtAddr,
        end_va: VirtAddr,
        map_type: MapType,
        map_perm: MapPermission
    ) -> Self {
        let start_vpn: VirtPageNum = start_va.floor();
        let end_vpn: VirtPageNum = end_va.ceil();
        // [WARNING]:因为没有map，所以不能使用
        //gdb_println!(MAP_ENABLE,"[MapArea new]: start_vpn:0x{:X} end_vpn:0x{:X}", start_vpn.0, end_vpn.0);
        Self {
            vpn_range: VPNRange::new(start_vpn, end_vpn),
            data_frames: BTreeMap::new(),
            map_type,
            map_perm,
        }
    }
    pub fn insert_map(&mut self, vpn: VirtPageNum, ppn: PhysPageNum) {
        self.data_frames.insert(vpn, ppn);
    }
    pub fn from_another(another: &MapArea) -> Self {
        Self {
            vpn_range: VPNRange::new(another.vpn_range.get_start(), another.vpn_range.get_end()),
            data_frames: BTreeMap::new(),
            map_type: another.map_type,
            map_perm: another.map_perm,
        }
    }

    // Alloc and map one page
    pub fn map_one(&mut self, pt_handle: usize, vpn: VirtPageNum) {
        // debug_os!{"map one!!!"}
        // if let Some(p) = nkapi_translate(pt_handle, vpn, false){
        //     debug_os!("{:?} already mapped in [{}].", vpn, pt_handle);
        //     nkapi_dealloc(pt_handle, vpn);
        // }
        let ppn: PhysPageNum = nkapi_alloc(pt_handle, vpn, self.map_type, self.map_perm);
        self.data_frames.insert(vpn, ppn); 
    }

    pub fn unmap_one(&mut self, pt_handle: usize, vpn: VirtPageNum) {
        nkapi_dealloc(pt_handle, vpn);
        self.data_frames.remove(&vpn);
    }
    
    // Alloc and map all pages
    pub fn map(&mut self, pt_handle: usize) {
        nkapi_alloc_mul(pt_handle, 
            self.vpn_range.get_start(), 
            self.vpn_range.get_end(), 
            self.map_type, self.map_perm);
        // for vpn in self.vpn_range {
        //     self.map_one(pt_handle, vpn);
        // }
    }
    pub fn unmap(&mut self, pt_handle: usize) {
        for vpn in self.vpn_range {
            self.unmap_one(pt_handle, vpn);
        }
    }
    /// data: start-aligned but maybe with shorter length
    /// assume that all frames were cleared before
    pub fn copy_data(&mut self, pt_handle: usize, data: &[u8], offset:usize) {
        assert_eq!(self.map_type, MapType::Framed);
        let mut start: usize = 0;
        let mut page_offset: usize = offset;
        let mut current_vpn = self.vpn_range.get_start();
        
        let len = data.len();
        let mut data_buf: &mut [u8;PAGE_SIZE] = &mut [0; PAGE_SIZE];
        loop { 
            let src: &[u8] = &data[start..len.min(start + PAGE_SIZE - page_offset)];
            
            data_buf[0..src.len()].copy_from_slice(src);

            start += PAGE_SIZE - page_offset;
            
            nkapi_copyTo(pt_handle, current_vpn, data_buf, offset);

            page_offset = 0;
            if start >= len {
                break;
            }
            current_vpn.step();
        }
        
    }
}

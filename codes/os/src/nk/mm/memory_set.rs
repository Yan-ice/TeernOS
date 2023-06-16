
use super::page_table::PageTableRecord;
use super::{PageTable, PageTableEntry};
use crate::shared::*;
use crate::config::*;

use super::{frame_add_ref, enquire_refcount, print_free_pages};
use alloc::collections::BTreeMap;
//use alloc::string::ToString;
use alloc::vec::Vec;
use buddy_system_allocator::FrameAllocator;
use alloc::sync::Arc;
use lazy_static::*;
use spin::Mutex;


use super::frame_allocator::{frame_alloc};
use crate::monitor::*;
use crate::task::AuxHeader;
use crate::debug_info;

extern "C" {
    fn stext();
    fn etext();
    fn srodata();
    fn erodata();
    fn sdata();
    fn edata();
    fn sbss_with_stack();
    fn ebss();
    fn sproxy();
    fn eproxy();
    fn snkheap();
    fn enkheap();
    fn ekernel();
    fn sokheap();
    fn strampoline();
    fn ssignaltrampoline();
    fn snktrampoline();
}


pub struct KernelToken {
    token:usize
}
impl KernelToken {
    pub fn token(&self)->usize{
        self.token
    }
}

lazy_static! {
    pub static ref KERNEL_SPACE: Arc<Mutex<MemorySet>> = Arc::new(Mutex::new(
        MemorySet::new_kernel()
    ));

    //为outer kernel准备专门的页表。
    // pub static ref OUTER_KERNEL_SPACE: Arc<Mutex<MemorySet>> = Arc::new(Mutex::new(
    //     MemorySet::new_outer_kernel()
    // ));

    pub static ref KERNEL_TOKEN: Arc<KernelToken> = Arc::new(
        KernelToken{
            token: KERNEL_SPACE.lock().token()
        }
    );
}

// lazy_static! {
//     pub static ref KERNEL_MMAP_AREA: Arc<Mutex<MmapArea>> = Arc::new(Mutex::new(
//         MmapArea::new(VirtAddr::from(KMMAP_BASE), VirtAddr::from(KMMAP_BASE))
//     ));
// }


pub fn kernel_token() -> usize {
    KERNEL_SPACE.lock().token()
}

pub struct MemorySet {
    id: usize,   // 这个也找不到
    page_table: PageTableRecord,
    areas: Vec<MapArea>,  // 常规的Maparea
    chunks: ChunkArea,  // lazy优化，详见文档
    stack_chunks: ChunkArea,  // check_lazy这个方法是唯一用到这两个地方的位置
    mmap_chunks: Vec<ChunkArea>  // 用lazy做的优化
}

impl MemorySet {
    pub fn clone_areas(&self) -> Vec<MapArea> {
        self.areas.clone()
    }
    fn new_bare(id: usize) -> Self {
        Self {
            id,
            page_table: PageTableRecord::new(id),
            areas: Vec::new(),
            chunks: ChunkArea::new(MapType::Framed,
                                MapPermission::R | MapPermission::W | MapPermission::U),
            mmap_chunks: Vec::new(),
            stack_chunks: ChunkArea::new(MapType::Framed,
                                MapPermission::R | MapPermission::W | MapPermission::U)
        }
    }
    pub fn set_cow(&mut self, vpn: VirtPageNum) {
        self.page_table.set_cow(vpn);
    }
    pub fn reset_cow(&mut self, vpn: VirtPageNum) {
        self.page_table.reset_cow(vpn);
    }
    pub fn set_flags(&mut self, vpn: VirtPageNum, flags: PTEFlags) {
        self.page_table.set_flags(vpn, flags);
    }
    pub fn token(&self) -> usize {
        self.page_table.token()
    }
    /// Assume that no conflicts.
    pub fn insert_framed_area(&mut self, start_va: VirtAddr, end_va: VirtAddr, permission: MapPermission) {
        self.push(MapArea::new(
            start_va,
            end_va,
            MapType::Framed,
            permission,
        ), None);
    }
    pub fn insert_kernel_mmap_area(&mut self, start_va: VirtAddr, end_va: VirtAddr, permission: MapPermission) {
        // debug_info!{"insert kernel mmap_area: {:X} {:X}", start_va.0, end_va.0}
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
    fn push_mmap(&mut self, mut map_area: MapArea, data: Option<&[u8]>) {
        // debug_info!{"1"}
        map_area.map(&mut self.page_table);
        self.areas.push(map_area);
    }
    pub fn remove_area_with_start_vpn(&mut self, start_vpn: VirtPageNum) {
        if let Some((idx, area)) = self.areas.iter_mut().enumerate()
            .find(|(_, area)| area.vpn_range.get_start() == start_vpn) {
            area.unmap(&mut self.page_table);
            self.areas.remove(idx);
        }

        let chunks_len = self.mmap_chunks.len();
        for i in 0..chunks_len {
            let chunk = &self.mmap_chunks[i];
            if (chunk.mmap_start.0 >> 12) == start_vpn.0 {
                //debug_info!("remove mmap_chunk 0x{:X}", chunk.mmap_start.0);
                self.mmap_chunks.remove(i);
                break;
            }
        }
    }

    fn push(&mut self, mut map_area: MapArea, data: Option<&[u8]>) {
        // debug_info!{"2"}
        map_area.map(&mut self.page_table);
        if let Some(data) = data {
            map_area.copy_data(&mut self.page_table, data, 0);
        }
        self.areas.push(map_area);
    }


    /// Mention that trampoline is not collected by areas.
    fn map_trampoline(&mut self) {
        self.page_table.map(
            VirtAddr::from(TRAMPOLINE).into(),
            PhysAddr::from(strampoline as usize).into(),
            PTEFlags::R | PTEFlags::X,
        );
        //Yan_ice:额外为proxy context加一个跳板
        unsafe{
            self.page_table.map(
            
            VirtAddr::from(NK_TRAMPOLINE).into(),
            PhysAddr::from(sproxy as *const ProxyContext as usize).into(),
            PTEFlags::R | PTEFlags::W,
        );
        }
        
    }


    /// Without kernel stacks.
    pub fn new_kernel() -> Self {
        let mut memory_set = Self::new_bare(0);

        debug_info!("mapping nested kernel");

        // map trampoline
        memory_set.map_trampoline();  //映射trampoline
        // map kernel sections
        debug_info!("mapping .text section");
        memory_set.push(MapArea::new(
            (stext as usize).into(),
            (etext as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::X,
        ), None);
        debug_info!("mapping .rodata section");
        memory_set.push(MapArea::new(
            (srodata as usize).into(),
            (erodata as usize).into(),
            MapType::Identical,
            MapPermission::R,
        ), None);
        debug_info!("mapping .data section");
        memory_set.push(MapArea::new(
            (sdata as usize).into(),
            (edata as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ), None);
        debug_info!("mapping .bss section");
        memory_set.push(MapArea::new(
            (sbss_with_stack as usize).into(),
            (ebss as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ), None);

        debug_info!("mapping proxy section");
        memory_set.push(MapArea::new(
            (sproxy as usize).into(),
            (eproxy as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W, 
            //temporiliy cannot be readonly
        ), None);

        debug_info!("mapping nk heap memory");
        memory_set.push(MapArea::new(
            (snkheap as usize).into(),
            (enkheap as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ), None);

        debug_info!("mapping nk frame memory");
        memory_set.push(MapArea::new(
            (ekernel as usize).into(),
            NKSPACE_END.into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ), None);

        debug_info!("mapping outer kernel space");
        memory_set.push(MapArea::new(
            (NKSPACE_END).into(),
            OKSPACE_END.into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ), None);

        debug_info!("mapping memory-mapped registers");
        for pair in MMIO {  // 这里是config硬编码的管脚地址
            memory_set.push(MapArea::new(
                (*pair).0.into(),
                ((*pair).0 + (*pair).1).into(),
                MapType::Identical,
                MapPermission::R | MapPermission::W,
            ), None);
        }
        memory_set
    }

    ///修改satp，切换到该页表
    pub fn activate(&self) {
        println!("Special satp change.");
        let satp = self.page_table.token();
        crate::sbi::sbi_satp(satp);
    }

    pub fn translate(&self, vpn: VirtPageNum) -> Option<PageTableEntry> {
        self.page_table.translate(vpn)
    }

    // WARNING: This function causes inconsistency between pte flags and 
    //          map_area flags.
    // return -1 if not found, 0 if found
    pub fn set_pte_flags(&mut self, vpn: VirtPageNum, flags: usize) -> isize{
        self.page_table.set_pte_flags(vpn, flags)
    }
    
    pub fn recycle_data_pages(&mut self) {
        self.areas.clear();
    }

    pub fn print_pagetable(&mut self, from:usize, to:usize){
        self.page_table.print_pagetable(from,to);
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

    pub fn push_vpn(&mut self, vpn: VirtPageNum, page_table: &mut PageTableRecord) {
        self.vpn_table.push(vpn);
        self.map_one(page_table, vpn);
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
    pub fn map_one(&mut self, page_table: &mut PageTableRecord, vpn: VirtPageNum) {
        let mut ppn: PhysPageNum = PhysPageNum(vpn.0);
        match self.map_type {
            MapType::Identical => {
                ppn = PhysPageNum(vpn.0);
            }
            MapType::Specified(pa) => {
                ppn = pa;
            }
            MapType::Framed => {
                if let Some(alppn) = frame_alloc(){
                    ppn = alppn;
                    self.data_frames.insert(vpn, ppn);
                }
                else{
                    panic!("No more memory!");
                }
            }
            MapType::Raw =>{
                panic!("not reachable");
            }

        }
        let pte_flags = PTEFlags::from_bits(self.map_perm.get_bits()).unwrap();
        // [WARNING]:因为没有map，所以不能使用
        page_table.map(vpn, ppn, pte_flags);
    }

    pub fn unmap_one(&mut self, page_table: &mut PageTableRecord, vpn: VirtPageNum) {
        match self.map_type {
            MapType::Framed => {
                self.data_frames.remove(&vpn);
            }
            _ => {}
        }
        page_table.unmap(vpn);
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
    pub fn insert_tracker(&mut self, vpn: VirtPageNum, ppn: PhysPageNum) {
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
    pub fn map_one(&mut self, page_table: &mut PageTableRecord, vpn: VirtPageNum) {
        // debug_info!{"map one!!!"}
        let mut ppn: PhysPageNum;
        match self.map_type {
            MapType::Identical => {
                ppn = PhysPageNum(vpn.0);
            }
            MapType::Specified(pa) => {
                ppn = pa;
            }
            MapType::Framed => {
                if let Some(alppn) = frame_alloc(){
                    ppn = alppn;
                    self.data_frames.insert(vpn, ppn);
                }
                else{
                    panic!("No more memory!");
                }
            }
            MapType::Raw =>{
                //TODO: modify to lazy framed.
                panic!("not reachable");
            }
        }
        let pte_flags = PTEFlags::from_bits(self.map_perm.get_bits()).unwrap();
        // [WARNING]:因为没有map，所以不能使用
        //gdb_println!(MAP_ENABLE,"[map_one]: pte_flags:{:?} vpn:0x{:X}",pte_flags,vpn.0);
        page_table.map(vpn, ppn, pte_flags);
    }
    pub fn unmap_one(&mut self, page_table: &mut PageTableRecord, vpn: VirtPageNum) {
        match self.map_type {
            MapType::Framed => {
                self.data_frames.remove(&vpn);
            }
            _ => {}
        }
        page_table.unmap(vpn);
    }
    
    // Alloc and map all pages
    pub fn map(&mut self, page_table: &mut PageTableRecord) {
        for vpn in self.vpn_range {
            self.map_one(page_table, vpn);
        }
    }
    pub fn unmap(&mut self, page_table: &mut PageTableRecord) {
        for vpn in self.vpn_range {
            self.unmap_one(page_table, vpn);
        }
    }
    /// data: start-aligned but maybe with shorter length
    /// assume that all frames were cleared before
    pub fn copy_data(&mut self, page_table: &mut PageTableRecord, data: &[u8], offset:usize) {
        assert_eq!(self.map_type, MapType::Framed);
        let mut start: usize = 0;
        let mut page_offset: usize = offset;
        let mut current_vpn = self.vpn_range.get_start();
        let len = data.len();
        loop { 
            let src = &data[start..len.min(start + PAGE_SIZE - page_offset)];
            let dst = &mut page_table
                .translate(current_vpn)
                .unwrap()
                .ppn()
                .get_bytes_array()[page_offset..(page_offset+src.len())];
            
            dst.copy_from_slice(src);

            start += PAGE_SIZE - page_offset;
            
            page_offset = 0;
            if start >= len {
                break;
            }
            current_vpn.step();
        }
    }
}


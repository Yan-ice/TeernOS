
use super::page_table::PageTableRecord;
use shared::*;

use alloc::collections::BTreeMap;
//use alloc::string::ToString;
use alloc::vec::Vec;
use alloc::sync::Arc;
use lazy_static::*;
use spin::Mutex;

use super::frame_allocator::{frame_alloc};
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
    fn ekernel();
    fn strampoline();
    fn snktrampoline();
}

lazy_static! {
    pub static ref KERNEL_SPACE: Arc<Mutex<MemorySet>> = Arc::new(Mutex::new(
        MemorySet::new_kernel()
    ));
}


pub struct MemorySet {
    //id: usize,   // 这个也找不到
    page_table: PageTableRecord,
    areas: Vec<MapArea>,  // 常规的Maparea
    // chunks: ChunkArea,  // lazy优化，详见文档
    // stack_chunks: ChunkArea,  // check_lazy这个方法是唯一用到这两个地方的位置
    // mmap_chunks: Vec<ChunkArea>  // 用lazy做的优化
}

impl MemorySet {
    // pub fn clone_areas(&self) -> Vec<MapArea> {
    //     self.areas.clone()
    // }
    fn new_bare(id: usize) -> Self {
        Self {
            //id,
            page_table: PageTableRecord::new(id),
            areas: Vec::new(),
        //     chunks: ChunkArea::new(MapType::Framed,
        //                         MapPermission::R | MapPermission::W | MapPermission::U),
        //     mmap_chunks: Vec::new(),
        //     stack_chunks: ChunkArea::new(MapType::Framed,
        //                         MapPermission::R | MapPermission::W | MapPermission::U)
         }
    }

    pub fn token(&self) -> usize {
        self.page_table.token()
    }

    fn push(&mut self, mut map_area: MapArea) {
        // debug_info!{"2"}
        map_area.map(&mut self.page_table);
        self.areas.push(map_area);
    }


    /// Mention that trampoline is not collected by areas.
    fn map_trampoline(&mut self) {
        self.page_table.map(
            VirtAddr::from(TRAMPOLINE).into(),
            PhysAddr::from(strampoline as usize).into(),
            PTEFlags::R | PTEFlags::X | PTEFlags::W,
        );
        //Yan_ice:额外为proxy context加一个跳板
        self.page_table.map(
            
            VirtAddr::from(NK_TRAMPOLINE).into(),
            PhysAddr::from(snktrampoline as usize).into(),
            PTEFlags::R | PTEFlags::X,
        );
        self.page_table.map(
            VirtAddr::from(PROXY_CONTEXT).into(),
            PhysAddr::from(sproxy as usize).into(),
            PTEFlags::R | PTEFlags::W,
        );
        
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
        ));
        debug_info!("mapping .rodata section");
        memory_set.push(MapArea::new(
            (srodata as usize).into(),
            (erodata as usize).into(),
            MapType::Identical,
            MapPermission::R,
        ));
        debug_info!("mapping .data section");
        memory_set.push(MapArea::new(
            (sdata as usize).into(),
            (edata as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ));
        debug_info!("mapping .bss section");
        memory_set.push(MapArea::new(
            (sbss_with_stack as usize).into(),
            (ebss as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ));

        debug_info!("mapping proxy section");
        memory_set.push(MapArea::new(
            (sproxy as usize).into(),
            (eproxy as usize).into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W, 
            //temporiliy cannot be readonly
        ));

        debug_info!("mapping nk frame memory");
        memory_set.push(MapArea::new(
            (ekernel as usize).into(),
            NKSPACE_END.into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ));

        debug_info!("mapping outer kernel space");
        memory_set.push(MapArea::new(
            (NKSPACE_END).into(),
            OKSPACE_END.into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ));

        debug_info!("mapping kernel stack space");
        memory_set.push(MapArea::new(
            (config::TRAP_CONTEXT/2).into(),
            config::TRAP_CONTEXT.into(),
            MapType::Identical,
            MapPermission::R | MapPermission::W,
        ));

        debug_info!("mapping memory-mapped registers");
        for pair in MMIO {  // 这里是config硬编码的管脚地址
            memory_set.push(MapArea::new(
                (*pair).0.into(),
                ((*pair).0 + (*pair).1).into(),
                MapType::Identical,
                MapPermission::R | MapPermission::W,
            ));
        }
        memory_set
    }

    ///修改satp，切换到该页表
    pub fn activate(&self) {
        println!("Special satp change.");
        let satp = self.page_table.token();
        crate::sbi::sbi_satp(satp);
    }

    // pub fn translate(&self, vpn: VirtPageNum) -> Option<PageTableEntry> {
    //     self.page_table.translate(vpn)
    // }

    // pub fn print_pagetable(&mut self, from:usize, to:usize){
    //     self.page_table.print_pagetable(from,to);
    // }
}

#[derive(Clone)]
pub struct MapArea {
    vpn_range: VPNRange,
    data_frames: BTreeMap<VirtPageNum, PhysPageNum>,
    map_type: MapType,
    map_perm: MapPermission,
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

    // Alloc and map one page
    pub fn map_one(&mut self, page_table: &mut PageTableRecord, vpn: VirtPageNum) {
        // debug_info!{"map one!!!"}
        let ppn: PhysPageNum;
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

    // Alloc and map all pages
    pub fn map(&mut self, page_table: &mut PageTableRecord) {
        for vpn in self.vpn_range {
            self.map_one(page_table, vpn);
        }
    }
}


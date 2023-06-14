use super::address::*;

bitflags! {
    pub struct MapPermission: u8 {
        const R = 1 << 1;  // read
        const W = 1 << 2;  // write
        const X = 1 << 3;  // execute
        const U = 1 << 4;
    }
    
}


bitflags! {
    pub struct PTEFlags: u8 {
        const V = 1 << 0;
        const R = 1 << 1;
        const W = 1 << 2;
        const X = 1 << 3;
        const U = 1 << 4;
        const G = 1 << 5;
        const A = 1 << 6;
        const D = 1 << 7;
    }
}

impl MapPermission{
    pub fn get_bits(&self) -> u8{
        self.bits
    }
}
impl PTEFlags{
    pub fn get_bits(&self) -> u8{
        self.bits
    }
}

#[derive(Copy, Clone, PartialEq, Debug)]
pub enum MapType {
    Identical,
    Framed,
    FramedInNK,
    Specified(PhysPageNum)
}

impl From<MapType> for usize {
    fn from(v: MapType) -> Self {
        match v {
            MapType::Identical =>{
                return usize::MAX-1;
            }
            MapType::Framed =>{
                return usize::MAX-2;
            }
            MapType::FramedInNK =>{
                return usize::MAX-3;
            }
            MapType::Specified(ppn) =>{
                return ppn.0;
            }
        }
    }
}
impl From<usize> for MapType{
    fn from(v: usize) -> Self {
        unsafe{
             if v == usize::MAX-1 {
            MapType::Identical
        }else if v == usize::MAX-2 {
            MapType::Framed
        }else if v == usize::MAX-3 {
            MapType::FramedInNK
        }else{
            MapType::Specified(PhysPageNum::from(v))
        }
        }
    }
}

impl From<MapPermission> for usize{
    fn from(v: MapPermission) -> Self{
        v.bits().into()
    }
}

impl From<usize> for MapPermission{
    fn from(v: usize) -> Self{
        MapPermission { bits: v as u8}
    }
}

impl MapPermission{
    pub fn flags(self) -> PTEFlags{
        PTEFlags::from_bits(self.bits).unwrap()
    }
}

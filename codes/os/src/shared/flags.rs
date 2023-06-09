
bitflags! {
    pub struct MapPermission: u8 {
        const R = 1 << 1;  // read
        const W = 1 << 2;  // write
        const X = 1 << 3;  // execute
        const U = 1 << 4;
    }
    
}
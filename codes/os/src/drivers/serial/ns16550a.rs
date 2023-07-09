/*  In this file, we ported codes from RustSBI.
    Thus we can handle serial in S mode.
*/

pub struct Ns16550a {
    base: usize,
    shift: usize,
}

impl Ns16550a {
    pub fn new(base: usize, shift: usize/* , clk: u64, baud: u64*/) -> Self {
        // already init in RustSBI
        Self { base, shift }
    }
}



mod offsets {
    pub const RBR: usize = 0x0;
    pub const THR: usize = 0x0;

    pub const IER: usize = 0x1;
    pub const FCR: usize = 0x2;
    pub const LCR: usize = 0x3;
    pub const MCR: usize = 0x4;
    pub const LSR: usize = 0x5;

    pub const DLL: usize = 0x0;
    pub const DLH: usize = 0x1;
}

mod masks {
    pub const THRE: u8 = 1 << 5;
    pub const DR: u8 = 1;
}

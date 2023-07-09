#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(unused)]

use spin::Mutex;
use lazy_static::*;
use crate::{println, timer::get_time};
use crate::debug_os;
use super::BlockDevice;
use core::convert::TryInto;

pub struct SDCard<SPI> {
    spi: SPI,
    spi_cs: u32,
    cs_gpionum: u8,
    //dmac: &'a DMAC,
    //channel: dma_channel,
}

/*
 * Start Data tokens:
 *         Tokens (necessary because at nop/idle (and CS active) only 0xff is
 *         on the data/command line)
 */
/** Data token start byte, Start Single Block Read */
pub const SD_START_DATA_SINGLE_BLOCK_READ: u8 = 0xFE;
/** Data token start byte, Start Multiple Block Read */
pub const SD_START_DATA_MULTIPLE_BLOCK_READ: u8 = 0xFE;
/** Data token start byte, Start Single Block Write */
pub const SD_START_DATA_SINGLE_BLOCK_WRITE: u8 = 0xFE;
/** Data token start byte, Start Multiple Block Write */
pub const SD_START_DATA_MULTIPLE_BLOCK_WRITE: u8 = 0xFC;

pub const SEC_LEN: usize = 512;

/** SD commands */
#[repr(u8)]
#[derive(Debug, PartialEq, Eq, Copy, Clone)]
#[allow(unused)]
pub enum CMD {
    /** Software reset */
    CMD0 = 0,
    /** Check voltage range (SDC V2) */
    CMD8 = 8,
    /** Read CSD register */
    CMD9 = 9,
    /** Read CID register */
    CMD10 = 10,
    /** Stop to read data */
    CMD12 = 12,
    /** Change R/W block size */
    CMD16 = 16,
    /** Read block */
    CMD17 = 17,
    /** Read multiple blocks */
    CMD18 = 18,
    /** Number of blocks to erase (SDC) */
    ACMD23 = 23,
    /** Write a block */
    CMD24 = 24,
    /** Write multiple blocks */
    CMD25 = 25,
    /** Initiate initialization process (SDC) */
    ACMD41 = 41,
    /** Leading command for ACMD* */
    CMD55 = 55,
    /** Read OCR */
    CMD58 = 58,
    /** Enable/disable CRC check */
    CMD59 = 59,
}

#[allow(unused)]
#[derive(Debug, Copy, Clone)]
pub enum InitError {
    CMDFailed(CMD, u8),
    CardCapacityStatusNotSet([u8; 4]),
    CannotGetCardInfo,
}

/**
 * Card Specific Data: CSD Register
 */
#[derive(Debug, Copy, Clone)]
pub struct SDCardCSD {
    pub CSDStruct: u8,        /* CSD structure */
    pub SysSpecVersion: u8,   /* System specification version */
    pub Reserved1: u8,        /* Reserved */
    pub TAAC: u8,             /* Data read access-time 1 */
    pub NSAC: u8,             /* Data read access-time 2 in CLK cycles */
    pub MaxBusClkFrec: u8,    /* Max. bus clock frequency */
    pub CardComdClasses: u16, /* Card command classes */
    pub RdBlockLen: u8,       /* Max. read data block length */
    pub PartBlockRead: u8,    /* Partial blocks for read allowed */
    pub WrBlockMisalign: u8,  /* Write block misalignment */
    pub RdBlockMisalign: u8,  /* Read block misalignment */
    pub DSRImpl: u8,          /* DSR implemented */
    pub Reserved2: u8,        /* Reserved */
    pub DeviceSize: u32,      /* Device Size */
    //MaxRdCurrentVDDMin: u8,   /* Max. read current @ VDD min */
    //MaxRdCurrentVDDMax: u8,   /* Max. read current @ VDD max */
    //MaxWrCurrentVDDMin: u8,   /* Max. write current @ VDD min */
    //MaxWrCurrentVDDMax: u8,   /* Max. write current @ VDD max */
    //DeviceSizeMul: u8,        /* Device size multiplier */
    pub EraseGrSize: u8,         /* Erase group size */
    pub EraseGrMul: u8,          /* Erase group size multiplier */
    pub WrProtectGrSize: u8,     /* Write protect group size */
    pub WrProtectGrEnable: u8,   /* Write protect group enable */
    pub ManDeflECC: u8,          /* Manufacturer default ECC */
    pub WrSpeedFact: u8,         /* Write speed factor */
    pub MaxWrBlockLen: u8,       /* Max. write data block length */
    pub WriteBlockPaPartial: u8, /* Partial blocks for write allowed */
    pub Reserved3: u8,           /* Reserded */
    pub ContentProtectAppli: u8, /* Content protection application */
    pub FileFormatGroup: u8,     /* File format group */
    pub CopyFlag: u8,            /* Copy flag (OTP) */
    pub PermWrProtect: u8,       /* Permanent write protection */
    pub TempWrProtect: u8,       /* Temporary write protection */
    pub FileFormat: u8,          /* File Format */
    pub ECC: u8,                 /* ECC code */
    pub CSD_CRC: u8,             /* CSD CRC */
    pub Reserved4: u8,           /* always 1*/
}

/**
 * Card Identification Data: CID Register
 */
#[derive(Debug, Copy, Clone)]
pub struct SDCardCID {
    pub ManufacturerID: u8, /* ManufacturerID */
    pub OEM_AppliID: u16,   /* OEM/Application ID */
    pub ProdName1: u32,     /* Product Name part1 */
    pub ProdName2: u8,      /* Product Name part2*/
    pub ProdRev: u8,        /* Product Revision */
    pub ProdSN: u32,        /* Product Serial Number */
    pub Reserved1: u8,      /* Reserved1 */
    pub ManufactDate: u16,  /* Manufacturing Date */
    pub CID_CRC: u8,        /* CID CRC */
    pub Reserved2: u8,      /* always 1 */
}

/**
 * Card information
 */
#[derive(Debug, Copy, Clone)]
pub struct SDCardInfo {
    pub SD_csd: SDCardCSD,
    pub SD_cid: SDCardCID,
    pub CardCapacity: u64,  /* Card Capacity */
    pub CardBlockSize: u64, /* Card Block Size */
}

/** GPIOHS GPIO number to use for controlling the SD card CS pin */
const SD_CS_GPIONUM: u8 = 7;


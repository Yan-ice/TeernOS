use crate::nk::{
    VirtAddr,
    StepByOne,
    nkapi_translate,
    nkapi_translate_va
};

use crate::task::{current_task, current_user_id};
use crate::debug_info;
use alloc::string::String;
use alloc::vec::Vec;


/// 直接读取指定长度的字节串数据。
pub fn translated_raw(pt_handle: usize, ptr: *const u8, len: usize) -> Vec<&'static mut [u8]> {
    let mut start = ptr as usize;
        let end = start + len;
        let mut v = Vec::new();
        while start < end {
            let start_va = VirtAddr::from(start);
            let mut vpn = start_va.floor();
            //debug_info!("tbb vpn = 0x{:X}", vpn.0);
            // let ppn: PhysPageNum;
            let ppno = nkapi_translate(pt_handle,vpn, true);
            if ppno.is_none() {
                // debug_info!{"preparing into checking lazy..."}
                //debug_info!("check_lazy 3");
                current_task().unwrap().check_lazy(start_va, true);
                unsafe {
                    // llvm_asm!("sfence.vma" :::: "volatile");
                    llvm_asm!("fence.i" :::: "volatile");
                }
                //debug_info!{"preparing into checking lazy..."}
            }
            let ppn = ppno.unwrap();
            //debug_info!("vpn = {} ppn = {}", vpn.0, ppn.0);
            vpn.step();
            let mut end_va: VirtAddr = vpn.into();
            end_va = end_va.min(VirtAddr::from(end));
            if end_va.page_offset() == 0 {
                v.push(&mut ppn.get_bytes_array()[start_va.page_offset()..]);
            } else {
                v.push(&mut ppn.get_bytes_array()[start_va.page_offset()..end_va.page_offset()]);
            }
            start = end_va.into();
        }
        return v;
}

/// 读取一个字符串（遇到\0为止）
pub fn translated_str(pt_handle: usize, ptr: *const u8) -> String {
    let mut string = String::new();
        let mut va = ptr as usize;
        loop {
            let pa = nkapi_translate_va(pt_handle, VirtAddr::from(va));
            if pa.is_none(){
                break;
            }
            let ch: u8 = *(pa).unwrap().get_mut();
            if ch == 0 {
                break;
            }
            string.push(ch as char);
            va += 1;
        }
        return string;
}

///读一个指定类型数据，获取其只读引用。
pub fn translated_ref<T>(pt_handle: usize, ptr: *const T) -> &'static T{
    nkapi_translate_va(pt_handle, VirtAddr::from(ptr as usize)).unwrap().get_ref()
}

///读一个指定类型数据，获取其mutable引用。
pub fn translated_refmut<T>(pt_handle: usize, ptr: *mut T) -> &'static mut T {
    let va = ptr as usize;
    let vaddr = VirtAddr::from(va);
    let pa = nkapi_translate_va(pt_handle, VirtAddr::from(vaddr));
    if pa.is_none() {
        // debug_info!{"preparing into checking lazy..."}
        //debug_info!("check_lazy 2");
        current_task().unwrap().check_lazy(vaddr,true);
        unsafe {
            // llvm_asm!("sfence.vma" :::: "volatile");
            llvm_asm!("fence.i" :::: "volatile");
        }
    }
    // print!("[translated_refmut pa:{:?}]",pa);
    return pa.unwrap().get_mut()
}

///读取一个指定类型数据，获取其复制。
/// T必须是可以复制的类型。
pub fn translated_refcopy<T>(pt_handle: usize, ptr: *mut T) -> T where T:Copy {
    let mut va = ptr as usize;
        let size = core::mem::size_of::<T>();
        //debug_info!("step = {}, len = {}", step, len);
        
        let u_buf = UserBuffer::new( translated_raw(pt_handle, va as *const u8, size) );
        let mut bytes_vec:Vec<u8> = Vec::new();
        u_buf.read_as_vec(&mut bytes_vec, size);
        //debug_info!("loop, va = 0x{:X}, vec = {:?}", va, bytes_vec);
        unsafe{
            return *(bytes_vec.as_slice() as *const [u8] as *const u8 as usize as *const T);
        }
}


pub fn translated_array_copy<T>(token: usize, ptr: *mut T, len: usize) -> Vec<T> where T:Copy {

    let mut ref_vec:Vec<T> = Vec::new();
    let mut va = ptr as usize;
    for i in 0..len{
        ref_vec.push(translated_refcopy(token,va as *mut T));
    }
    ref_vec
}

/* 获取用户数组内各元素的引用 */
/* 目前并不能处理跨页结构体 */
pub fn translated_array_ref<T>(token: usize, ptr: *mut T, len: usize) -> Vec<&'static T>{

    let mut ref_vec:Vec<&'static T> = Vec::new();
    let mut va = ptr as usize;
    for i in 0..len{
        ref_vec.push(translated_refmut(token,va as *mut T));
    }
    ref_vec
}


fn trans_to_bytes<T>(ptr: *const T)->&'static[u8]{
    let size = core::mem::size_of::<T>();
    unsafe {
        core::slice::from_raw_parts(
            ptr as usize as *const u8,
            size,
        )
    }
}

fn trans_to_bytes_mut<T>(ptr: *mut T)->&'static mut [u8]{
    let size = core::mem::size_of::<T>();
    unsafe {
        core::slice::from_raw_parts_mut(
            ptr as usize as *mut u8,
            size,
        )
    }
}


/**
 * 进行memcopy。
 */
pub fn copy_object<T>(src: *const T, dst: *mut T) {
    let token = current_user_id();
    let size = core::mem::size_of::<T>();
    // translated_ 实际上完成了地址合法检测
    let buf = UserBuffer::new(translated_raw(token, src as *const u8, size));
    let mut dst_bytes = trans_to_bytes_mut(dst);
    buf.read(dst_bytes);
}

pub fn copy_array<T>(src: *const T, dst: *mut T, len: usize) {
    let token = current_user_id();
    let size = core::mem::size_of::<T>();
    // translated_ 实际上完成了地址合法检测
    let buf = UserBuffer::new(translated_raw(token, src as *const u8, size*len));
    let mut dst_bytes = trans_to_bytes_mut(dst);
    buf.read(dst_bytes);
}

pub struct UserBuffer {
    pub buffers: Vec<&'static mut [u8]>,
}

impl UserBuffer {
    pub fn new(buffers: Vec<&'static mut [u8]>) -> Self {
        Self { buffers }
    }

    pub fn empty()->Self{
        Self {
            buffers:Vec::new(),
        }
    }
     
    pub fn len(&self) -> usize {
        let mut total: usize = 0;
        for b in self.buffers.iter() {
            total += b.len();
        }
        total
    }

    // 将一个Buffer的数据写入UserBuffer，返回写入长度
    pub fn write(&mut self, buff: &[u8])->usize{
        let len = self.len().min(buff.len());
        let mut current = 0;
        for sub_buff in self.buffers.iter_mut() {
            let sblen = (*sub_buff).len();
            for j in 0..sblen {
                (*sub_buff)[j] = buff[current];
                current += 1;
                if current == len {
                    return len;
                }
            }
        }
        return len;
    }

    pub fn clear( &mut self ){
        for sub_buff in self.buffers.iter_mut() {
            let sblen = (*sub_buff).len();
            for j in 0..sblen {
                (*sub_buff)[j] = 0;
            }
        }
    }

    pub fn write_at(&mut self, offset:usize, buff: &[u8])->isize{
        let len = buff.len();
        if offset + len > self.len() {
            return -1
        }
        let mut head = 0; // offset of slice in UBuffer
        let mut current = 0; // current offset of buff
    
        for sub_buff in self.buffers.iter_mut() {
            let sblen = (*sub_buff).len();
            if head + sblen < offset {
                continue;
            } else if head < offset {
                for j in (offset - head)..sblen {
                    (*sub_buff)[j] = buff[current];
                    current += 1;
                    if current == len {
                        return len as isize;
                    }
                }
            } else {  //head + sblen > offset and head > offset
                for j in 0..sblen {
                    (*sub_buff)[j] = buff[current];
                    current += 1;
                    if current == len {
                        return len as isize;
                    }
                }
            }
            head += sblen;
        }
    
        //for b in self.buffers.iter_mut() {
        //    if offset > head && offset < head + b.len() {
        //        (**b)[offset - head] = char;
        //        //b.as_mut_ptr()
        //    } else {
        //        head += b.len();
        //    }
        //}
        0
    }

    // 将UserBuffer的数据读入一个Buffer，返回读取长度
    pub fn read(&self, buff:&mut [u8])->usize{
        let len = self.len().min(buff.len());
        let mut current = 0;
        for sub_buff in self.buffers.iter() {
            let sblen = (*sub_buff).len();
            for j in 0..sblen {
                buff[current] = (*sub_buff)[j];
                current += 1;
                if current == len {
                    return len;
                }
            }
        }
        return len;
    }

    // TODO: 把vlen去掉    
    pub fn read_as_vec(&self, vec: &mut Vec<u8>, vlen:usize)->usize{
        let len = self.len();
        let mut current = 0;
        for sub_buff in self.buffers.iter() {
            let sblen = (*sub_buff).len();
            for j in 0..sblen {
                vec.push( (*sub_buff)[j] );
                current += 1;
                if current == len {
                    return len;
                }
            }
        }
        return len;
    }

   
}

impl IntoIterator for UserBuffer {
    type Item = *mut u8;
    type IntoIter = UserBufferIterator;
    fn into_iter(self) -> Self::IntoIter {
        UserBufferIterator {
            buffers: self.buffers,
            current_buffer: 0,
            current_idx: 0,
        }
    }
}

pub struct UserBufferIterator {
    buffers: Vec<&'static mut [u8]>,
    current_buffer: usize,
    current_idx: usize,
}

impl Iterator for UserBufferIterator {
    type Item = *mut u8;
    fn next(&mut self) -> Option<Self::Item> {
        if self.current_buffer >= self.buffers.len() {
            None
        } else {
            let r = &mut self.buffers[self.current_buffer][self.current_idx] as *mut _;
            if self.current_idx + 1 == self.buffers[self.current_buffer].len() {
                self.current_idx = 0;
                self.current_buffer += 1;
            } else {
                self.current_idx += 1;
            }
            Some(r)
        }
    }
}
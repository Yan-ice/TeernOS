use crate::nk::{translated_refcopy, translated_refmut};
use alloc::vec::Vec;


pub fn translated_array_copy<T>(token: usize, ptr: *mut T, len: usize) -> Vec<T> where T:Copy {

    let mut ref_vec:Vec<T> = Vec::new();
    let mut va = ptr as usize;
    let step = core::mem::size_of::<T>();
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
    let step = core::mem::size_of::<T>();
    for i in 0..len{
        ref_vec.push(translated_refmut(token,va as *mut T));
    }
    ref_vec
}


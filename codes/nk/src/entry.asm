    .section .text.entry
    .globl _start
_start:
    li a0, 0
    # tp:hart_id 
    # mv a0,tp # RustSBI
    mv tp, a0 # OpenSBI
    
    la a1, boot_stack_top
    slli a0, a0, 15 # hart_id* stacksize
    add a0, a0, a1
    # a0 = boot_stack_top + hart_id* stacksize

    # Yan_ice sp一开始是boot_stack_top的位置。
    mv sp, a0
    call nk_main

    .section .bss.stack
    .globl boot_stack
boot_stack:
    .space 4096 * 8
    .globl boot_stack_top
boot_stack_top:

nk_kernel_stack:
    .space 4096 * 8
    .globl nk_kernel_stack_top
nk_kernel_stack_top:
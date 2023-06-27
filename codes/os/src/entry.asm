    .section .text.entry
    .globl _start
_start:
    # tp:hart_id 
    # mv a0,tp # RustSBI
    mv tp, a0 # OpenSBI

    # Yan_ice: currently let a0 (hart id) be only 0
    li a0, 0

    la a1, boot_stack_top
    
    slli a0, a0, 15 # hart_id* stacksize

    # Yan_ice sp一开始是boot_stack_top的位置。
    add sp, a0, a1
    # a0 = boot_stack_top + hart_id* stacksize

    call outer_kernel_init

    .section .bss.stack
    .globl boot_stack
boot_stack:
    .space 4096 * 2
    .globl boot_stack_top
boot_stack_top:

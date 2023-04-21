
    .section .text.nktrampoline
    .globl __nktraps
    .globl __nkrestore
    .align 2
__nktraps:
    #sd x1, 1*8(t0)
    csrrw sp, sscratch, sp
    #csrw sscratch, sp
    #addi t0, zero, 8
    #slli t0, t0, 28
    #addi t1, t1, 1
    #slli t1, t1, 12
    #sub  sp, t0, t1 #sp should be 0x7FFFF000
    # now sp->*TrapContext in user space, sscratch->user stack
    # save other general purpose registers
    sd x1, 1*8(sp)
    # skip sp(x2), we will save it later
    sd x3, 3*8(sp)
    # skip tp(x4), application does not use it
    # save x5~x31
    .set n, 5
    .rept 27
        SAVE_GP %n
        .set n, n+1
    .endr
    # we can use t0/t1/t2 freely, because they have been saved in TrapContext
    csrr t0, sstatus
    csrr t1, sepc
    sd t0, 32*8(sp)
    sd t1, 33*8(sp)
    # read user stack from sscratch and save it in TrapContext
    csrr t2, sscratch
    sd t2, 2*8(sp)
    #fsd fs1, 34*8(sp)
    .half 0xba22
    .half 0xbe26
    # load kernel_satp into t0
    ld t0, 34*8(sp)
    # load trap_handler into t1
    ld t1, 36*8(sp)
    # move to kernel_sp
    ld sp, 35*8(sp)
    # switch to kernel space
    # csrw satp, t0
    # sfence.vma
    sfence.vma zero, zero
    # jump to trap_handler
    jr t1

__nkrestore:
    # a0: *TrapContext of outer kernel
    # switch to outer kernel space
    sfence.vma zero, zero
    # 将a0写给sscratch
    csrw sscratch, a0
    # 将a0写给sp
    mv sp, a0

    # now sp points to TrapContext in user space, start restoring based on it
    # restore sstatus/sepc
    ld t0, 32*8(sp) # sstatus
    ld t1, 33*8(sp) # sepc

    #fld fs1, 34*8(sp)
    .half 0x3452
    .half 0x34f2

    csrw sstatus, t0
    csrw sepc, t1
    # restore general purpose registers except x0/sp(x2)/tp
    ld x1, 1*8(sp)
    ld x3, 3*8(sp)
    .set n, 5
    .rept 27
        LOAD_GP %n
        .set n, n+1
    .endr
    # back to user stack
    ld sp, 2*8(sp)
    
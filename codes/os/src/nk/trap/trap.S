.altmacro
.macro SAVE_GP n
    sd x\n, \n*8(sp)
.endm
.macro LOAD_GP n
    ld x\n, \n*8(sp)
.endm
    .section .text.trampoline
    .globl __alltraps
    .globl __restore
    .align 2
__alltraps:
    # trap context
    # csrr x10, sepc
    # addi x10, x10, 16
    # csrw sepc, x10
    # sret
    # sd x1, 1*8(t0)

    csrrw sp, sscratch, sp # 第一次进入这段汇编之前，是先进入了下面的restore汇编
                           # 所以这里进来的之前，sscratch的值就是TRAP_CONTEXT的值，sp是用户栈的位置，因为pc指的指令触发了trap
                           # CPU直接根据stvec的值跳转了进来，sp没有被中途改变

    # csrw sscratch, sp
    # addi t0, zero, 8
    # slli t0, t0, 28
    # addi t1, t1, 1
    # slli t1, t1, 12
    # sub  sp, t0, t1 #sp should be 0x7FFFF000
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

    # fsd fs1, 34*8(sp)
    .half 0xba22
    .half 0xbe26
    # load trap_handler into t1
    ld t1, 35*8(sp)
    # move to kernel_sp
    ld sp, 34*8(sp)

    # sfence.vma
    sfence.vma zero, zero

    # jump to trap_handler
    jr t1

__restore:

    csrw sscratch, a0 # 把a0的值写入sscratch，对于每次在trap return中执行这里的时候
                      # a0的值都是TRAP_CONTEXT，这个地方也是trap context存在的位置

    # 所有用户的trapcontext都保存在同一个虚拟地址位置 TRAP_CONTEXT
    # sfence.vma
    # sfence.vma zero, zero

    mv sp, a0         # 把a0的值写入sp
    # now sp points to TrapContext in user space, start restoring based on it

    # restore sstatus/sepc
    ld t0, 32*8(sp)   # 按照存储规则去加载trap context中的值
    ld t1, 33*8(sp)   
    csrw sstatus, t0  # 继续恢复上面的值
    csrw sepc, t1

    # restore general purpose registers except x0/sp/tp
    ld x1, 1*8(sp)
    ld x3, 3*8(sp)
    .set n, 5
    .rept 27
       LOAD_GP %n
        .set n, n+1
    .endr
    # back to user stack

    ld sp, 2*8(sp) # restore sp at last.

    # csrr x30, sepc
    # jr x30
    sret # 跳转到sepc的位置继续执行

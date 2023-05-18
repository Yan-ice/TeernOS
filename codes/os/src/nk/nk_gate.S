.altmacro
.macro SAVE_REGISTER n
    sd x\n, \n*8(x10)
.endm

.macro LOAD_REGISTER n
    ld x\n, \n*8(sp)
.endm

.globl nk_exit
    # 结构 
    # #####################################
    # 高地址
    # 维护: nk satp
    # 加载: outer satp
    # 加载: outer register (0, 1, ......, 31)
    # 保存：nk register (0, 1, ......, 31)
    # 低地址
    # #####################################
nk_exit:
    # store all nk registers, 包括栈指针
    .set n, 1
    .rept 31
        SAVE_REGISTER %n
        .set n, n+1
    .endr
    
    # restore all outer kernel registers
    addi sp, x10, 32*8

    ld x1, 1*8(sp)
    ld x3, 3*8(sp)
    .set n, 5
    .rept 27
         LOAD_REGISTER %n
    .set n, n+1
    .endr

    # set ra
    ld x6, -21*8(sp)
    addi sp, sp, 32*8

    # change satp  
    ld x7, 32(sp)
    csrw satp, x7
    jr x6
    
    # change stack
    ld sp, 2*8(sp)
    jr x6


.globl nk_entry
    # 入参 x10 PROXYCONTEXT地址
    # 结构
    # #####################################
    # 高地址
    # 加载: nk satp
    # 维护: outer satp
    # 加载: outer register (0, 1, ......, 31)
    # 保存：nk register (0, 1, ......, 31)
    # 低地址
    # #####################################
nk_entry:

    # store all outer kernel registers, 包括栈指针

    addi sp, sp, 32

    .set n, 0
    .rept 31
        SAVE_REGISTER %n
        .set n, n+1
    .endr

    addi sp, sp, -32
    
    sd sp, 34(sp)

    # restore register except sp

    ld x1, 1*8(sp)
    ld x3, 3*8(sp) 
    .set n, 5
    .rept 27
        LOAD_REGISTER %n
        .set n, n+1
    .endr

    ld sp, 34*8(sp)

    # exit gate怎么进来就怎么回去

    jr x1

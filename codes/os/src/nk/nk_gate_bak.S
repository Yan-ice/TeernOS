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
    # 加载: outer satp
    # 维护: nk satp
    # 加载: outer register (0, 1, ......, 31)
    # 保存：nk register (0, 1, ......, 31)
    # 低地址
    # #####################################
nk_exit2:
    
    # store all nk registers, 包括栈指针
    .set n, 1
    .rept 31
        SAVE_REGISTER %n
        .set n, n+1
    .endr
    
    addi sp, x10, 32*8
    # restore all outer kernel registers

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
    ld x7, 8(sp)
    csrw satp, x7
    
    # change stack
    ld sp, -30*8(sp)
    jr x6


.globl nk_entry
    # 入参 x10 PROXYCONTEXT()地址
    # 结构
    # #####################################
    # 高地址
    # 维护: outer satp
    # 加载: nk satp
    # 加载: outer register (0, 1, ......, 31)
    # 保存：nk register (0, 1, ......, 31)
    # 低地址
    # #####################################
nk_entry2:

    # store all outer kernel registers, 包括栈指针

    addi sp, sp, 32

    .set n, 0
    .rept 31
    # has mistakes if use SAVE_REGISTER macro
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

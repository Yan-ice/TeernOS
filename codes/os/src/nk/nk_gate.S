.altmacro
.macro SAVE_REGISTER n
    sd x\n, \n*8(sp)
.endm

.macro LOAD_REGISTER n
    ld x\n, \n*8(sp)
.endm

.globl nk_exit
    # 入参 x10 PROXYCONTEXT地址， x11 待代理的方法的地址
    # 结构 
    # #####################################
    # 高地址
    # 维护: nk satp
    # 加载: outer satp  寄在这里
    # 加载：outersp
    # 保存：nksp
    # 加载: outer register (0, 1, ......, 31)
    # 保存：nk register (0, 1, ......, 31)
    # 低地址
    # #####################################
nk_exit:

    # store nk sp
    sd sp, 8*64(x10)
    # change sp to PROXYCONEXT address
    ld sp, 0(x10)
    # store all nk registers
    .set n, 0
    .rept 32
        SAVE_REGISTER %n
        .set n, n+1
    .endr
    # restore all outer kernel registers
    addi sp, sp, 32*8
    ld x1, 1*8(sp)
    ld x3, 3*8(sp) 
    .set n, 5
    .rept 27
        LOAD_REGISTER %n
        .set n, n+1
    .endr
    # set ra
    addi x7, sp, -168
    ld x6, 0(x7)
    # change satp  
    addi sp, sp, 33*8
    ld x7, 16(sp)
    csrw satp, x7
    # change stack
    ld sp, (sp)  # bug
    jr x6


.globl nk_entry
    # 入参 x10 PROXYCONTEXT地址
    # 结构
    # #####################################
    # 高地址
    # 加载: nk satp
    # 维护: outer satp
    # 加载：outersp
    # 保存：nksp
    # 加载: outer register (0, 1, ......, 31)
    # 保存：nk register (0, 1, ......, 31)
    # 低地址
    # #####################################
nk_entry:

    # store outer kernel sp
    sd sp, 8*65(x10)
    # change sp to PROXYCONEXT address
    ld sp, 0(x10)
    # store all outer registers
    addi sp, sp, 32*8
    .set n, 0
    .rept 32
        SAVE_REGISTER %n
        .set n, n+1
    .endr
    # restore all nested kernel registers
    addi sp, sp, -32*8
    ld x1, 1*8(sp)
    ld x3, 3*8(sp) 
    .set n, 5
    .rept 27
        LOAD_REGISTER %n
        .set n, n+1
    .endr
    # change stack
    ld sp, 64*8(sp)
    jr ra
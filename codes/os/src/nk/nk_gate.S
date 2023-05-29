.altmacro
.macro SAVE_REGISTER2 n o
    sd x\n, \o*8+\n*8(x28)
.endm

.macro LOAD_REGISTER2 n o
    ld x\n, \o*8+\n*8(x28)
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
nk_exit:

    # let x28 to be ProxyContext (NK_TRAMPOLINE)
    li x28, 0
    li x30, 0x1000
    sub x28, x28, x30

    # store all nk registers, 包括栈指针
    .set n, 1
    .rept 27
        SAVE_REGISTER2 %n 0
        .set n, n+1
    .endr

    .set n, 1
    .rept 27
        LOAD_REGISTER2 %n 32
    .set n, n+1
    .endr

    # enable interrupt
    csrsi sstatus, 2

    # change satp  
    ld x30, 65*8(x28)
    csrw satp, x30
    
    # jump back, according to outer kernel's ra
    jr x1


.globl nk_entry
    # 入参 x10 nkapi handler
    # 入参 x11~x15 params
    # 结构
    # #####################################
    # 高地址
    # 维护: outer satp
    # 加载: nk satp
    # 加载: outer register (0, 1, ......, 31)
    # 保存：nk register (0, 1, ......, 31)
    # 低地址
    # #####################################
nk_entry:

    # let x28 to be ProxyContext (NK_TRAMPOLINE)
    li x28, 0
    li x30, 0x1000
    sub x28, x28, x30

    # change satp  
    ld x30, 8*64(x28)
    csrw satp, x30
    
    # store all outer kernel registers, 包括栈指针
    .set n, 1
    .rept 27
    # has mistakes if use SAVE_REGISTER macro
        SAVE_REGISTER2 %n 32
        .set n, n+1
    .endr

    # restore nk register
    .set n, 1
    .rept 27
         LOAD_REGISTER2 %n 0
    .set n, n+1
    .endr
    
    # temply load the outer sp, to load params
    ld sp, 34*8(x28)

    # extract the params for handler function call
    ld x10, 0*8(sp)
    ld x11, 1*8(sp)
    ld x12, 2*8(sp)
    ld x13, 3*8(sp)
    ld x14, 4*8(sp)
    ld x15, 5*8(sp)
    addi sp, sp, 6*8

    # save the outer sp, after taking params out
    sd sp, 34*8(x28)

    # load nk sp back
    ld sp, 2*8(x28)

    mv x29, x10
    mv x10, x11
    mv x11, x12
    mv x12, x13
    mv x13, x14
    mv x14, x15
    # handler function call
    jalr x1, x29, 0

    # let x28 to be ProxyContext (NK_TRAMPOLINE)
    li x28, 0
    li x30, 0x1000
    sub x28, x28, x30
    
    # save ret value and ret address from function handler call
    sd x10, (32+10)*8(x28)
    sd x11, (32+11)*8(x28)

    # exit
    j nk_exit


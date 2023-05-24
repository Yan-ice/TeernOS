.altmacro
.macro SAVE_REGISTER2 n o
    sd x\n, \o*8+\n*8(x28)
.endm

.macro LOAD_REGISTER2 n o
    ld x\n, \o*8+\n*8(x28)
.endm

.globl nk_exit2

    # 入参 x28 PROXYCONTEXT()
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
    .rept 27
        SAVE_REGISTER2 %n 0
        .set n, n+1
    .endr

    .set n, 1
    .rept 27
        LOAD_REGISTER2 %n 32
    .set n, n+1
    .endr
    
    # change satp  
    ld x30, 65*8(x28)
    csrw satp, x30

    # enable interrupt
    csrsi sstatus, 2

    # jump back, according to outer kernel's ra
    jr x1


.globl nk_entry2
    # 入参 x10~17 DO NOT MODIFY
    # 入参 x28 PROXYCONTEXT()
    # 入参 x29 nkapi handler
    # the value in x30 will lost.
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

    # restore register
    .set n, 1
    .rept 27
         LOAD_REGISTER2 %n 0
    .set n, n+1
    .endr
    
    # restore PROXYCONTEXT()
    # ld x28, (32+28)*8(sp)
    # restore handler
    # ld x29, (32+29)*8(sp)

    # restore nk sp
    # ld sp, 2*8(sp)

    # then push proxy context into nk sp
    sd x28, 0(sp)
    addi sp,sp,-8

    # function call to the handler
    # the return value would be directly saved into outer kernel context
    ld x10, (32+10)*8(x28)
    ld x11, (32+11)*8(x28)
    ld x12, (32+12)*8(x28)
    ld x13, (32+13)*8(x28)
    ld x14, (32+14)*8(x28)
    ld x15, (32+15)*8(x28)
    ld x16, (32+16)*8(x28)
    ld x17, (32+17)*8(x28)
    jalr x1, x29, 0

    # restore proxy context from nk sp
    addi sp,sp,8
    ld x28, 0(sp)

    sd x10, (32+10)*8(x28)
    sd x11, (32+11)*8(x28)

    # exit
    j nk_exit2


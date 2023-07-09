
.altmacro
.macro SAVE_REGISTER n
    sd x\n, \n*8(sp)
.endm

.macro LOAD_REGISTER n
    ld x\n, \n*8(sp)
.endm

.macro SAVE_REGISTER2 n o
    sd x\n, \o*8+\n*8(x28)
.endm

.macro LOAD_REGISTER2 n o
    ld x\n, \o*8+\n*8(x28)
.endm


.section .text.nktrampoline

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
    li x30, 0x3000
    sub x28, x28, x30

    ld x30, 91*8(x28) # nkapi_level
    bne x30, zero, nk_bypass # nkapi_level is 0 means in ok (gate), >0 means in nk (bypass).

    addi x30, x30, 1
    sd x30, 91*8(x28) # api level add 1 when entry

    ld x29, 64*8(x28)
    csrw satp, x29

    # li x28, 0
    # li x30, 0x3000
    # sub x28, x28, x30

    # store all outer kernel registers to proxy, 包括栈指针
    .set n, 1
    .rept 27
       SAVE_REGISTER2 %n 32
        .set n, n+1
    .endr

    # load nk sp back
    ld sp, 2*8(x28)

    # the handler in nkcall vec:  ProxyContext addr + 66*8 + nk_call_num*8
    add x29, x28, x17
    ld x29, 66*8(x29)

    # handler function call
    jalr x1, x29, 0

    # let x28 to be ProxyContext (NK_TRAMPOLINE)
    li x28, 0
    li x30, 0x3000
    sub x28, x28, x30
    
    # save ret value and ret address from function handler call
    sd x10, (32+10)*8(x28)
    sd x11, (32+11)*8(x28)

    # exit
    j nk_exit


.globl nk_bypass

nk_bypass:
    # let x28 to be ProxyContext (NK_TRAMPOLINE)
    li x28, 0
    li x30, 0x3000
    sub x28, x28, x30

    addi sp,sp,-30*8
    # store all nk registers
    .set n, 1
    .rept 28
        SAVE_REGISTER %n
        .set n, n+1
    .endr

    # the handler in nkcall vec:  ProxyContext addr + 66*8 + nk_call_num*8
    add x29, x28, x17
    ld x30, 66*8(x29)

    # handler function call
    jalr x1, x30, 0

    # let x28 to be ProxyContext (NK_TRAMPOLINE)
    li x28, 0
    li x30, 0x3000
    sub x28, x28, x30
    
    # keep the retval
    mv x29, x10
    mv x30, x11

    # load all nk registers
    .set n, 1
    .rept 28
        LOAD_REGISTER %n
        .set n, n+1
    .endr
    addi sp,sp,30*8

    # restore the retval
    mv x10, x29
    mv x11, x30

    jr x1

    
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
    li x30, 0x3000
    sub x28, x28, x30

    # save nk sp
    sd x1, 1*8(x28)
    sd sp, 2*8(x28)

    ld x30, 91*8(x28) # nkapi level
    addi x30, x30, -1
    sd x30, 91*8(x28) # api level remove 1 when exit

    # enable interrupt
    csrsi sstatus, 2

    # change satp  
    ld x29, 65*8(x28)
    csrw satp, x29

    .set n, 1
    .rept 27
        LOAD_REGISTER2 %n 32
    .set n, n+1
    .endr

    # jump back, according to outer kernel's ra
    jr x1


.altmacro
.macro SAVE_REGISTER n
    sd x\n, \n*8(sp)
.endm

.macro LOAD_REGISTER n
    ld x\n, \n*8(sp)
.endm

.globl nk_exit
    # 结构
    # #####################################
    # 加载：outersp
    # 保存：nksp
    # 加载: outer register (0, 1, ......, 31)
    # 保存：nk register (0, 1, ......, 31)
    # #####################################
nk_exit:
    # store nk sp
    sd sp, 8*64(x10)
    # change sp to PROXYCONEXT address
    addi sp, x10, 0
    # store all nk registers
    .set n, 0
    .rept 32
        SAVE_REGISTER %n
        .set n, n+1
    .endr
    # restore all outer kernel registers
    addi sp, sp, 32*8
    .set n, 0
    .rept 32
        LOAD_REGISTER %n
        .set n, n+1
    .endr
    # change stack
    ld sp, 33*8(sp)


.globl nk_entry
    # 结构
    # #####################################
    # 保存：outersp
    # 恢复：nksp
    # 保存: outer register (0, 1, ......, 31)
    # 恢复：nk register (0, 1, ......, 31)
    # #####################################
nk_entry:
    # store outer kernel sp
    sd sp, 8*65(x10)
    # change sp to PROXYCONEXT address
    addi sp, x10, 0
    # store all outer registers
    addi sp, sp, 32*8
    .set n, 0
    .rept 32
        SAVE_REGISTER %n
        .set n, n+1
    .endr
    # restore all nested kernel registers
    addi sp, sp, -32*8
    .set n, 0
    .rept 32
        LOAD_REGISTER %n
        .set n, n+1
    .endr
    # change stack
    ld sp, 64*8(sp)
.macro save_context n
    sd x\n, -\n*8(sp)
.endm

.globl save_context

save_context:
    .set n, 3
    .rept 27
        save_context %n
    .set n, n+1
    .endr

    jr x1

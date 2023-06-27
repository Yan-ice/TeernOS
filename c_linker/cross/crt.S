.section .text.entry
.globl _my_start
_my_start:
    li tp, 0x20000
    mv a0, sp
    j main

.section .text.entry
.globl _my_start
_my_start:
    mv a0, sp
    j main

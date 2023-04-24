.altmacro
.macro SAVE_SN n
    sd s\n, (\n+1)*8(sp)
.endm
.macro LOAD_SN n
    ld s\n, (\n+1)*8(sp)
.endm
    .section .text
    .globl __switch
__switch:
    # __switch(
    #     current_task_cx_ptr2: &*const TaskContext,  a0 注意这个参数类型，包括一个返回地址和12个usize
    #     next_task_cx_ptr2: &*const TaskContext      a1
    # )
    # push TaskContext to current sp and save its address to where a0 points to
    addi sp, sp, -13*8  # 因为要存东西所以先移栈
    sd sp, 0(a0)  # 把当前移动后的栈指针的位置存到 TaskContext 的开始
    # fill TaskContext with ra & s0-s11
    sd ra, 0(sp)  # 开始保存当前寄存器的状态到当前的kernel stack
    .set n, 0
    .rept 12
        SAVE_SN %n
        .set n, n + 1
    .endr
    # ready for loading TaskContext a1 points to
    ld sp, 0(a1) # 加载 next task context，每一个fork还有new pcb生成时，这里都是trap handler的地址，也就是说，每次switch之前，这里都是要跳转的trap handler的位置
                 # 这个TaskContext感觉就是负责从__switch走到trap handler再到__restore的，因为和进程相关的信息都在pcb中，这个小东西完全没有用，只是用来负责跳转 和 寄存器值的储存
    # load registers in the TaskContext
    ld ra, 0(sp) # 怎么存怎么恢复，接下来ret要调回的就是trap return
    .set n, 0
    .rept 12
        LOAD_SN %n
        .set n, n + 1
    .endr
    # pop TaskContext
    addi sp, sp, 13*8
    # fence.i
    # sfence.vma
    ret  # 这里我认为应该用伪指令来理解，__switch这段代码的执行肯定是在S模式，理论上不能用ret
         # 但是ret在实际执行的时候会被拆解成 jalr x0, 0(x1)执行，也就是跳转到x1指的位置去执行
         # x1 是 ra寄存器是 0(sp)来的，也就是trap return，pc就过去了


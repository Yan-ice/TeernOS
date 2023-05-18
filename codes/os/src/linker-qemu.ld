OUTPUT_ARCH(riscv)
ENTRY(_start)
BASE_ADDRESS = 0x80200000;

SECTIONS
{
    . = BASE_ADDRESS;
    skernel = .;

    stext = .;
    .text : {
        *(.text.entry)
        . = ALIGN(4K);
        strampoline = .;
        *(.text.trampoline);
        . = ALIGN(4K);

        ssignaltrampoline = .;
        *(.text.signaltrampoline);
        . = ALIGN(4K);

        snktrampoline = .;
        *(.text.nktrampoline);
        . = ALIGN(4K);

        *(.text .text.*)
    }
    . = ALIGN(4K);
    etext = .;

    srodata = .;
    .rodata : {
        *(.rodata .rodata.*)
    }
    . = ALIGN(4K);
    erodata = .;

    sdata = .;
    .data : {
        *(.data .data.*)
    }
    . = ALIGN(4K);
    edata = .;

    sbss_with_stack = .;
    .bss : {
        *(.bss.stack)
        sbss = .;
        *(.bss .bss.*)
    }
    . = ALIGN(4K);
    ebss = .;

    snkheap = .;
    . = . + 1024*4K;
    enkheap = .;

    ekernel = .;

    /DISCARD/ : {
        *(.eh_frame)
    }

    /* 新加一段outer kernel space，暂时命名为okernel */
    . = 0x80800000;
    sokernel = .;

    outer_allocator = .;
    . = .+4K;

    sokheap = .;
    . = . + 1024*4K;
    eokheap = .;

    sokernelstack = .;
    . = .+8K;
    eokernelstack = .;
    . = .+8K;
    eokernel = .;
}
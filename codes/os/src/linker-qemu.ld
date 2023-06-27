OUTPUT_ARCH(riscv)
ENTRY(_start)
BASE_ADDRESS = 0x80800000;

SECTIONS
{
    . = BASE_ADDRESS;
    sokernel = .;

    stext = .;
    .text : {
        *(.text.entry)
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

    /DISCARD/ : {
        *(.eh_frame)
    }

    eokernel = .;

    /* . = 0x88000000; */
    /* OUTER SPACE END */
}
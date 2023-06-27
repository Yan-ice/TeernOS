OUTPUT_ARCH(riscv)
ENTRY(_my_start)

SECTIONS {
    .init :{
    	KEEP (*(SORT_NONE(.init)))
    }
    .text : { 
        *(.text.entry)
        *(.text .text.*)
    }

    
    .bss : { 
        *(.bss .bss.*)
        *(.sbss .sbss.*)
    }

    .data : { 
        *(.data .rodata) 
        *(.sdata .sdata.*)
    }
    
    __global_pointer$ = .;
    
    .preinit_array : {
    	__preinit_array_start = .;
    	*(.preinit_array.*)
    	__preinit_array_end = .;
    }
    
    .init_array : {
    	__init_array_start = .;
    	*(SORT(.init_array.*))
    	*(.init_array*)
    	__init_array_end = .;
    }
    
    .eh_frame : {
    	*(.eh_*)
    }
}

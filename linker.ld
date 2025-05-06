ENTRY(_start)
SECTIONS {
	. = 0x100000;

	.multiboot : {
		*(.multiboot)
		KEEP(*(.multiboot))
	}
	.text : { *(.text) }

	.data : { *(.data) }

	.bss : { *(.bss) }

	/DISCARD/ : { *(.eh_frame) *(.comment)  }
}

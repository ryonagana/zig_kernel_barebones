#!/bin/env bash

set -x


if ! [ -z "$1" ]; then
	case "$1" in
	clean)
		rm -rf *.bin *.iso *.o *.raw
	;;

	build)
		zig build-exe kernel.zig -target x86-freestanding -O ReleaseSmall -fno-entry --name kernel.bin -T linker.ld
        	llvm-objcopy-19 -O binary kernel.bin kernel.raw
            cp kernel.bin iso/boot/kernel.bin
            grub-mkrescue -o kernel.iso iso/ 
	;;

	*)

		;;
        esac
else
		zig build-exe kernel.zig -target x86-freestanding -O ReleaseSmall -fno-entry --name kernel.bin -T linker.ld -fno-compiler-rt -lc
		llvm-objcopy-19 -O binary kernel.bin kernel.raw
		cp kernel.bin iso/boot/kernel.bin
        grub-mkrescue -o kernel.iso iso/ 
		qemu-system-x86_64 -cdrom kernel.iso
fi

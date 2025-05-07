#!/bin/env bash

set -x

LLVM_OBJCOPY=llvm-objcopy-19
CP=cp
ZIG=zig
ISO=grub-mkrescue
QEMU=qemu-system-i386


cmd_exists(){
	IFS=:
	for dir in $PATH; do
		if [ -x "$dir/$1" ]; then
			return 0
		fi
	done
}


if ! cmd_exists $ZIG; then
	echo "zig not found"
	echo "please install zig"
	exit 1
fi
if ! cmd_exists $ISO; then
	echo "grub-mkrescue not found"
	echo "please install grub"
	exit 1
fi
if ! cmd_exists $QEMU; then
	echo "qemu-system-x86_64 not found"
	echo "please install qemu"
	exit 1
fi

if ! cmd_exists $LLVM_OBJCOPY; then
	echo "llvm-objcopy-19 not found"
	echo "trying llvm-objcopy"
	LLVM_OBJCOPY=llvm-objcopy
	
	if ! cmd_exists $LLVM_OBJCOPY; then
		echo "llvm-objcopy not found"
		echo "please install llvm-19 or llvm-20"
		exit 1
	fi
fi


if ! [ -z "$1" ]; then
	case "$1" in
	clean)
		rm -rf *.bin *.iso *.o *.raw
	;;

	build)
		${ZIG} build-exe src/kernel.zig -target x86-freestanding -O ReleaseSmall -fno-entry --name kernel.bin -T linker.ld -fno-compiler-rt
        	${LLVM_OBJCOPY} -O binary kernel.bin kernel.raw
            ${CP} kernel.bin iso/boot/kernel.bin
            ${ISO} -o kernel.iso iso/ 
	;;

	*)

		;;
        esac
else
		${ZIG} build-exe src/kernel.zig -target x86-freestanding -O ReleaseSmall -fno-entry --name kernel.bin -T linker.ld -fno-compiler-rt
		${LLVM_OBJCOPY} -O binary kernel.bin kernel.raw
		${CP} kernel.bin iso/boot/kernel.bin
        ${ISO} -o kernel.iso iso/ 
		${QEMU} -cdrom kernel.iso
fi

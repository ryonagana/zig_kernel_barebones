# Zig Kernel Example

Zig Kernel Example is a barebones kernel project written in Zig.

## Features
- Minimalistic kernel design.
- Written entirely in Zig for simplicity and performance.

## Requirements
- Zig compiler (0.14.0).
- QEMU or another x86 emulator for testing.
- Need Xorriso (Debian)

## Install Dependencies
```bash
        sudo apt install xorriso qemu-system-x86
```

## Building the Project
1. Clone the repository:
    ```bash
    git clone https://github.com/ryonagana/
    zig_kernel_barebones.git
    cd zig_kernel_barebones
    ```

2. Build the kernel and Bootable ISO:
    ```bash
    ./build.sh
    ```


## Running the Kernel
Run the kernel using QEMU:
```bash
qemu-system-x86_64 -cdrom kernel.iso
```


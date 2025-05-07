const multiboot_header_type =   extern struct {
    magic: u32 = 0x1BADB002,
    flags: u32 = 0x0,
    checksum:u32 = 0x100000000 - 0x1BADB002
};

// forca o struct sem incluso no binario
export var multiboot_header: multiboot_header_type  align(4) linksection(".multiboot")   = .{};

export fn _start() callconv(.C) noreturn {

    const vga_buffer = @as(*volatile [80*25]u16, @ptrFromInt(0xB8000));

    const hello = "Hello World from Zig!";



    for(hello, 0..) |c,i| {
        vga_buffer[i] = @as(u16, c) | @as(u16, 0x0F) << 8;
    }



    while(true){}

}
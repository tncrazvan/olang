const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const nextBlock = @import("./lib/next-block.zig").nextBlock;

pub fn main() !void {
    // const strValue = "Hello, World!";
    // const startOffset: usize = 7;
    // const endOffset: usize = 12;
    // const slice = strValue[startOffset..endOffset];
    // std.debug.print("Slice: {s}\n", .{slice});

    const block = try nextBlock("{ this is content} qwerqwrweqqwe");
    try expect(equals(u8, block.value, " this is content"));
    try expect(equals(u8, block.next, " qwerqwrweqqwe"));

    std.debug.print("value: {s}\n", .{block.value});
    std.debug.print("next: {s}\n", .{block.next});
}

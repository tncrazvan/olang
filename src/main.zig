const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const nextBlock = @import("./lib/next-block.zig").nextBlock;

pub fn main() !void {
    const block = try nextBlock("{ this is content} qwerqwrweqqwe");
    try expect(equals(u8, block.value, ""));
    try expect(equals(u8, block.next, ""));
}

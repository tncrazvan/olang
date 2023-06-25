const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const nextMacroName = @import("./lib/next-macro-name.zig").nextMacroName;

pub fn main() !void {
    var name = try nextMacroName("@my_var");
    try expect(equals(u8, name.value, "my_var"));
}

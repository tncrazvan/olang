const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const nextBooleanMember = @import("./lib/next-boolean-member.zig").nextBooleanMember;

pub fn main() !void {
    var member = try nextBooleanMember("true and true");
    try expect(equals(u8, member.left, "true"));
}

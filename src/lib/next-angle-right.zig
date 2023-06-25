const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const startsWith = std.mem.startsWith;

pub fn nextAngleRight(payload: []const u8) ![]const u8 {
    if (payload.len == 0) {
        return error.Invalid;
    }
    return if (payload[0] == '>')
        payload[1..]
    else
        error.Invalid;
}

test "next angle right (1)" {
    try expect(equals(u8, try nextAngleRight(">"), ""));
}

test "next angle right (2)" {
    try expect(equals(u8, try nextAngleRight("> "), " "));
}

test "next angle right (3)" {
    try expect(equals(u8, nextAngleRight(" >") catch "", ""));
}

test "next angle right (4)" {
    try expect(equals(u8, nextAngleRight("s") catch "", ""));
}

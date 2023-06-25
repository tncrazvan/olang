const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const startsWith = std.mem.startsWith;

pub fn nextRoundRight(payload: []const u8) ![]const u8 {
    if (payload.len == 0) {
        return error.Invalid;
    }
    return if (payload[0] == ')')
        payload[1..]
    else
        error.Invalid;
}

test "next round right (1)" {
    try expect(equals(u8, try nextRoundRight(")"), ""));
}

test "next round right (2)" {
    try expect(equals(u8, try nextRoundRight(") "), " "));
}

test "next round right (3)" {
    try expect(equals(u8, nextRoundRight(" )") catch "", ""));
}

test "next round right (4)" {
    try expect(equals(u8, nextRoundRight("s") catch "", ""));
}

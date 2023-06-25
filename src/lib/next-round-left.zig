const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const startsWith = std.mem.startsWith;

pub fn nextRoundLeft(payload: []const u8) ![]const u8 {
    if (payload.len == 0) {
        return error.Invalid;
    }
    return if (payload[0] == '(')
        payload[1..]
    else
        error.Invalid;
}

test "next round left (1)" {
    try expect(equals(u8, try nextRoundLeft("("), ""));
}

test "next round left (2)" {
    try expect(equals(u8, try nextRoundLeft("( "), " "));
}

test "next round left (3)" {
    try expect(equals(u8, nextRoundLeft(" (") catch "", ""));
}

test "next round left (4)" {
    try expect(equals(u8, nextRoundLeft("s") catch "", ""));
}

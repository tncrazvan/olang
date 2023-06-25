const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const startsWith = std.mem.startsWith;

pub fn nextCurlyRight(payload: []const u8) ![]const u8 {
    if (payload.len == 0) {
        return error.Invalid;
    }
    return if (payload[0] == '}')
        payload[1..]
    else
        error.Invalid;
}

test "next curly right (1)" {
    try expect(equals(u8, try nextCurlyRight("{"), ""));
}

test "next curly right (2)" {
    try expect(equals(u8, try nextCurlyRight("{ "), " "));
}

test "next curly right (3)" {
    try expect(equals(u8, nextCurlyRight(" {") catch "", ""));
}

test "next curly right (4)" {
    try expect(equals(u8, nextCurlyRight("s") catch "", ""));
}

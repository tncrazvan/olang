const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn nextQuote(payload: []const u8) ![]const u8 {
    if (payload.len == 0) return error.Invalid;
    return if (payload[0] == '"')
        payload[1..]
    else
        error.Invalid;
}

test "next quote (1)" {
    try expect(equals(u8, try nextQuote("\""), ""));
}

test "next quote (2)" {
    try expect(equals(u8, try nextQuote("\"asd"), "asd"));
}

test "next quote (3)" {
    const result = nextQuote(" \"qwerty") catch "";
    try expect(equals(u8, result, ""));
}

const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn nextPropertySeparator(payload: []const u8) ![]const u8 {
    if (payload.len == 0) return error.Invalid;
    return if (payload[0] == '.')
        payload[1..]
    else
        error.Invalid;
}

test "next property separator (1)" {
    try expect(equals(u8, try nextPropertySeparator("."), ""));
}

test "next property separator (2)" {
    try expect(equals(u8, try nextPropertySeparator(".asd"), "asd"));
}

test "next property separator (3)" {
    const result = nextPropertySeparator(" .qwerty") catch "";
    try expect(equals(u8, result, ""));
}

const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const startsWith = std.mem.startsWith;

pub fn nextTry(payload: []const u8) ![]const u8 {
    return if (startsWith(u8, payload, "try"))
        return payload[3..]
    else
        error.Invalid;
}

test "next try (1)" {
    try expect(equals(u8, try nextTry("try"), ""));
}

test "next try (2)" {
    try expect(equals(u8, try nextTry("tryasd"), "asd"));
}

test "next try (3)" {
    const result = nextTry(" tryqwerty") catch "";
    try expect(equals(u8, result, ""));
}

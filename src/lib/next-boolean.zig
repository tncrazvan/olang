const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const startsWith = std.mem.startsWith;

const Boolean = struct { value: []const u8, next: []const u8 };

pub fn nextBoolean(payload: []const u8) !Boolean {
    return if (startsWith(u8, payload, "true")) {
        return Boolean{ .value = payload[0..4], .next = payload[4..] };
    } else if (startsWith(u8, payload, "false")) {
        return Boolean{ .value = payload[0..5], .next = payload[5..] };
    } else {
        return error.Invalid;
    };
}

test "next boolean (1)" {
    const result = try nextBoolean("true");
    try expect(equals(u8, result.value, "true"));
    try expect(equals(u8, result.next, ""));
}

test "next boolean (2)" {
    const result = try nextBoolean("false");
    try expect(equals(u8, result.value, "false"));
    try expect(equals(u8, result.next, ""));
}

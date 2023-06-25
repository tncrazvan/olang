const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const startsWith = std.mem.startsWith;

const Boolean = struct { value: []const u8, next: []const u8 };

pub fn nextOr(payload: []const u8) ![]const u8 {
    return if (startsWith(u8, payload, "or")) {
        return payload[4..];
    } else {
        return error.Invalid;
    };
}

test "next or (1)" {
    const result = try nextOr("or true");
    try expect(equals(u8, result, " true"));
}

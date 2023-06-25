const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const startsWith = std.mem.startsWith;

const Boolean = struct { value: []const u8, next: []const u8 };

pub fn nextAnd(payload: []const u8) ![]const u8 {
    return if (startsWith(u8, payload, "and")) {
        return payload[4..];
    } else {
        return error.Invalid;
    };
}

test "next and (1)" {
    const result = try nextAnd("and true");
    try expect(equals(u8, result, " true"));
}

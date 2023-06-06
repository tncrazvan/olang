const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

const Boolean = struct { payload: []const u8 };

pub fn asBoolean(payload: []const u8) !Boolean {
    return if (std.mem.eql(u8, payload, "true") or std.mem.eql(u8, payload, "false")) Boolean{ .payload = payload } else error.Invalid;
}

test "as-boolean true" {
    const result = try asBoolean("true");
    try expect(equals(u8, result.payload, "true"));
}

test "as-boolean false" {
    const result = try asBoolean("false");
    try expect(equals(u8, result.payload, "false"));
}

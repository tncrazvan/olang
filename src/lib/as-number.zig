const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

const Number = struct { payload: []const u8 };

pub fn asNumber(payload: []const u8) !Number {
    for (payload) |char| {
        if (!std.ascii.isDigit(char)) {
            return error.Invalid;
        }
    }
    return Number{ .payload = payload };
}

test "as-number" {
    const result = try asNumber("12345");
    try expect(equals(u8, result.payload, "12345"));
}

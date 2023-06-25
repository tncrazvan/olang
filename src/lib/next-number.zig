const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

const Number = struct { value: []const u8, next: []const u8 };

pub fn nextNumber(payload: []const u8) !Number {
    var end: u64 = 0;
    for (payload, 1..) |char, index| {
        if (!std.ascii.isDigit(char)) {
            if (end > 0) {
                return Number{ .value = payload[0..end], .next = payload[end..] };
            }
            return error.Invalid;
        } else {
            end = index;
        }
    }

    return Number{ .value = payload[0..end], .next = payload[end..] };
}

test "next number (1)" {
    const result = try nextNumber("12345");
    try expect(equals(u8, result.value, "12345"));
    try expect(equals(u8, result.next, ""));
}

test "next number (2)" {
    const result = try nextNumber("12345 and");
    try expect(equals(u8, result.value, "12345"));
    try expect(equals(u8, result.next, " and"));
}

test "next number (3)" {
    const result = nextNumber("and 12345") catch Number{ .value = "", .next = "" };
    try expect(equals(u8, result.value, ""));
    try expect(equals(u8, result.next, ""));
}

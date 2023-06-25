const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const charToSlice = @import("./utilities/string.zig").charToSlice;

const String = struct { value: []const u8, next: []const u8 };

/// Note that strings are represented as: string[N]
pub fn nextReferToString(payload: []const u8) !String {
    if (payload.len < 9) {
        return error.Invalid;
    }

    const start_expected = "string[";
    const end_expected = ']';

    for (payload[0..6], 0..) |char, index| {
        if (start_expected[index] != char) {
            return error.Invalid;
        }
    }

    for (payload[7..], 7..) |char, index| {
        if (char == end_expected) {
            if (index == 0) {
                return error.Invalid;
            }

            return String{ .value = payload[7..index], .next = payload[index + 1 ..] };
        }

        if (!std.ascii.isDigit(char)) {
            return error.Invalid;
        }
    }

    return error.Invalid;
}

test "next refer to string (1)" {
    const result = try nextReferToString("string[4]");
    try expect(equals(u8, result.value, "4"));
    try expect(equals(u8, result.next, ""));
}

test "next refer to string (2)" {
    const result = try nextReferToString("string[4]]");
    try expect(equals(u8, result.value, "4"));
    try expect(equals(u8, result.next, "]"));
}

test "next refer to string (3)" {
    const result = nextReferToString("string 4") catch String{ .value = "", .next = "" };
    try expect(equals(u8, result.value, ""));
}

test "next refer to string (4)" {
    const result = nextReferToString("string[4 ]") catch String{ .value = "", .next = "" };
    try expect(equals(u8, result.value, ""));
}

test "next refer to string (5)" {
    const result = nextReferToString("string[ 4]") catch String{ .value = "", .next = "" };
    try expect(equals(u8, result.value, ""));
}

test "next refer to string (6)" {
    const result = try nextReferToString("string[44]");
    try expect(equals(u8, result.value, "44"));
}

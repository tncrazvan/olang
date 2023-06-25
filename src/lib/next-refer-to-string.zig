const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const charToSlice = @import("./utilities/string.zig").charToSlice;

const String = struct { payload: []const u8 };

/// Note that strings are represented as: string[N]
pub fn referToString(payload: []const u8) !String {
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
            if (index + 1 < payload.len) {
                return error.Invalid;
            }
            return String{ .payload = payload[7..index] };
        }

        if (!std.ascii.isDigit(char)) {
            return error.Invalid;
        }
    }

    return error.Invalid;
}

test "as-string (1)" {
    const result = try referToString("string[4]");
    try expect(equals(u8, result.payload, "4"));
}

test "as-string (2)" {
    const result = referToString("string[4]]") catch String{ .payload = "" };
    try expect(equals(u8, result.payload, ""));
}

test "as-string (3)" {
    const result = referToString("string 4") catch String{ .payload = "" };
    try expect(equals(u8, result.payload, ""));
}

test "as-string (4)" {
    const result = referToString("string[4 ]") catch String{ .payload = "" };
    try expect(equals(u8, result.payload, ""));
}

test "as-string (5)" {
    const result = referToString("string[ 4]") catch String{ .payload = "" };
    try expect(equals(u8, result.payload, ""));
}

test "as-string (6)" {
    const result = referToString("string[44]") catch String{ .payload = "" };
    try expect(equals(u8, result.payload, "44"));
}

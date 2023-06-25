const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

const Name = struct { value: []const u8, next: []const u8 };
const first_in_name: []const u8 = "qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM";
const in_name: []const u8 = "qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM1234567890";
const in_name_exceptions: [8][]const u8 = .{
    "and",
    "or",
    "struct",
    "fn",
    "const",
    "var",
    "pub",
    "comptime",
};

fn characterIsAllowedAsFirstInName(char: u8) bool {
    for (first_in_name) |value| {
        if (value == char) {
            return true;
        }
    }
    return false;
}

fn characterIsAllowedInName(char: u8) bool {
    for (in_name) |value| {
        if (value == char) {
            return true;
        }
    }
    return false;
}

fn nameIsAnException(name: []const u8) bool {
    for (in_name_exceptions) |value| {
        if (equals(u8, value, name)) {
            return true;
        }
    }
    return false;
}

pub fn nextName(payload: []const u8) !Name {
    if (payload.len == 0) return error.Invalid;
    var end: u64 = 0;
    for (payload, 1..) |char, index| {
        if (index == 1 and !characterIsAllowedAsFirstInName(char)) {
            return error.Invalid;
        } else if (!characterIsAllowedInName(char)) {
            if (end > 0) {
                const value = payload[0..end];
                if (nameIsAnException(value)) {
                    return error.Invalid;
                }
                return Name{ .value = value, .next = payload[end..] };
            }
            return error.Invalid;
        } else {
            end = index;
        }
    }
    const value = payload[0..end];
    if (nameIsAnException(value)) {
        return error.Invalid;
    }
    return Name{ .value = value, .next = payload[end..] };
}

test "next name (1)" {
    const result = try nextName("myvar");
    try expect(equals(u8, result.value, "myvar"));
    try expect(equals(u8, result.next, ""));
}

test "next name (2)" {
    const result = try nextName("myvar and");
    try expect(equals(u8, result.value, "myvar"));
    try expect(equals(u8, result.next, " and"));
}

test "next name (3)" {
    // "and" is not be a valid name
    const result = nextName("and myvar") catch Name{ .value = "", .next = "" };
    try expect(equals(u8, result.value, ""));
    try expect(equals(u8, result.next, ""));
}

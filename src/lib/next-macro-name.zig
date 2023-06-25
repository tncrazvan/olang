const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

const MacoName = struct { value: []const u8, next: []const u8 };
const first_in_macro_name: []const u8 = "qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM";
const in_macro_name: []const u8 = "qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM1234567890";

fn characterIsAllowedAsFirstInMacroName(char: u8) bool {
    for (first_in_macro_name) |value| {
        if (value == char) {
            return true;
        }
    }
    return false;
}

fn characterIsAllowedInMacroName(char: u8) bool {
    for (in_macro_name) |value| {
        if (value == char) {
            return true;
        }
    }
    return false;
}

pub fn nextMacroName(payload: []const u8) !MacoName {
    if (payload.len == 1 or payload[0] != '@') return error.Invalid;
    var end: u64 = 0;
    for (payload, 1..) |char, index| {
        if (char == '@') {
            continue;
        }
        if (index == 2 and !characterIsAllowedAsFirstInMacroName(char)) {
            return error.Invalid;
        } else if (!characterIsAllowedInMacroName(char)) {
            if (end > 0) {
                const value = payload[0..end];
                return MacoName{ .value = value, .next = payload[end..] };
            }
            return error.Invalid;
        } else {
            end = index;
        }
    }
    const value = payload[0..end];
    return MacoName{ .value = value, .next = payload[end..] };
}

test "next macro name (1)" {
    const result = try nextMacroName("@myvar");
    try expect(equals(u8, result.value, "@myvar"));
    try expect(equals(u8, result.next, ""));
}

test "next macro name (2)" {
    const result = try nextMacroName("@myvar and");
    try expect(equals(u8, result.value, "@myvar"));
    try expect(equals(u8, result.next, " and"));
}

test "next macro name (3)" {
    // "and" is not be a valid name
    const result = nextMacroName("and @myvar") catch MacoName{ .value = "", .next = "" };
    try expect(equals(u8, result.value, ""));
    try expect(equals(u8, result.next, ""));
}

const std = @import("std");
const expect = std.testing.expect;
const startsWith = std.mem.startsWith;

pub fn nextAngleLeft(payload: []const u8) ![]const u8 {
    return if (startsWith(u8, payload, "<")) payload[1..] else error.Invalid;
}

test "next angle left (1)" {
    try expect(nextAngleLeft("<"));
}
test "next angle left (2)" {
    try expect(!nextAngleLeft(" <"));
}
test "next angle left (3)" {
    try expect(!nextAngleLeft("< "));
}
test "next angle left (4)" {
    try expect(!nextAngleLeft("d"));
}
test "next angle left (5)" {
    try expect(!nextAngleLeft(""));
}

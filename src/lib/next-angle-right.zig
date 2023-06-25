const std = @import("std");
const expect = std.testing.expect;
const startsWith = std.mem.startsWith;

pub fn nextAngleRight(payload: []const u8) ![]const u8 {
    return if (startsWith(u8, payload, ">")) payload[1..] else error.Invalid;
}

test "next angle right (1)" {
    try expect(nextAngleRight(">"));
}
test "next angle right (2)" {
    try expect(!nextAngleRight(" >"));
}
test "next angle right (3)" {
    try expect(!nextAngleRight("> "));
}
test "next angle right (4)" {
    try expect(!nextAngleRight("d"));
}
test "next angle right (5)" {
    try expect(!nextAngleRight(""));
}

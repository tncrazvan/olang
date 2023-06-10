const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn isSquareLeft(payload: []const u8) bool {
    return std.mem.eql(u8, payload, "[");
}

test "is square left 1" {
    try expect(isSquareLeft("["));
}
test "is square left 2" {
    try expect(!isSquareLeft(" ["));
}
test "is square left 3" {
    try expect(!isSquareLeft("] "));
}
test "is square left 4" {
    try expect(!isSquareLeft("d"));
}
test "is square left 5" {
    try expect(!isSquareLeft(""));
}

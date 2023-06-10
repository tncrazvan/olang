const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn isCurlyLeft(payload: []const u8) bool {
    return std.mem.eql(u8, payload, "{");
}

test "is curly left 1" {
    try expect(isCurlyLeft("{"));
}
test "is curly left 2" {
    try expect(!isCurlyLeft(" {"));
}
test "is curly left 3" {
    try expect(!isCurlyLeft("{ "));
}
test "is curly left 4" {
    try expect(!isCurlyLeft("d"));
}
test "is curly left 5" {
    try expect(!isCurlyLeft(""));
}

const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn isAngleLeft(payload: []const u8) bool {
    return std.mem.eql(u8, payload, "<");
}

test "is angle left 1" {
    try expect(isAngleLeft("<"));
}
test "is angle left 2" {
    try expect(!isAngleLeft(" <"));
}
test "is angle left 3" {
    try expect(!isAngleLeft("< "));
}
test "is angle left 4" {
    try expect(!isAngleLeft("d"));
}
test "is angle left 5" {
    try expect(!isAngleLeft(""));
}

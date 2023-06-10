const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn isAngleRight(payload: []const u8) bool {
    return std.mem.eql(u8, payload, ">");
}

test "is angle right 1" {
    try expect(isAngleRight(">"));
}
test "is angle right 2" {
    try expect(!isAngleRight(" >"));
}
test "is angle right 3" {
    try expect(!isAngleRight("> "));
}
test "is angle right 4" {
    try expect(!isAngleRight("d"));
}
test "is angle right 5" {
    try expect(!isAngleRight(""));
}

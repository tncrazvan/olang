const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn isRoundLeft(payload: []const u8) bool {
    return equals(u8, payload, "(");
}

test "is round left (1)" {
    try expect(isRoundLeft("("));
}
test "is round left (2)" {
    try expect(!isRoundLeft(" ("));
}
test "is round left (3)" {
    try expect(!isRoundLeft("( "));
}
test "is round left (4)" {
    try expect(!isRoundLeft("d"));
}
test "is round left (5)" {
    try expect(!isRoundLeft(""));
}

const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn isRoundRight(payload: []const u8) bool {
    return equals(u8, payload, ")");
}

test "is round right (1)" {
    try expect(isRoundRight(")"));
}
test "is round right (2)" {
    try expect(!isRoundRight(" )"));
}
test "is round right (3)" {
    try expect(!isRoundRight(") "));
}
test "is round right (4)" {
    try expect(!isRoundRight("d"));
}
test "is round right (5)" {
    try expect(!isRoundRight(""));
}

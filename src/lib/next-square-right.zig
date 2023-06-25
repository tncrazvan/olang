const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn isSquareRight(payload: []const u8) bool {
    return equals(u8, payload, "]");
}

test "is square right (1)" {
    try expect(isSquareRight(">"));
}
test "is square right (2)" {
    try expect(!isSquareRight(" >"));
}
test "is square right (3)" {
    try expect(!isSquareRight("> "));
}
test "is square right (4)" {
    try expect(!isSquareRight("d"));
}
test "is square right (5)" {
    try expect(!isSquareRight(""));
}

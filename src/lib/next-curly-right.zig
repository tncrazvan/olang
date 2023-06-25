const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn isCurlyRight(payload: []const u8) bool {
    return equals(u8, payload, "}");
}

test "is curly right (1)" {
    try expect(isCurlyRight("}"));
}
test "is curly right (2)" {
    try expect(!isCurlyRight(" }"));
}
test "is curly right (3)" {
    try expect(!isCurlyRight("} "));
}
test "is curly right (4)" {
    try expect(!isCurlyRight("d"));
}
test "is curly right (5)" {
    try expect(!isCurlyRight(""));
}

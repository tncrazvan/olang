const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

pub fn isQuote(payload: []const u8) bool {
    return std.mem.eql(u8, payload, "\"");
}

test "is quote 1" {
    try expect(isQuote("\""));
}
test "is quote 2" {
    try expect(!isQuote(" \""));
}
test "is quote 3" {
    try expect(!isQuote("\" "));
}
test "is quote 4" {
    try expect(!isQuote("?"));
}

const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

const Boolean = struct { payload: []const u8 };

pub fn isTry(payload: []const u8) bool {
    return (equals(u8, payload, "try"));
}

test "is-try (1)" {
    try expect(isTry("try"));
}

test "is-try (2)" {
    try expect(!isTry(" try"));
}

test "is-try (3)" {
    try expect(!isTry("try "));
}

test "is-try (4)" {
    try expect(!isTry(" try "));
}

test "is-try (5)" {
    try expect(!isTry("qwerty"));
}

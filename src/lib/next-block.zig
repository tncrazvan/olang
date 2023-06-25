const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

const Block = struct { value: []const u8, next: []const u8 };

pub fn nextBlock(payload: []const u8) !Block {
    if (payload.len < 2) return error.Invalid;

    var opened: u8 = 0;
    var closed: u8 = 0;

    var end: u64 = 0;

    if (payload[0] != '{') {
        return error.Invalid;
    }

    for (payload, 0..) |char, index| {
        if (char == '{') {
            const delta = opened - closed;
            if (delta > 1 or delta < 0) {
                return error.Invalid;
            }
            opened += 1;
        } else if (char == '}') {
            const delta = opened - closed;
            if (delta > 1 or delta < 0) {
                return error.Invalid;
            }

            closed += 1;

            if (opened == closed) {
                end = index;
                break;
            }
        }
    }

    const delta = opened - closed;

    return if (delta != 0) {
        return error.Invalid;
    } else {
        const value = if (end < 1) "" else payload[1..end];

        const next = if (end == payload.len - 2)
            ""
        else
            payload[end + 1 ..];

        return Block{ .value = value, .next = next };
    };
}

test "next block (1)" {
    const block = try nextBlock("{}");
    try expect(equals(u8, block.value, ""));
    try expect(equals(u8, block.next, ""));
}

test "next block (2)" {
    const block = try nextBlock("{ this is content} qwerqwrweqqwe");
    try expect(equals(u8, block.value, " this is content"));
    try expect(equals(u8, block.next, " qwerqwrweqqwe"));
}

test "next block (3)" {
    const block = nextBlock("{") catch Block{ .next = "", .value = "" };
    try expect(equals(u8, block.value, ""));
    try expect(equals(u8, block.next, ""));
}

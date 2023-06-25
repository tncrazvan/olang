const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;

const Group = struct { value: []const u8, next: []const u8 };

pub fn nextGroup(payload: []const u8) !Group {
    if (payload.len < 2) return error.Invalid;

    var opened: u8 = 0;
    var closed: u8 = 0;

    var end: u64 = 0;

    if (payload[0] != '(') {
        return error.Invalid;
    }

    for (payload, 0..) |char, index| {
        if (char == '(') {
            const delta = opened - closed;
            if (delta > 1 or delta < 0) {
                return error.Invalid;
            }
            opened += 1;
        } else if (char == ')') {
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

        return Group{ .value = value, .next = next };
    };
}

test "next group (1)" {
    const group = try nextGroup("()");
    try expect(equals(u8, group.value, ""));
    try expect(equals(u8, group.next, ""));
}

test "next group (2)" {
    const group = try nextGroup("( this is content) qwerqwrweqqwe");
    try expect(equals(u8, group.value, " this is content"));
    try expect(equals(u8, group.next, " qwerqwrweqqwe"));
}

test "next group (3)" {
    const group = nextGroup("(") catch Group{ .next = "", .value = "" };
    try expect(equals(u8, group.value, ""));
    try expect(equals(u8, group.next, ""));
}

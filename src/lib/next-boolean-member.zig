const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const nextBoolean = @import("./next-boolean.zig").nextBoolean;
const nextAnd = @import("./next-and.zig").nextAnd;
const nextOr = @import("./next-or.zig").nextOr;

const BooleanMember = struct {
    left: []const u8,
    right: []const u8,
    next: []const u8,
};

pub fn nextBooleanMember(payload: []const u8) !BooleanMember {
    const resultNextLeftBoolean = try nextBoolean(payload);
    // FIXME: fix this trim
    const next = std.mem.trimLeft(u8, resultNextLeftBoolean.next, .{std.ascii.whitespace});
    const resultNextBoolean = nextAnd(next) catch nextOr(next) catch {
        return BooleanMember{
            .left = resultNextLeftBoolean.value,
            .right = "",
            .next = resultNextLeftBoolean.next,
        };
    };

    const resultNextRightBoolean = try nextBoolean(std.mem.trimLeft(resultNextBoolean));

    return BooleanMember{
        .left = resultNextLeftBoolean.value,
        .right = resultNextRightBoolean.value,
        .next = resultNextRightBoolean.next,
    };
}

test "text boolean member (1)" {
    const booleanMember = nextBooleanMember("");
    _ = booleanMember;
}

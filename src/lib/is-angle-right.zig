const std = @import("std");

pub fn isAngleRight(payload: []const u8) bool {
    return std.mem.eql(u8, payload, ">");
}

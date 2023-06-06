const std = @import("std");

pub fn isQuote(payload: []const u8) bool {
    return std.mem.eql(u8, payload, "\"");
}

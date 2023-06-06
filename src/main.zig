const std = @import("std");
const equals = std.mem.eql;
const asString = @import("./lib/as-string.zig").asString;

pub fn main() !void {
    const risultato = try asString("string[1]");
    std.log.info("{s}", .{risultato.payload});
}

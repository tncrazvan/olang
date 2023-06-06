const std = @import("std");

/// Format a string.
pub fn format(comptime string: []const u8, args: anytype) ![]const u8 {
    const list = std.ArrayList(u8).init(std.heap.page_allocator);
    defer list.deinit();
    const allocator = list.allocator;
    const result = try std.fmt.allocPrint(
        allocator,
        string,
        args,
    );

    return result;
}

/// Convert an `u8` to a `[]u8`
pub fn charToSlice(c: u8) []u8 {
    return &[_]u8{c};
}

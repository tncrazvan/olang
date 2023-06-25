const std = @import("std");
const expect = std.testing.expect;
const equals = std.mem.eql;
const nextPropertySeparator = @import("./next-property-separator.zig").nextPropertySeparator;
const nextName = @import("./next-name.zig").nextName;

const Property = struct { value: []const u8, next: []const u8 };

pub fn nextProperty(payload: []const u8) !Property {
    const next = try nextPropertySeparator(payload);
    const name = try nextName(next);

    return Property{
        .value = name.value,
        .next = name.next,
    };
}

test "property (1)" {
    const property = try nextProperty(".myprop");
    try expect(equals(u8, property.value, "myprop"));
    try expect(equals(u8, property.next, ""));
}

test "property (2)" {
    const property = try nextProperty(".myprop =");
    try expect(equals(u8, property.value, "myprop"));
    try expect(equals(u8, property.next, " ="));
}

test "property (3)" {
    const property = nextProperty(" .myprop") catch Property{ .value = "", .next = "" };
    try expect(equals(u8, property.value, ""));
    try expect(equals(u8, property.next, ""));
}

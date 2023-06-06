# Olang

A WASI frontend written in Zig (inspired by Zig).

See [./olang.spec](./olang.spec) for the syntax specification.

A showcase of the syntax:

```zig
const User = struct {
    email:[]u8,
    created:u32,
    updated:u32,
};

const @print = comptime {
    const stdout = @import("std").out
    const write = stdout.stream.write

    return |value:[]u8| !void {
        for(value) |byte| {
            try write(byte)
        }
    }
};

fn log(value:[]u8) !void {
    try @print([...value, @char("\n")])
}

pub fn main(args:[]u8) !void {

    // this is a comment
    const user = User {

    };
    try log(@string("hello {}", [user.email]))
}
```

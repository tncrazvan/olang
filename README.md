# Olang

A WASI frontend written in Zig (inspired by Zig).

See [./olang.spec](./olang.spec) for the syntax specification.

A showcase of the syntax:

```zig
@print = comptime {
    const stdout = @import("std").out
    const write = stdout.stream.write

    return |value:[]u8| !void {
        try write(value)
    }
}

fn log(value:[]u8) !void {
    try @print([...value, @char("\n")])
}

pub fn main(args:[]u8) !void {
    try log(@string("hello world"))
}
```

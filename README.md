# Olang

A WASI frontend written in Zig (inspired by Zig).

See [./olang.spec](./olang.spec) for the syntax specification.

A showcase of the syntax:

```zig
@print = comptime {
    const stdout = @import("std").out
    const write = stdout.stream.write

    return fn _(value) !void {
        try write(value)
    }
}

fn log(value []char) !void {
    try @print([...value, ..."\n"])
}

pub fn main(args []char) !void {
    try log("hello world")
}
```

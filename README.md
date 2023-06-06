# Olang

A WASI frontend written in Zig.

See [./olang.spec](./olang.spec) for the syntax specification.

A showcase of the syntax:

```
@print = comptime {
    const stdout = @import("std").out
    const write = stdout.stream.write

    return fn(value) use(write) {
        write(value)
    }
}

fn log(value []char) void {
    @print([...value, ..."\n"])
}

pub fn main(args []char) void {
    log("hello world")
}
```
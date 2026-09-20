const std = @import("std");

pub fn main() !void {
    const message = "Hello, world!";
    try std.io.getStdOut().writer().print("{s}\n", .{message});
}

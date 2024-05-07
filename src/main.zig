const std = @import("std");

extern fn jsPrintText(source: [*]const u8, len: c_uint, x: c_uint, y: c_uint) void;
extern fn jsStrokeRect(x: c_uint, y: c_uint, width: c_uint, height: c_uint) void;

fn printText(text: []const u8, x: u32, y: u32) void {
    jsPrintText(text.ptr, text.len, x, y);
}

const State = struct {
    width: u32,
    height: u32,
};

var state: State = .{ .width = 0, .height = 0 };

export fn onInit() void {
    jsStrokeRect(0, 0, state.width, state.height);
    printText("Hello World!", state.width / 2, state.height / 2);
}

export fn onResize(width: c_uint, height: c_uint) void {
    state = .{ .width = width, .height = height };
    onInit();
}

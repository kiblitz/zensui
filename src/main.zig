const std = @import("std");
const js = @import("js_bindings.zig");

const State = struct {
    width: u32,
    height: u32,
};

var state: State = .{ .width = 0, .height = 0 };

fn drawScreen() void {
    js.strokeRect(0, 0, state.width, state.height);

    // clockwise arc
    js.beginPath();
    js.arcClockwise(state.width / 2, state.height / 2, @as(f32, @floatFromInt(state.width / 4)), 0.0, 1.57);
    js.stroke();

    // counterclockwise arc
    js.beginPath();
    js.arcCounterClockwise(state.width / 2, state.height / 2, @as(f32, @floatFromInt(state.width / 3)), 0.0, 3.14);
    js.stroke();

    // manual arc
    js.beginPath();
    js.moveTo(state.width / 4, state.height / 2);
    js.arcTo(state.width / 2, state.height / 4, state.width * 3 / 4, state.height / 2, @as(f32, @floatFromInt(state.width / 6)));
    js.stroke();

    // bezier curve
    js.beginPath();
    js.moveTo(0, 0);
    js.bezierCurveTo(state.width, 0, state.width / 2, state.width / 2, state.width, state.height);
    js.stroke();

    js.printText("Hello World!", state.width / 2, state.height / 2);

    js.clearRect(state.width * 3 / 4, 0, state.width / 64, state.height);
}

export fn onInit() void {
    js.alert("Initialized!");
    js.setFont("60px serif");
    drawScreen();
}

export fn onResize(width: c_uint, height: c_uint) void {
    state = .{ .width = width, .height = height };
    drawScreen();
}

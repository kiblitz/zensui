const std = @import("std");

extern fn jsAlert(msg: [*]const u8, len: c_uint) void;
extern fn jsArc(x: c_uint, y: c_uint, r: f32, start_angle: f32, end_angle: f32, counter_clockwise: bool) void;
extern fn jsArcTo(x1: c_uint, y1: c_uint, x2: c_uint, y2: c_uint, r: f32) void;
extern fn jsBeginPath() void;
extern fn jsBezierCurveTo(cx1: c_uint, cy1: c_uint, cx2: c_uint, cy2: c_uint, x: c_uint, y: c_uint) void;
extern fn jsClearRect(x: c_uint, y: c_uint, width: c_uint, height: c_uint) void;
extern fn jsFill() void;
extern fn jsMoveTo(x: c_uint, y: c_uint) void;
extern fn jsPrintText(text: [*]const u8, text_len: c_uint, x: c_uint, y: c_uint) void;
extern fn jsSetFont(font: [*]const u8, font_len: c_uint) void;
extern fn jsStroke() void;
extern fn jsStrokeRect(x: c_uint, y: c_uint, width: c_uint, height: c_uint) void;

fn alert(text: []const u8) void {
    jsAlert(text.ptr, text.len);
}

fn arcClockwise(x: u32, y: u32, r: f32, start_angle: f32, end_angle: f32) void {
    jsArc(x, y, r, start_angle, end_angle, false);
}

fn arcCounterClockwise(x: u32, y: u32, r: f32, start_angle: f32, end_angle: f32) void {
    jsArc(x, y, r, start_angle, end_angle, true);
}

fn arcTo(x1: u32, y1: u32, x2: u32, y2: u32, r: f32) void {
    jsArcTo(x1, y1, x2, y2, r);
}

fn beginPath() void {
    jsBeginPath();
}

fn bezierCurveTo(cx1: u32, cy1: u32, cx2: u32, cy2: u32, x: u32, y: u32) void {
    jsBezierCurveTo(cx1, cy1, cx2, cy2, x, y);
}

fn clearRect(x: u32, y: u32, width: u32, height: u32) void {
    jsClearRect(x, y, width, height);
}

fn fill() void {
    jsFill();
}

fn moveTo(x: u32, y: u32) void {
    jsMoveTo(x, y);
}

fn printText(text: []const u8, x: u32, y: u32) void {
    jsPrintText(text.ptr, text.len, x, y);
}

fn setFont(font: []const u8) void {
    jsSetFont(font.ptr, font.len);
}

fn stroke() void {
    jsStroke();
}

fn strokeRect(x: u32, y: u32, width: u32, height: u32) void {
    jsStrokeRect(x, y, width, height);
}

const State = struct {
    width: u32,
    height: u32,
};

var state: State = .{ .width = 0, .height = 0 };

fn drawScreen() void {
    jsStrokeRect(0, 0, state.width, state.height);

    // clockwise arc
    beginPath();
    arcClockwise(state.width / 2, state.height / 2, @as(f32, @floatFromInt(state.width / 4)), 0.0, 1.57);
    stroke();

    // counterclockwise arc
    beginPath();
    arcCounterClockwise(state.width / 2, state.height / 2, @as(f32, @floatFromInt(state.width / 3)), 0.0, 3.14);
    stroke();

    // manual arc
    beginPath();
    moveTo(state.width / 4, state.height / 2);
    arcTo(state.width / 2, state.height / 4, state.width * 3 / 4, state.height / 2, @as(f32, @floatFromInt(state.width / 6)));
    stroke();

    // bezier curve
    beginPath();
    moveTo(0, 0);
    bezierCurveTo(state.width, 0, state.width / 2, state.width / 2, state.width, state.height);
    stroke();

    printText("Hello World!", state.width / 2, state.height / 2);

    clearRect(state.width * 3 / 4, 0, state.width / 64, state.height);
}

export fn onInit() void {
    alert("Initialized!");
    setFont("60px serif");
    drawScreen();
}

export fn onResize(width: c_uint, height: c_uint) void {
    state = .{ .width = width, .height = height };
    drawScreen();
}

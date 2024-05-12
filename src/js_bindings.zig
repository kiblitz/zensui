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

pub fn alert(text: []const u8) void {
    jsAlert(text.ptr, text.len);
}

pub fn arcClockwise(x: u32, y: u32, r: f32, start_angle: f32, end_angle: f32) void {
    jsArc(x, y, r, start_angle, end_angle, false);
}

pub fn arcCounterClockwise(x: u32, y: u32, r: f32, start_angle: f32, end_angle: f32) void {
    jsArc(x, y, r, start_angle, end_angle, true);
}

pub fn arcTo(x1: u32, y1: u32, x2: u32, y2: u32, r: f32) void {
    jsArcTo(x1, y1, x2, y2, r);
}

pub fn beginPath() void {
    jsBeginPath();
}

pub fn bezierCurveTo(cx1: u32, cy1: u32, cx2: u32, cy2: u32, x: u32, y: u32) void {
    jsBezierCurveTo(cx1, cy1, cx2, cy2, x, y);
}

pub fn clearRect(x: u32, y: u32, width: u32, height: u32) void {
    jsClearRect(x, y, width, height);
}

pub fn fill() void {
    jsFill();
}

pub fn moveTo(x: u32, y: u32) void {
    jsMoveTo(x, y);
}

pub fn printText(text: []const u8, x: u32, y: u32) void {
    jsPrintText(text.ptr, text.len, x, y);
}

pub fn setFont(font: []const u8) void {
    jsSetFont(font.ptr, font.len);
}

pub fn stroke() void {
    jsStroke();
}

pub fn strokeRect(x: u32, y: u32, width: u32, height: u32) void {
    jsStrokeRect(x, y, width, height);
}

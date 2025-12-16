module main (
    input sys_clk,              //clk input
    output wire hsync,           //hsync
    output wire vsync,            //vsync
    output wire red,
    output wire green,
    output wire blue
);


wire [10:0] x;
wire [10:0] y;
reg [7:0] frame = 0;

localparam [10:0] width = 1200;
//localparam [10:0] width = 540;
localparam [10:0] height = 600;

localparam [10:0] rect_xstart = 10'd200;
localparam [10:0] rect_xend = 10'd500;
localparam [9:0] rect_ystart = 10'd200;
localparam [9:0] rect_yend = 10'd400;

wire square = (x > rect_xstart & x < rect_xend) & (y > rect_ystart & y < rect_yend);
wire out = (x >= width) | (y >= height);

assign red = square;
assign green = !square & !out;
assign blue = !square & !out;

//wire clk = sys_clk;
//vga_800x600_60hz #(.MUL(675), .DIV(1000)) vga_27mhz(.clk(sys_clk), .hsync(hsync), .vsync(vsync), .x(x), .y(y));

wire clk;
Gowin_rPLL_60mhz ppl(.clkout(clk), .clkin(sys_clk));
vga_800x600_60hz #(.MUL(3), .DIV(2)) vga_60mhz(.clk(clk), .hsync(hsync), .vsync(vsync), .x(x), .y(y));

endmodule
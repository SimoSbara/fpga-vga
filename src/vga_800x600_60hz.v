module vga_800x600_60hz 
#(parameter MUL = 1,
    parameter DIV = 1)
(
    input clk,
    output wire hsync,
    output wire vsync,
    output reg[10:0] x,
    output reg[10:0] y
);

localparam [10:0] width = 800 * MUL / DIV;
localparam [10:0] frame_cols = 1056 * MUL / DIV;
localparam [10:0] hsync_start = 840 * MUL / DIV;
localparam [10:0] hsync_end = 968 * MUL / DIV;

localparam [9:0] height = 600;
localparam [9:0] frame_rows = 628;
localparam [9:0] vsync_start = 601;
localparam [9:0] vsync_end = 605;

assign hsync = (x <= hsync_start) | (x >= hsync_end);
assign vsync = (y <= vsync_start) | (y >= vsync_end);

always @(posedge clk) begin
    if (x == frame_cols) begin
        x <= 0;
        y <= y + 1;
        if(y == frame_rows) begin
            y <= 0;
            //frame <= frame + 1;
        end
    end
    else
        x <= x + 1;
end

endmodule
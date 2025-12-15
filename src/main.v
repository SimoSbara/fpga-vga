module main (
    input sys_clk,              //clk input
    output wire hsync,           //hsync
    output wire vsync,            //vsync
    output wire red,
    output wire green,
    output wire blue
);

reg [9:0] line_counter = 0;
reg [9:0] lines = 0;

localparam [9:0] width = 10'd540;
localparam [9:0] height = 10'd600;
localparam [9:0] h1 = 10'd200;
localparam [9:0] h2 = 10'd400;
localparam [9:0] h3 = height;

assign hsync = (line_counter < 10'd567) | (line_counter > 10'd653);
assign vsync = (lines < 10'd601) | (lines > 10'd605);
assign red = (lines < h1) & (line_counter < width);
assign green = (lines >= h1 & lines < h2) & (line_counter < width);
assign blue = (lines >= h2 & lines < h3) & (line_counter < width);

always @(posedge sys_clk) begin
    if (line_counter == 10'd712) begin
        line_counter <= 0;
        lines <= lines + 1;
        if(lines == 10'd628)
            lines <= 0;
    end
    else
        line_counter <= line_counter + 1;
end


endmodule
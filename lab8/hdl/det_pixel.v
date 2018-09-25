module det_pixel(clk, zoom, col, row, out_of_range, special, mem_color, red, green, blue, address);

input clk;
input [1:0] zoom;
input [9:0] col;
input [8:0] row;
input out_of_range;
input special;
input [11:0] mem_color;

output [3:0] red;
output [3:0] blue;
output [3:0] green;
output [13:0] address; //16,384 words = 14 bits

reg [3:0] red;
reg [3:0] blue;
reg [3:0] green;
reg [11:0] pixel_buffer, pixel_buffer_c;
reg [9:0] col_r;
reg [8:0] row_r;
reg [13:0] address;

always @(*) begin
    pixel_buffer_c = mem_color;
    address = {14{1'bx}};

    if(col == {10{1'bx}} && row == {9{1'bx}}) begin
        red = 4'h0;
        green = 4'h0;
        blue = 4'h0;
    end
    else begin
         if(col == col_r && row == row_r) begin //reuse pixel
            red = pixel_buffer[11:8];
            green = pixel_buffer[7:4];
            blue = pixel_buffer[3:0];

            pixel_buffer_c = pixel_buffer;
        end
        else begin //get new pixel 
            address = (row * 128) + col;

            red = mem_color[11:8];
            green = mem_color [7:4];
            blue = mem_color [3:0];
        end
    end 

    if(out_of_range == 1 && special == 0) begin
        red = 4'h0;
        green = 4'h0;
        blue = 4'h0;
    end
end

//FF
always @(posedge clk) begin
    pixel_buffer <= #1 pixel_buffer_c;
    col_r <= #1 col;
    row_r <= #1 row;
end

endmodule
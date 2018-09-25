module conv_coord(zoom, col, row, new_col, new_row, out_of_range);

input [1:0] zoom;
input  [9:0]  col;
input  [8:0]  row;

output [9:0] new_col;
output [8:0] new_row;
output out_of_range;

reg [9:0] new_col; //640 max
reg [8:0] new_row; //480 max
reg out_of_range;

always @(*) begin
    new_col = {10{1'bx}};
    new_row = {9{1'bx}};
    out_of_range = 1;
    case(zoom)
        2'b00: begin //no zoom 128*128
            if(row < 9'd128 && col < 10'd128) begin
                new_col = col;
                new_row = row;
                out_of_range = 0;
            end
        end
        2'b01: begin //2x zoom 256*256
            if(row < 9'd256 && col < 10'd256) begin
                new_col = col/2;
                new_row = row/2;
                out_of_range = 0;
            end
        end
        2'b10: begin //3x zoom 384*384
            if(row < 9'd384 && col < 10'd384) begin
                new_col = col/3;
                new_row = row/3;
                out_of_range = 0;
            end
        end
        2'b11: begin //4x zoom 512*480 (col*row)
            if(row < 9'd480 && col < 10'd512) begin
                new_col = col/4;
                new_row = row/4;
                out_of_range = 0;
            end
        end
    endcase
end

endmodule
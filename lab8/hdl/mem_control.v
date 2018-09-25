module mem_control(clk, rd_addr, rd_data);

input clk;
input [13:0] rd_addr;
output [11:0] rd_data;

reg [11:0] rd_data;


//multiplexer 16 to 1
wire [3:0] rd_data_0r, rd_data_1r, rd_data_2r, rd_data_3r;
wire [3:0] rd_data_0g, rd_data_1g, rd_data_2g, rd_data_3g;
wire [3:0] rd_data_0b, rd_data_1b, rd_data_2b, rd_data_3b;
always @(*) begin
    case(rd_addr[13:12])
        4'd00: begin rd_data = {rd_data_0r, rd_data_0g, rd_data_0b}; end
        4'd01: begin rd_data = {rd_data_1r, rd_data_1g, rd_data_1b}; end
        4'd02: begin rd_data = {rd_data_2r, rd_data_2g, rd_data_2b}; end
        4'd03: begin rd_data = {rd_data_3r, rd_data_3g, rd_data_3b}; end
        default: begin rd_data = {11{1'bx}}; end
    endcase
end
//end multiplexer

//red
rom_0r rom_0r(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_0r)
);
rom_1r rom_1r(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_1r)
);
rom_2r rom_2r(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_2r)
);
rom_3r rom_3r(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_3r)
);
//end red

//green
rom_0g rom_0g(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_0g)
);
rom_1g rom_1g(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_1g)
);
rom_2g rom_2g(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_2g)
);
rom_3g rom_3g(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_3g)
);
//end green

//blue
rom_0b rom_0b(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_0b)
);
rom_1b rom_1b(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_1b)
);
rom_2b rom_2b(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_2b)
);
rom_3b rom_3b(
    .clock(clk),
    .address(rd_addr[11:0]),
    .data_out(rd_data_3b)
);
//end blue

endmodule
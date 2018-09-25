module top (
    input MAX10_CLK1_50,

    input [1:0] KEY,

    input [9:0] SW,

    output [9:0] LEDR,

    output [7:0] HEX0,   
    output [7:0] HEX1,   
    output [7:0] HEX2,   
    output [7:0] HEX3,   
    output [7:0] HEX4,   
    output [7:0] HEX5    
);

//registers
reg [1:0] KEY_r;
reg [9:0] SW_r;

always @(posedge MAX10_CLK1_50) begin
  KEY_r[0] <= #1 KEY[0];
  KEY_r[1] <= #1 KEY[1];
  SW_r[0] <= #1 SW[0];
  SW_r[1] <= #1 SW[1];
  SW_r[2] <= #1 SW[2];
  SW_r[3] <= #1 SW[3];
  SW_r[4] <= #1 SW[4];
  SW_r[5] <= #1 SW[5];
  SW_r[6] <= #1 SW[6];
  SW_r[7] <= #1 SW[7];
  SW_r[8] <= #1 SW[8];
  SW_r[9] <= #1 SW[9];
end

wire go_w, go_10;
wire [1:0] wr_addr, rd_addr;
wire [3:0] wr_data, rd_data, rd_out;
wire wr_enable;
wire [4:0] state;
wire [7:0] HEX1_val;
wire [25:0] pulse50, pulse5;

assign pulse50 = SW[1] ? 26'b00_0000_0000_0000_0000_0000_0010 : 26'b10_1111_1010_1111_0000_1000_0000;
assign pulse5 = SW[1] ? 26'b00_0000_0000_0000_0000_0000_0010 : 26'b00_0100_1100_0100_1011_0100_0000;

//26'b10_1111_1010_1111_0000_1000_0000
//50 million
//testing
//26'b00_0000_0000_0000_0000_0000_0010
pulse pulse(
    .clock(MAX10_CLK1_50), 
    .reset(~KEY_r[0]),  
    .divideby(pulse50), 
    .go(go_w) 
);

//26'b00_0100_1100_0100_1011_0100_0000
//5 million
//testing
//26'b00_0000_0000_0000_0000_0000_0010
pulse_once pulse_10(
    .clock(MAX10_CLK1_50), 
    .reset(go_w),  
    .divideby(pulse5), 
    .go(LEDR[0]) 
);

fsm fsm(
    .enable(go_w),
    .clk(MAX10_CLK1_50), 
    .reset(~KEY_r[0]), 
    .rd_in(rd_data), 
    .rd_out(rd_out), 
    .LEDR8(LEDR[8]), 
    .LEDR9(LEDR[9]), 
    .wr_enable(wr_enable),
    .wr_addr(wr_addr), 
    .wr_data(wr_data), 
    .rd_addr(rd_addr), 
    .state(state)
);

mem mem(
    .clk(MAX10_CLK1_50),
    .wr_enable(wr_enable),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_addr(rd_addr),
    .rd_data(rd_data)
);

seg7 hex0(
    .in(rd_out),
    .out(HEX0[6:0])
);
seg7 hex1(
    .in(state[3:0]),
    .out(HEX1_val[6:0])
);
seg7 hex2(
    .in(rd_data),
    .out(HEX2[6:0])
);
seg7 hex3(
    .in({2'b00, rd_addr}),
    .out(HEX3[6:0])
);
seg7 hex4(
    .in(wr_data),
    .out(HEX4[6:0])
);
seg7 hex5(
    .in({2'b00, wr_addr}),
    .out(HEX5[6:0])
);

assign HEX0[7] = 1'b1;
//assign HEX1 = 8'hff;
assign HEX1 = SW_r[0] ? {1'b1, HEX1_val[6:0]} : 8'hff;
assign HEX2[7] = 1'b1;
assign HEX3[7] = 1'b1;
assign HEX4[7] = 1'b1;
assign HEX5[7] = 1'b1;
assign LEDR[7:1] = 7'h00;


endmodule
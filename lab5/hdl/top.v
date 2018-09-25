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
reg KEY0_r;
reg [9:0] SW_r;

always @(posedge MAX10_CLK1_50) begin
  KEY0_r <= #1 KEY[0];
  SW_r[0] <= #1 SW[0];
  SW_r[1] <= #1 SW[1];
  SW_r[2] <= #1 SW[2];
  SW_r[4] <= #1 SW[4];
  SW_r[5] <= #1 SW[5];
  SW_r[6] <= #1 SW[6];
  SW_r[7] <= #1 SW[7];
  SW_r[8] <= #1 SW[8];
  SW_r[9] <= #1 SW[9];
end

wire go_w;
wire [23:0] display;

pulse pulse(
    .clock(MAX10_CLK1_50), 
    .reset(~KEY0_r),  
    .enable(SW_r[0]), 
    .divideby(SW_r[9:4]), 
    .go(go_w), 
    .LEDR(LEDR)
);
counter counter(
    .clock(MAX10_CLK1_50), 
    .reset(~KEY0_r),  
    .enable1(SW_r[0]), 
    .enable2(go_w), 
    .updown(SW_r[1]), 
    .freerun(SW_r[2]), 
    .display(display)
);

seg7 hex0(
    .in(display[3:0]),
    .out(HEX0)
);
seg7 hex1(
    .in(display[7:4]),
    .out(HEX1)
);
seg7 hex2(
    .in(display[11:8]),
    .out(HEX2)
);
seg7 hex3(
    .in(display[15:12]),
    .out(HEX3)
);
seg7 hex4(
    .in(display[19:16]),
    .out(HEX4)
);
seg7 hex5(
    .in(display[23:20]),
    .out(HEX5)
);

assign HEX0[7] = 1'b1;
assign HEX1[7] = 1'b1;
assign HEX2[7] = 1'b1;
assign HEX3[7] = 1'b1;
assign HEX4[7] = 1'b1;
assign HEX5[7] = 1'b1;

endmodule
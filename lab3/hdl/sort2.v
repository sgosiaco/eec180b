module sort2(

	input [3:0] in0,
    input [3:0] in1,

	output [3:0] out0,
    output [3:0] out1
);


assign out0 = (in0 > in1) ? in1 : in0;
assign out1 = (in0 > in1) ? in0 : in1;


endmodule

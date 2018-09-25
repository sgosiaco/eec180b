module bubble4(

	input [3:0] in0,
    input [3:0] in1,
    input [3:0] in2,
    input [3:0] in3,

	output [3:0] out0,
    output [3:0] out1,
    output [3:0] out2,
    output [3:0] out3
);
wire [3:0] three_to_two;
wire [3:0] two_to_one;

sort2 sort_32 (in2, in3, three_to_two,out3);
sort2 sort_21 (in1, three_to_two, two_to_one, out2);
sort2 sort_10 (in0, two_to_one, out0, out1);


endmodule

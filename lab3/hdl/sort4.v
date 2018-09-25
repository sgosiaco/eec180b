module sort4(

	input [3:0] in0,
    input [3:0] in1,
    input [3:0] in2,
    input [3:0] in3,

	output [3:0] out0,
    output [3:0] out1,
    output [3:0] out2,
    output [3:0] out3
);
wire [3:0] z2o0, z2o1, z2o2, z2o3;
wire [3:0] o2t0, o2t1, o2t2, o2t3;


bubble4 bubble0 (in0, in1, in2, in3, z2o0, z2o1, z2o2, z2o3);
bubble4 bubble1 (z2o0, z2o1, z2o2, z2o3, o2t0, o2t1, o2t2, o2t3);
bubble4 bubble2 (o2t0, o2t1, o2t2, o2t3, out0, out1, out2, out3);

endmodule


//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module muxAssign(

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);



//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================
assign LEDR[0] = SW[0] ? SW[2] : SW[1];


endmodule

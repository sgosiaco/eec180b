module seg7(
    input [3:0] in,

    output [6:0] out
);

wire [2:0] MSB;
reg [3:0] LSB;


parameter ZERO =  7'b100_0000;
parameter ONE =   7'b111_1001;
parameter TWO = 7'b010_0100;
parameter THREE = 7'b011_0000;
parameter FOUR = 7'b001_1001;
parameter FIVE = 7'b001_0010;
parameter SIX = 7'b000_0010;
parameter SEVEN = 7'b111_1000;
parameter EIGHT = 7'b000_0000;
parameter NINE = 7'b001_1000;
parameter A = 7'b000_1000;
parameter B = 7'b000_0001;
parameter C = 7'b100_0110;
parameter D = 7'b010_0001;
parameter E = 7'b000_0110;
parameter F = 7'b000_1110;

always @(in) begin
    case (in)
        4'b0000: begin //zero
            LSB = ZERO[3:0];
         end
         4'b0001: begin //one
            LSB = ONE[3:0]; 
         end
         4'b0010: begin //two
            LSB = TWO[3:0]; 
         end
         4'b0011: begin //three
            LSB = THREE[3:0]; 
         end
         4'b0100: begin //four
            LSB = FOUR[3:0]; 
         end
         4'b0101: begin //five
            LSB = FIVE[3:0]; 
         end
         4'b0110: begin //six
            LSB = SIX[3:0]; 
         end
         4'b0111: begin //seven
            LSB = SEVEN[3:0]; 
         end
         4'b1000: begin //eight
            LSB = EIGHT[3:0]; 
         end
         4'b1001: begin //nine
            LSB = NINE[3:0]; 
         end
         4'b1010: begin //A
            LSB = A[3:0]; 
         end
         4'b1011: begin //B
            LSB = B[3:0]; 
         end
         4'b1100: begin //C
            LSB = C[3:0]; 
         end
         4'b1101: begin //D
            LSB = D[3:0]; 
         end
         4'b1110: begin //E
            LSB = E[3:0]; 
         end
         4'b1111: begin //F
            LSB = F[3:0];
         end
         default: begin
            LSB = ZERO[3:0];
         end    
    endcase      
end
/*
assign MSB[2] = a&b&c | a&B&C&D | A&B&c&d;
assign MSB[1] = a&b&D | a&b&C | a&C&D | A&B&c&D;
assign MSB[0] = a&D | b&c&D | a&B&c;
*/
assign MSB[2] = (~in[3]&~in[2]&~in[1]) | (~in[3]&in[2]&in[1]&in[0]) | (in[3]&in[2]&~in[1]&~in[0]);
assign MSB[1] = (~in[3]&~in[2]&in[0]) | (~in[3]&~in[2]&in[1]) | (~in[3]&in[1]&in[0]) | (in[3]&in[2]&~in[1]&in[0]);
assign MSB[0] = (~in[3]&in[0]) | (~in[2]&~in[1]&in[0]) | (~in[3]&in[2]&~in[1]);

assign out = {MSB, LSB};

endmodule   
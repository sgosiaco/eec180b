module temp(
    input [3:0] in,

    output [6:0] out
);

wire [2:0] MSB;
reg [3:0] LSB;

/*
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
*/

parameter ZERO =  7'b100_0000;
parameter ONE =   7'b111_1001;

always @(in) begin
    case (in)
        4'b0000: begin //zero
            LSB = ZERO[3:0];
            
        end
         default: begin
            LSB = ONE[3:0];
         end    
    endcase      
end

//MSB = 3'b111;

assign out = LSB;

endmodule   
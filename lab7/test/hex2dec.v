module hex2dec(
    input [6:0] in,

    output [3:0] out
);

reg [3:0] out2;
assign out = out2;

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
parameter B = 7'b000_0011;
parameter C = 7'b100_0110;
parameter D = 7'b010_0001;
parameter E = 7'b000_0110;
parameter F = 7'b000_1110;

always @(in) begin
    case (in)
        ZERO: begin
            out2 = 4'd00;
        end
        ONE: begin
            out2 = 4'd01;
        end
        TWO: begin
            out2 = 4'd02;
        end
        THREE: begin
            out2 = 4'd03;
        end
        FOUR: begin
            out2 = 4'd04;
        end
        FIVE: begin
            out2 = 4'd05;
        end
        SIX: begin
            out2 = 4'd06;
        end
        SEVEN: begin
            out2 = 4'd07;
        end
        EIGHT: begin
            out2 = 4'd08;
        end
        NINE: begin
            out2 = 4'd09;
        end
        A: begin
            out2 = 4'd10;
        end
        B: begin
            out2 = 4'd11;
        end
        C: begin
            out2 = 4'd12;
        end
        D: begin
            out2 = 4'd13;
        end
        E: begin
            out2 = 4'd14;
        end
        F: begin
            out2 = 4'd15;
        end
         default: begin
            out2 = 4'd00;
         end    
    endcase      
end


endmodule   
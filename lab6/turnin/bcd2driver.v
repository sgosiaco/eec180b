module bcd2driver(in, out0, out1, gt99);

input [6:0] in;
output [6:0] out0, out1;
output gt99;

reg [6:0] out0, out1;
reg gt99;


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
parameter DASH = 7'b011_1111;

always @(in) begin
    if(in > 7'd099) begin
        //display dashes
        out0 = DASH;
        out1 = DASH;
        //greater than 99
        gt99 = 1'b1;
    end
    else begin
        //not greater than 99
        gt99 = 1'b0;

        //ones digit
        case (in % 7'd010)
            7'd000: begin //zero
                out0 = ZERO;
            end
            7'd001: begin //one
                out0 = ONE; 
            end
            7'd002: begin //two
                out0 = TWO; 
            end
            7'd003: begin //three
                out0 = THREE; 
            end
            7'd004: begin //four
                out0 = FOUR; 
            end
            7'd005: begin //five
                out0 = FIVE; 
            end
            7'd006: begin //six
                out0 = SIX; 
            end
            7'd007: begin //seven
                out0 = SEVEN; 
            end
            7'd008: begin //eight
                out0 = EIGHT; 
            end
            7'd009: begin //nine
                out0 = NINE; 
            end
            default: begin
                out0 = ZERO;
            end    
        endcase

        //tens digit
        case ( (in/7'd010) % 7'd010)
            7'd000: begin //zero
                out1 = ZERO;
            end
            7'd001: begin //one
                out1 = ONE; 
            end
            7'd002: begin //two
                out1 = TWO; 
            end
            7'd003: begin //three
                out1 = THREE; 
            end
            7'd004: begin //four
                out1 = FOUR; 
            end
            7'd005: begin //five
                out1 = FIVE; 
            end
            7'd006: begin //six
                out1 = SIX; 
            end
            7'd007: begin //seven
                out1 = SEVEN; 
            end
            7'd008: begin //eight
                out1 = EIGHT; 
            end
            7'd009: begin //nine
                out1 = NINE; 
            end
            default: begin
                out1 = ZERO;
            end    
        endcase 
    end    
end
endmodule       
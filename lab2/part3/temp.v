module hex_display(
   input [3:0] SW,
   output reg [7:0] HEX0, HEX1
   );

   /*
   Parameters in Verilog are constants that are determined at
   compile time and cannot be changed during run time. When a
   design is compiled, Quartus will substitute the value for the
   parameter where ever it is used.
   Parameters are useful for the following reasons:

   1. If a constant is used in multiple places in your code, using a
   parameter allows you define the value of that constant ONCE and then
   reference it wherever needed.

   2. Parameters reduce the occurance of "magic numbers" in your code.
   (Google "magic number programming" if you're curious about what this is.)

   3. Correct use of parameters allows code to be "generic" (more on this later)
   */

   parameter ZERO =  8'b1100_0000;
   parameter ONE =   8'b1111_1001;
   parameter TWO = 8'b1010_0100;
   parameter THREE = 8'b1011_0000;
   parameter FOUR = 8'b1001_1001;
   parameter FIVE = 8'b1001_0010;
   parameter SIX = 8'b1000_0010;
   parameter SEVEN = 8'b1111_1000;
   parameter EIGHT = 8'b1000_0000;
   parameter NINE = 8'b1001_1000;

   always @(SW) begin
      case (SW)
         4'b0000: begin //zero
            HEX0 = ZERO;
            HEX1 = ZERO;
         end
         4'b0001: begin //one
            HEX0 = ONE; 
            HEX1 = ZERO;
         end
         4'b0010: begin //two
            HEX0 = TWO; 
            HEX1 = ZERO;
         end
         4'b0011: begin //three
            HEX0 = THREE; 
            HEX1 = ZERO;
         end
         4'b0100: begin //four
            HEX0 = FOUR; 
            HEX1 = ZERO;
         end
         4'b0101: begin //five
            HEX0 = FIVE; 
            HEX1 = ZERO;
         end
         4'b0110: begin //six
            HEX0 = SIX; 
            HEX1 = ZERO;
         end
         4'b0111: begin //seven
            HEX0 = SEVEN; 
            HEX1 = ZERO;
         end
         4'b1000: begin //eight
            HEX0 = EIGHT; 
            HEX1 = ZERO;
         end
         4'b1001: begin //nine
            HEX0 = NINE; 
            HEX1 = ZERO;
         end
         4'b1010: begin //ten
            HEX0 = ZERO; 
            HEX1 = ONE;
         end
         4'b1011: begin //eleven
            HEX0 = ONE; 
            HEX1 = ONE;
         end
         4'b1100: begin //twelve
            HEX0 = TWO; 
            HEX1 = ONE;
         end
         4'b1101: begin //thirteen
            HEX0 = THREE; 
            HEX1 = ONE;
         end
         4'b1110: begin //fourteen
            HEX0 = FOUR; 
            HEX1 = ONE;
         end
         4'b1111: begin //fifteen
            HEX0 = FIVE;
            HEX1 = ONE;
         end
         default: begin
            HEX0 = ZERO;
            HEX1 = ZERO;
         end
      endcase
   end
endmodule
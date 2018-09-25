module temp_tb();

   // Signal Declarations
   reg [3:0] in;     // Inputs
   wire [6:0] out;  // Outputs

   // Unit Under Test Instantiation
   seg7 UUT (.in(in), .out(out));

   initial begin
      in = 4'b0000;
      #10
      // Print Current
      $display("in0 = %4b | out = %7b", in, out);

      // Automatically stop testbench execution
      $stop;
   end

endmodule
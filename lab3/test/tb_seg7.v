module seg7_tb();

   // Signal Declarations
   reg [3:0] in;     // Inputs
   wire [6:0] out;  // Outputs

   // Unit Under Test Instantiation
   seg7 UUT (.in(in), .out(out));

   // Indexing variable
   integer j;

   // Computed Expected Results by hand


   initial begin
      for (j = 0; j < 16; j = j + 1) begin
         // Assign {a,b,c} to the three LSB's of "i".
         in = j;

         // Wait to ensure loop does not execute all at once
         #10;
        
         // Print Current
         $display("input = %4b output = %3b_%4b", in, out[6:4], out[3:0]);
         
         // Check Results


         
      end

      // Automatically stop testbench execution
      $stop;
   end

endmodule
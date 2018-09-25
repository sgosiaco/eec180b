module comb_tb();

   // Signal Declarations
   reg a,b,c;     // Inputs
   wire g,h,i;  // Outputs

   // Indexing variable
   integer j;

   // Unit Under Test Instantiation
   comb UUT (.a(a), .b(b), .c(c), .g(g), .h(h), .i(i));

   // Computed Expected Results by hand
   reg [7:0] g_expected = 8'b0110_1001;
   reg [7:0] h_expected = 8'b1011_1010;
   reg [7:0] i_expected = 8'b1110_1111;

   /*
   The idea here is that we use an integer to count from 0 to 7. We assign the
   three LSBs of the integer "j" to the concatenated signal {a,b,c}. This will
   apply all input vectors to the "comb" module.

   We precompute the expected results for each output. The precomputed result
   for the output is already given. As "j" ranges from 0 to 7, we use "j" to
   index into "g_expected". We can then compare that to the output "g" from
   UUT.

   For example, if "j = 1", then {a,b,c} = {0,0,1} and g_expected[j] = 0.
   */

   initial begin
      for (j = 0; j < 8; j = j + 1) begin
         // Assign {a,b,c} to the three LSB's of "i".
         {a,b,c} = j;

         // Wait to ensure loop does not execute all at once
         #10;

         // Check Results
         if (g != g_expected[j]) begin
            $display("Unexpected output for g at input %3b", {a,b,c});
         end

         if (h != h_expected[j]) begin
            $display("Unexpected output for h at input %3b", {a,b,c});
         end

         if (i != i_expected[j]) begin
            $display("Unexpected output for i at input %3b", {a,b,c});
         end
      end

      // Automatically stop testbench execution
      $stop;
   end

endmodule
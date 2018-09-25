module sort2_tb();

   // Signal Declarations
   reg [3:0] in0, in1;     // Inputs
   wire [3:0] out0, out1;  // Outputs

   // Unit Under Test Instantiation
   sort2 UUT (.in0(in0), .in1(in1), .out0(out0), .out1(out1));

   initial begin
      in1 = 4'b0000;
      in0 = 4'b1111;
      #10
      // Print Current
      $display("in0 = %4b in1 = %4b | out0 = %4b out1 = %4b", in0, in1, out0, out1);

      // Automatically stop testbench execution
      $stop;
   end

endmodule
module sort4_tb();

   // Signal Declarations
   reg [3:0] in0, in1, in2, in3;     // Inputs
   wire [3:0] out0, out1, out2, out3;  // Outputs

   // Unit Under Test Instantiation
   sort4 UUT (.in0(in0), .in1(in1), .in2(in2), .in3(in3), 
                .out0(out0), .out1(out1), .out2(out2), .out3(out3));

   initial begin
      in3 = 4'b0000;
      in2 = 4'b0001;
      in1 = 4'b0010;
      in0 = 4'b1111;
      #10
      // Print Current
      $display("in0 = %4b in1 = %4b in2 = %4b in3 = %4b", in0, in1, in2, in3);
      $display("out0 = %4b out1 = %4b out2 = %4b out3 = %4b", out0, out1, out2, out3);

      // Automatically stop testbench execution
      $stop;
   end

endmodule
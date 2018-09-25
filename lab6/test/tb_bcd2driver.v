module bcd2driver_tb();

    // Signal Declarations
    reg [6:0] in;
    // Outputs
    wire gt99;
    wire [6:0] out0, out1;

    // Unit Under Test Instantiation
    bcd2driver uut(
        .in(in), 
        .out0(out0), 
        .out1(out1), 
        .gt99(gt99)
    );

    integer j;

    initial begin
        for(j = 0; j < 110; j = j + 10) begin
            in = j;

            #10;
            $display("----------");
            $display("in = %3d", in);
            $display("out1 = %2h out0 = %2h", out1, out0);
            $display("gt99 = %1b", gt99);
        end
        $stop;
    end  
    
endmodule
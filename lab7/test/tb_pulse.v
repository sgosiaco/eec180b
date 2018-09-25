module pulse_tb();

    // Signal Declarations
    reg clock, reset, enable;     // Inputs
    reg [5:0] divideby;
    wire go;  // Outputs
    wire [9:0] LEDR;
    //wire [5:0] count;

    // Unit Under Test Instantiation
    pulse UUT (
        .clock(clock),
        .reset(reset),
        .enable(enable),
        .divideby(divideby),
        .go(go),
        .LEDR(LEDR)
    );

    initial begin
        clock  = 1'b0;
        #1000000
        // Automatically stop testbench execution
        $stop;
    end
    
    always begin
        #100
        clock = ~clock;
    end


    initial begin
        $display("Testing divideby = 2");
        enable = 1'b0;
        divideby = 6'b000_010;
        reset = 1'b0;
        #500

        @(posedge clock); #10;
        enable = 1'b1;
        reset = 1'b1;

        @(posedge clock); #10;
        reset = 1'b0;


        repeat(10) begin
            @(posedge clock); #10;
            //$display("count = %6b", count);
        end




        $display("Testing divideby = 3");
        divideby = 6'b000_011;
        #500

        @(posedge clock); #10;
        enable = 1'b1;
        reset = 1'b1;

        @(posedge clock); #10;
        reset = 1'b0;


        repeat(20) begin
            @(posedge clock); #10;
            //$display("count = %6b", count);
        end
        

        // Automatically stop testbench execution
        $stop;
    end

endmodule
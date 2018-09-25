module top2_tb();

    // Signal Declarations
    reg clock;     // Inputs
    reg [1:0] KEY;
    reg [9:0] SW;
    // Outputs
    wire [9:0] LEDR;
    wire [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    //wire [5:0] count;
    wire [3:0] HEX0_d, HEX1_d, HEX2_d, HEX3_d, HEX4_d, HEX5_d;

    // Unit Under Test Instantiation
    top UUT (
        .MAX10_CLK1_50(clock),
        .KEY(KEY),
        .SW(SW),
        .LEDR(LEDR),
        .HEX0(HEX0),   
        .HEX1(HEX1),   
        .HEX2(HEX2),   
        .HEX3(HEX3),   
        .HEX4(HEX4),   
        .HEX5(HEX5)    
    );

    hex2dec h0(
        .in(HEX0), 
        .out(HEX0_d)
    );
    hex2dec h1(
        .in(HEX1), 
        .out(HEX1_d)
    );
    hex2dec h2(
        .in(HEX2), 
        .out(HEX2_d)
    );
    hex2dec h3(
        .in(HEX3), 
        .out(HEX3_d)
    );
    hex2dec h4(
        .in(HEX4), 
        .out(HEX4_d)
    );
    hex2dec h5(
        .in(HEX5), 
        .out(HEX5_d)
    );

    initial begin
        clock  = 1'b0;
    end
    
    always begin
        #100
        clock = ~clock;
    end


    initial begin
        SW[9:0] = 10'b00000_00011;
        KEY[1] = 1'b0;
        $display("Testing all functions");
        $display("|  H5  |  H4  |  H3  |  H2  |  H1  |  H0  |  L9 |  L8 |  L0 |");
        $display("-------------------------------------------------------------");
        KEY[0] = 1'b1; //reset
        #500

        @(posedge clock); #10;
        KEY[0] = 1'b0; //reset

        @(posedge clock); #10;
        KEY[0] = 1'b1; //reset


        repeat(40) begin
            @(posedge clock); #10;
            $display("|  %1d  |  %1d  |  %1d  |  %1d  |  %1d  |  %1d  |  %1b  |  %1b  |  %1b  |", HEX5_d, HEX4_d, HEX3_d, HEX2_d, HEX1_d, HEX0_d, LEDR[9], LEDR[8], LEDR[0]);
            $display("-------------------------------------------------------------");
        end

        
    
        // Automatically stop testbench execution
        $stop;
    end

endmodule
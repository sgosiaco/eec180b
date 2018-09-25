module top_tb();

    // Signal Declarations
    reg clock;     // Inputs
    reg [1:0] KEY;
    reg [9:0] SW;
    // Outputs
    wire [9:0] LEDR;
    wire [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    //wire [5:0] count;

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
        SW[9:0] = 10'b00000_00000;
        KEY[1] = 0;
        $display("Testing divideby = 1");
        $display("Testing count up. Free=0");
        SW[0] = 1'b0; //enable
        SW[9:4] = 6'b000_001; //divideby
        SW[2:1] = 2'b01; // free up
        KEY[0] = 1'b1; //reset
        #500

        @(posedge clock); #10;
        SW[0] = 1'b1; //enable
        KEY[0] = 1'b0; //reset

        @(posedge clock); #10;
        KEY[0] = 1'b1; //reset


        repeat(10) begin
            @(posedge clock); #10;
            $display("HEX0 = %2h", HEX0);
        end

        $display("Testing count down. Free=0");
        SW[9:4] = 6'b000_001; //divideby
        SW[2:1] = 2'b00; // free down
        #500


        repeat(10) begin
            @(posedge clock); #10;
            $display("HEX0 = %2h", HEX0);
        end

        $display("Testing count down. Free=1");
        SW[9:4] = 6'b000_001; //divideby
        SW[2:1] = 2'b10; // free down
        #500


        repeat(10) begin
            @(posedge clock); #10;
            $display("HEX0 = %2h", HEX0);
        end
        

        $display("Testing count up. Free=1");
        SW[9:4] = 6'b000_001; //divideby
        SW[2:1] = 2'b11; // free up
        #500


        repeat(10) begin
            @(posedge clock); #10;
            $display("HEX0 = %2h", HEX0);
        end

        
    
        // Automatically stop testbench execution
        $stop;
    end

endmodule
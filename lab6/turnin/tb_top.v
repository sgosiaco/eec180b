module top_tb();

    // Signal Declarations
    reg clock;     // Inputs
    reg [1:0] KEY;
    reg [9:0] SW;
    // Outputs
    wire [9:0] LEDR;
    wire [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

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
        $stop;
    end
    
    always begin
        #100
        clock = ~clock;
    end


    initial begin
        SW[9:0] = 10'b00000_00000;
        KEY[0] = 1'b1; //reset
        KEY[1] = 1'b1;
        #500

        @(posedge clock); #10;
        KEY[0] = 1'b0; //reset

        @(posedge clock); #10;
        KEY[0] = 1'b1; //reset



        $display("-------------");
        $display("Adding 1 and 10");
        @(posedge clock); #10;
        SW[4:0] = 4'b0101;

        @(posedge clock); #10;
        KEY[1] = 1'b0;

        @(posedge clock); #10;
        KEY[1] = 1'b1; //enter

        @(posedge clock); #10;
        @(posedge clock); #10;
        $display("balance = %2h %2h", HEX5, HEX4);
        $display("current = %2h %2h", HEX1, HEX0);
        $display("LEDR = %5b %5b", LEDR[9:5], LEDR[4:0]);


        @(posedge clock); #10;
        SW[4:0] = 4'b0000;
        KEY[0] = 1'b0; //reset

        @(posedge clock); #10;
        KEY[0] = 1'b1; //reset


        @(posedge clock); #10;
        $display("-------------");
        $display("Checking reset");
        $display("balance = %2h %2h", HEX5, HEX4);
        $display("current = %2h %2h", HEX1, HEX0);
        $display("LEDR = %5b %5b", LEDR[9:5], LEDR[4:0]);


        $display("-------------");
        $display("Adding zero");
        @(posedge clock); #10;
        SW[4:0] = 4'b0000;
        KEY[1] = 1'b0;

        @(posedge clock); #10;
        KEY[1] = 1'b1; //enter

        @(posedge clock); #10;
        $display("balance = %2h %2h", HEX5, HEX4);
        $display("current = %2h %2h", HEX1, HEX0);
        $display("LEDR = %5b %5b", LEDR[9:5], LEDR[4:0]);

        
        $display("-------------");
        $display("Adding 1");
        @(posedge clock); #10;
        SW[4:0] = 4'b0001;
        KEY[1] = 1'b0;

        @(posedge clock); #10;
        KEY[1] = 1'b1; //enter

        @(posedge clock); #10;
        $display("balance = %2h %2h", HEX5, HEX4);
        $display("current = %2h %2h", HEX1, HEX0);
        $display("LEDR = %5b %5b", LEDR[9:5], LEDR[4:0]);

        
        $display("-------------");
        $display("Adding 5");
        @(posedge clock); #10;
        SW[4:0] = 4'b0010;
        KEY[1] = 1'b0;

        @(posedge clock); #10;
        KEY[1] = 1'b1; //enter

        @(posedge clock); #10;
        $display("balance = %2h %2h", HEX5, HEX4);
        $display("current = %2h %2h", HEX1, HEX0);
        $display("LEDR = %5b %5b", LEDR[9:5], LEDR[4:0]);

        
        $display("-------------");
        $display("Adding 10");
        @(posedge clock); #10;
        SW[4:0] = 4'b0100;
        KEY[1] = 1'b0;

        @(posedge clock); #10;
        KEY[1] = 1'b1; //enter

        @(posedge clock); #10;
        $display("balance = %2h %2h", HEX5, HEX4);
        $display("current = %2h %2h", HEX1, HEX0);
        $display("LEDR = %5b %5b", LEDR[9:5], LEDR[4:0]);

        
        repeat(5) begin
            $display("-------------");
            $display("Adding 25");
            @(posedge clock); #10;
            SW[4:0] = 4'b1000;
            KEY[1] = 1'b0;

            @(posedge clock); #10;
            KEY[1] = 1'b1; //enter

            @(posedge clock); #10;
            @(posedge clock); #10;
            $display("balance = %2h %2h", HEX5, HEX4);
            $display("current = %2h %2h", HEX1, HEX0);
            $display("LEDR = %5b %5b", LEDR[9:5], LEDR[4:0]);
        end
        


        
        $stop;
    end

endmodule
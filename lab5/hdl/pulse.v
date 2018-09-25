module pulse(clock, reset,  enable, divideby, go, LEDR);
    input clock;
    input reset;
    input enable;
    input [5:0] divideby;

    output go;
    output [9:0] LEDR;
    //output [5:0] count;

    reg [5:0] count;
    reg [5:0] count_c;
    reg go;
    reg [9:0] LEDR;

    always @(*) begin
        if(enable == 1'b1) begin
            count_c = count;

            if(divideby == 6'b000_000) begin
                count_c = 6'b000_000;
                LEDR  = 10'b11111_11111;
                go = 1'b0;
            end
            else begin
                LEDR  = 10'b00000_00000;
                //logic for go
                if(count == 6'b000_000) begin
                    go = 1'b1;
                end
                else begin
                    go = 1'b0;
                end

                //counting stuff
                if(count != (divideby - 6'b000_001)) begin
                    count_c = count + 6'b000_001;
                end
                else begin //rollover
                    count_c = 6'b000_000;
                end
            end
            if(reset == 1'b1) begin
                count_c  = 6'b000_000;
                LEDR = 10'b00000_00000;
                go = 1'b0;
            end 
        end
        
    end
    
    always @(posedge clock) begin
        count <= #1 count_c;
    end

endmodule
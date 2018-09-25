module pulse(clock, reset, divideby, go);
    input clock;
    input reset;
    input [25:0] divideby;

    output go;

    reg [25:0] count;
    reg [25:0] count_c;
    reg go;

    //10_1111_1010_1111_0000_1000_0000
    //26 bits to represent 50 million

    always @(*) begin
        count_c = count;
            if(divideby == 26'b00_0000_0000_0000_0000_0000_0000) begin
                count_c = 26'b00_0000_0000_0000_0000_0000_0000;
                go = 1'b0;
            end
            else begin
                //logic for go
                if(count == 26'b00_0000_0000_0000_0000_0000_0000) begin
                    go = 1'b1;
                end
                else begin
                    go = 1'b0;
                end

                //counting stuff
                if(count != (divideby - 26'b00_0000_0000_0000_0000_0000_0001)) begin
                    count_c = count + 26'b00_0000_0000_0000_0000_0000_0001;
                end
                else begin //rollover
                    count_c = 26'b00_0000_0000_0000_0000_0000_0000;
                end
            end
            if(reset == 1'b1) begin
                count_c  = 26'b00_0000_0000_0000_0000_0000_0000;
                go = 1'b0;
            end    
    end
    
    always @(posedge clock) begin
        count <= #1 count_c;
    end

endmodule
module counter(clock, reset,  enable1, enable2, updown, freerun, display);
    input clock;
    input reset;
    input enable1;
    input enable2;
    input updown;
    input freerun;

    output [23:0] display;

    reg [23:0] count;
    reg [23:0] count_c;
    
    always @(*) begin
        if(enable1 == 1'b1 && enable2 == 1'b1) begin
            count_c = count;

            if(freerun == 1'b1) begin //count forever
                if(updown == 1'b1) begin //count up
                    if(count != 24'hffffff) begin
                        count_c = count + 24'h000001;
                    end
                    else begin
                        count_c = 24'h000000;
                    end
                end
                else begin //count down
                    if(count != 24'h000000) begin
                        count_c = count - 24'h000001;
                    end
                    else begin
                        count_c = 24'hffffff;
                    end
                end
            end
            else begin //count half
                if(updown == 1'b1) begin //count up
                    if(count != 24'hffffff/2) begin
                        count_c = count + 24'h000001;
                    end
                    else begin
                        count_c = 24'hffffff/2;
                    end
                end
                else begin //count down
                    if(count != 24'h000000) begin
                        count_c = count - 24'h000001;
                    end
                    else begin
                        count_c = 24'h000000;
                    end
                end
            end
        end
        if(enable1 == 1'b1) begin
            if(reset == 1'b1) begin
                count_c = 24'h000000;
            end
        end
    end

    always @(posedge clock) begin
        count <= #1 count_c;
    end
    
    assign display = count;


endmodule
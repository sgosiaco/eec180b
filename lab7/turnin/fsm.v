module fsm(enable, clk, reset, rd_in, rd_out, LEDR8, LEDR9, wr_enable, wr_addr, wr_data, rd_addr, state);

input enable;
input clk;
input reset;
input [3:0] rd_in;

output [3:0] rd_out;
output LEDR8;
output LEDR9;
output wr_enable;
output [1:0] wr_addr;
output [3:0] wr_data;
output [1:0] rd_addr;
output [4:0] state;

//State Assignments

//step2
parameter LOAD_10 = 5'b00_000; //0
parameter LOAD_11 = 5'b00_001; //1
parameter LOAD_12 = 5'b00_010; //2
parameter LOAD_13 = 5'b00_011; //3
parameter WAIT_1 =  5'b00_100; //4
//step3
parameter READ_13 = 5'b00_101; //5
parameter READ_12 = 5'b00_110; //6
parameter READ_11 = 5'b00_111; //7
parameter READ_10 = 5'b01_000; //8
parameter WAIT_2 =  5'b01_001; //9
//step4
parameter LOAD_20 = 5'b01_010; //10
parameter LOAD_21 = 5'b01_011; //11
parameter WAIT_3 =  5'b01_100; //12
//step5
parameter READ_23 = 5'b01_101; //13
parameter READ_22 = 5'b01_110; //14
parameter READ_21 = 5'b01_111; //15
parameter READ_20 = 5'b10_000; //16
//step6
parameter WAIT_4 = 5'b10_001; //17
parameter WAIT_5 = 5'b10_010; //18
//End state Assignments


//18 states -> 5 bits required
reg [4:0] state, state_c;
reg [3:0] rd_in_r;
reg wr_enable;
reg [1:0] wr_addr, rd_addr;
reg [3:0] wr_data, rd_out;
reg LEDR8, LEDR9;

reg wr_enable_r;
reg [1:0] wr_addr_r, rd_addr_r;
reg [3:0] wr_data_r, rd_out_r;
reg LEDR8_r, LEDR9_r;


always @(*) begin
    //default
    state_c = state;
    wr_addr = wr_addr_r;
    wr_data = wr_data_r;
    wr_enable = wr_enable_r;
    rd_addr = rd_addr_r;
    LEDR8 = LEDR8_r;
    LEDR9 = LEDR9_r;
	rd_out = rd_out_r;
     
    if(enable == 1'b1) begin
        case(state)
            //step 2
            LOAD_10: begin
                wr_enable = 1'b1;
                wr_addr = 2'b00;
                wr_data = 4'b0000;
                state_c = LOAD_11;
            end//LOAD_10
            LOAD_11: begin
                wr_addr = 2'b01;
                wr_data = 4'b0001;
                state_c = LOAD_12;
            end//LOAD_11
            LOAD_12: begin
                wr_addr = 2'b10;
                wr_data = 4'b0010;
                state_c = LOAD_13;
            end//LOAD_12
            LOAD_13: begin
                wr_addr = 2'b11;
                wr_data = 4'b0011;
                state_c = WAIT_1;
            end//LOAD_13
            WAIT_1: begin
                wr_enable = 1'b0;
                wr_addr = 2'b00;
                wr_data = 4'b0000;
                state_c = READ_13;  
            end//WAIT_1
            //end step 2

            //step 3
            READ_13: begin             
                rd_addr = 2'b11;
                state_c = READ_12;          
            end //READ_13
            READ_12: begin
                LEDR9 = 1'b1;
                rd_addr = 2'b10;
                rd_out = rd_in_r + 4'b0001;
                state_c = READ_11;    
            end //READ_12
            READ_11: begin
                rd_addr = 2'b01;
                rd_out = rd_in_r + 4'b0001;
                state_c = READ_10;  
            end //READ_11
            READ_10: begin
                rd_addr = 2'b00;
                rd_out = rd_in_r + 4'b0001;
                state_c = WAIT_2;
            end //READ_10
            WAIT_2: begin
                rd_out = rd_in_r + 4'b0001;
                state_c = LOAD_20;
            end //WAIT_2
            //end step 3

            //step 4
            LOAD_20: begin
                rd_out = 4'b0000;
                LEDR9 = 1'b0;
                wr_enable = 1'b1;
                wr_addr = 2'b00;
                wr_data = 4'b0101;
                state_c = LOAD_21;
            end //LOAD_20
            LOAD_21: begin  
                wr_addr = 2'b01;
                wr_data = 4'b0110;
                state_c = WAIT_3;
            end //LOAD_21
            WAIT_3: begin
                wr_addr = 2'b00;
                wr_data = 4'b0000;
                wr_enable = 1'b0;
                state_c = READ_23;    
            end //WAIT_3
            //end step 4
            
            //step 3 again
            READ_23: begin
                rd_addr = 2'b11;
                state_c = READ_22;
            end //READ_23
            READ_22: begin
                LEDR9 = 1'b1;
                rd_addr = 2'b10;
                rd_out = rd_in_r + 4'b0001;
                state_c = READ_21;     
            end //READ_22
            READ_21: begin
                rd_addr = 2'b01;
                rd_out = rd_in_r + 4'b0001;
                state_c = READ_20;     
            end //READ_21
            READ_20: begin
                rd_addr = 2'b00;
                rd_out = rd_in_r + 4'b0001;
                state_c = WAIT_4;
            end //READ_20
            WAIT_4: begin
                rd_out = rd_in_r + 4'b0001;
                state_c = WAIT_5;
            end //WAIT_4
            //end step 3 again

            //step 6
            WAIT_5: begin
                LEDR9 = 1'b0;
                LEDR8 = 1'b1;
                rd_out = 4'b0000;
            end
            //end step 6

            default: begin
                state_c = LOAD_10;
            end
        endcase
    end
    //reset
    if(reset == 1'b1) begin
        wr_addr = 2'b00;
        wr_data = 4'h0;
        wr_enable = 1'b0;
        rd_addr = 2'b00;
        LEDR8 = 1'b0;
        LEDR9 = 1'b0;
        rd_out = 4'h0;
        state_c = LOAD_10;
    end

end //always

//FF
always @(posedge clk) begin
	state <= #1 state_c;
    rd_in_r <= #1 rd_in;

    wr_addr_r <= #1 wr_addr;
    wr_data_r <= #1 wr_data;
    wr_enable_r <= #1 wr_enable;
    rd_addr_r <= #1 rd_addr;
    LEDR8_r <= #1 LEDR8;
    LEDR9_r <= #1 LEDR9;
	rd_out_r <= #1 rd_out;
end
endmodule

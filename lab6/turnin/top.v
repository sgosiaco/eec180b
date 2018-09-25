module top(
	input 		          		MAX10_CLK1_50,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);


parameter IDLE = 3'b000;
parameter W_ERROR = 3'b001;
parameter W_OK = 3'b010;
parameter ERROR = 3'b011;
parameter FULL = 3'b100;

reg [2:0] state, state_c;
reg [6:0] balance, balance_c;
reg [6:0] sw_input;
wire gt99_bal, gt99_cur;
reg [4:0] error, full;

//registers
reg [1:0] KEY_r;
reg [9:0] SW_r;

always @(posedge MAX10_CLK1_50) begin
  KEY_r[0] <= #1 KEY[0];
  KEY_r[1] <= #1 KEY[1];
  SW_r[0] <= #1 SW[0];
  SW_r[1] <= #1 SW[1];
  SW_r[2] <= #1 SW[2];
  SW_r[3] <= #1 SW[3];
  SW_r[4] <= #1 SW[4];
  SW_r[5] <= #1 SW[5];
  SW_r[6] <= #1 SW[6];
  SW_r[7] <= #1 SW[7];
  SW_r[8] <= #1 SW[8];
  SW_r[9] <= #1 SW[9];
end

always @(state or balance or SW or KEY) begin
  //default
  state_c = state;
  balance_c = balance;

    case(state)
        IDLE: begin
            if(KEY_r[1] == 1'b0) begin
                case(SW_r[3:0])
                    4'b0000: begin
                        state_c = W_OK;
                    end
                    4'b0001: begin //1
                        state_c = W_OK;
                        balance_c = balance + 7'd001;
                    end
                    4'b0010: begin //5
                        state_c = W_OK;
                        balance_c = balance + 7'd005;
                    end
                    4'b0100: begin //10
                        state_c = W_OK;
                        balance_c = balance + 7'd010;
                    end
                    4'b1000: begin //25
                        state_c = W_OK;
                        balance_c = balance + 7'd025;
                    end
                    default: begin //error
                        state_c = W_ERROR;
                    end
                endcase
            end
		end//IDLE
        W_ERROR: begin
            if(KEY_r[1] == 1'b1) begin
                state_c = ERROR;
            end
        end //W_ERROR
        W_OK: begin
            if(KEY_r[1] == 1'b1) begin
                state_c = IDLE;
				if(gt99_bal == 1'b1) begin
					state_c = FULL;
				end	
            end
        end //W_OK
        ERROR: begin
            error = 5'b11111;
        end //ERROR
		FULL: begin
			full = 5'b11111;
		end
    endcase
    //reset
    if(KEY_r[0] == 1'b0) begin
        state_c = IDLE;
        balance_c = 7'b000_0000;
		error = 5'b00000;
		full = 5'b00000;
    end
end //always

//FF
always @(posedge MAX10_CLK1_50) begin
	state <= #1 state_c;
	balance <= #1 balance_c;
end


bcd2driver bal(balance, HEX4, HEX5, gt99_bal);

bcd2driver cur(sw_input, HEX0, HEX1, gt99_cur);

always @(*) begin
	case(SW_r[3:0])
		4'b0000: begin
			sw_input = 7'd000;
		end
		4'b0001: begin //1
			sw_input = 7'd001;
		end
		4'b0010: begin //5
			sw_input = 7'd005;
		end
		4'b0100: begin //10
			sw_input = 7'd010;
		end
		4'b1000: begin //25
			sw_input = 7'd025;
		end
		default: begin //error
			sw_input = 7'd100;
		end
	endcase	
end

assign HEX0[7] = 1'b1;
assign HEX1[7] = 1'b1;
assign HEX2 = 8'hff;
assign HEX3 = 8'hff;
assign HEX4[7] = 1'b1;
assign HEX5[7] = 1'b1;

assign LEDR[4:0] = error;
assign LEDR[9:5] = full;

endmodule

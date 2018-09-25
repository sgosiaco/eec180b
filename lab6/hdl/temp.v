parameter IDLE = 2'b00;
parameter W_ERROR = 2'b01;
parameter W_OK = 2'b10;
parameter ERROR = 2'b11;

reg [1:0] state, state_c;
reg [6:0] balance, balance_c;
reg [6:0] sw_input;
reg gt99_bal, gt99_cur;

always @(state or balance or SW or KEY) begin
  //default
  state_c = state;
  balance_c = balance;

    case(state)
        IDLE: begin
            if(balance > 7'd099) begin
                //full
                LEDR[9:5] = 5'b11111;
            end//if
            else begin
                if(KEY[1] == 1'b0) begin
                    case(SW[3:0])
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
            end//else
        W_ERROR: begin
            if(KEY[1] == 1'b1) begin
                state_c = ERROR;
            end
        end //W_ERROR
        W_OK: begin
            if(KEY[1] == 1'b1) begin
                state_c = IDLE;
            end
        end //W_OK
        ERROR: begin
            LEDR[4:0] = 5'b11111;
        end //ERROR
    endcase
    //reset
    if(KEY[0] == 1'b0) begin
        state_c = IDLE;
        balance_c = 7'b000_0000;
    end
end //always
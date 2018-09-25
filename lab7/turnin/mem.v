module mem(clk, wr_enable, wr_addr, wr_data, rd_addr, rd_data);

input clk;
input wr_enable;
input [1:0] wr_addr;
input [3:0] wr_data;
input [1:0] rd_addr;
output [3:0] rd_data;

reg [3:0] mem[0:3];
reg [3:0] rd_data;


always @(posedge clk) begin
    if(wr_enable == 1'b1) begin
        mem[wr_addr] <= #1 wr_data;
    end

    rd_data <= #1 mem[rd_addr];
end

endmodule
module comb(
    input a,
    input b,
    input c,

    output g,
    output h,
    output i
);

assign g = a ^ b ^ ~c;
assign h = a & ~b | c;
assign i = g | c;

endmodule
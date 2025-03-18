module postnorm(
    input [10:0] en,
    input [10:0] eni,
    input [53:0] f2,

    output sigovf,
    output [10:0] e2,
    output [52:0] f3
);

assign sigovf = f2[53];
assign e2 = f2[53] ? eni : en;
assign f3 = {f2[53] | f2[52], f2[51:0]};

endmodule


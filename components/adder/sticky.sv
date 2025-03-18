`include "./../../utils/HDecJ.sv"
`include "./../../utils/ortree.sv"

module sticky (
    input [5:0] as2,
    input [54:0] fb2,
    output sticky
);

parameter N = 6;
wire [63:0] y;

HDecJ #(N) hdec(
    .x(as2),
    .y(y)
);

wire [54:0] or_in;
assign or_in = fb2 & y[54:0];

parameter n = 55;
ortree #(n) or_tree(
    .x(or_in),
    .or_out(sticky)
);

endmodule

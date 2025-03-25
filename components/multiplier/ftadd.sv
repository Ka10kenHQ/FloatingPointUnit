`include "./../../utils/three2add.sv"

module ftadd #(parameter n = 13) (
    input [n-1:0] a,
    input [n-1:0] b,
    input [n-1:0] c,
    input [n-1:0] d,
    output [n:0] t,
    output [n:0] s
);

wire [n:0] t1, s1;

three2add #(n) stage1 (
    .a(a),
    .b(b),
    .c(c),
    .c_in(1'b1),
    .t(t1),
    .s(s1)
);

three2add #(n) stage2 (
    .a(s1[n-1:0]),
    .b(t1[n-1:0]),
    .c(d),
    .c_in(1'b0),
    .t(t),
    .s(s)
);

endmodule

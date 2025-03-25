`include "./../../utils/add.sv"

module signexpmd(
    input sa,
    input [10:0] ea,
    input [5:0] lza,

    input sb,
    input [10:0] eb,
    input [5:0] lzb,

    input fdiv,

    output  sq,
    output  [12:0] eq
);

wire [12:0] a, b, c, d;
wire [13:0] t, s;

assign sq = sa ^ sb;

assign a = {ea[10], ea[10], ea[10:0]};
assign b = {7'b1111111, ~lza[5:0]};
// TODO: figure this out
assign c = fdiv ? {~eb[10], ~eb[10], ~eb[10:0]} : {eb[10], eb[10], eb[10:0]};
assign d = fdiv ? {7'b0000000, lzb[5:0]} : {7'b1111111, ~lzb[5:0]};

ftadd add(
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .t(t),
    .s(s)
);

wire [13:0] sum;

parameter n = 13;
add #(n) ad(
    .a(t[12:0]),
    .b(s[12:0]),
    .c_in(1'b1),
    .sum(sum)
);

assign eq = sum[12:0];

endmodule


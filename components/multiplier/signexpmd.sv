module signexpmd(
    input sa,
    input [10:0] ea,
    input [5:0] lza,

    input sb,
    input [10:0] eb,
    input [5:0] lzb,

    input fdiv,

    output wire sq,
    output wire [12:0] eq
);

wire [12:0] a, b, c, d;
wire [13:0] t, s;

assign sq = sa ^ sb;

assign a = {ea[10], ea[10], ea[10:0]};
assign b = {7'b1111111, ~lza};

assign c = fdiv ? {~eb[10], ~eb[10], ~eb[10:0]} : {eb[10], eb[10], eb[10:0]};
assign d = fdiv ? {7'b0, lzb} : {7'b1111111, lzb};

ftadd add(
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .t(t),
    .s(s)
);

assign eq = t + s + 1;

endmodule


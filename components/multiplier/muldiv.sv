module muldiv (
    input wire fdiv,
    input wire sa,
    input wire sb,
    input wire db,
    input wire  [52:0] fa,
    input wire  [52:0] fb,
    input wire  [10:0] ea,
    input wire  [10:0] eb,
    input wire  [5:0]  lza,
    input wire  [5:0]  lzb,
    input wire  [52:0] nan,
    input wire  [3:0]  fla,
    input wire  [3:0]  flb,
    output wire [56:0] fq,
    output wire [12:0] eq,
    output wire        sq,
    output wire [57:0] flq
);

wire [1:0] oe1;
wire oe2;
assign oe1 = 2'b11;
assign oe2 = 1'b0;

sigfmd sig(
    .fa(fa),
    .fb(fb),
    .fdiv(fdiv),
    .oe1(oe1),
    .oe2(oe2),
    .db(db),
    .fq(fq)
);

signexpmd sigexp(
    .sa(sa),
    .ea(ea),
    .lza(lza),
    .sb(sb),
    .eb(eb),
    .lzb(lzb),
    .fdiv(fdiv),
    .sq(sq),
    .eq(eq)
);

specmd spec(
    .nan(nan),
    .fla(fla),
    .flb(flb),
    .fdiv(fdiv),
    .flq(flq)
);


endmodule

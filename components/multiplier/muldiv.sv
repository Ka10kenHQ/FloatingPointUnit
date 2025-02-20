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
    output [56:0] fq,
    output [12:0] eq,
    output        sq,
    output [57:0] flq
);

sigfmd sig(
    .fa(fa),
    .fb(fb),
    .fdiv(fdiv),
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

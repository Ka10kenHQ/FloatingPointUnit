module muldiv (
    input        clk,
    input        rst_n,
    input        fdiv,
    input        sa,
    input        sb,
    input        db,
    input  [52:0] fa,
    input  [52:0] fb,
    input  [10:0] ea,
    input  [10:0] eb,
    input  [5:0]  lza,
    input  [5:0]  lzb,
    input  [52:0] nan,
    input  [3:0]  fla,
    input  [3:0]  flb,

    output [56:0] fq,
    output [12:0] eq,
    output        sq,
    output [57:0] flq
);

sigfmd sig(
    .clk(clk),
    .rst_n(rst_n),
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

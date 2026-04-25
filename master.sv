`include "./components/adder/adder.sv"
`include "./components/unpacker/unpackermaster.sv"
`include "./components/rounder/rounder.sv"
`include "./components/multiplier/muldiv.sv"

module master  (
    input        clk,
    input        rst_n,
    input [63:0] fpa,
    input [63:0] fpb,
    input db,
    input md,
    input normal,
    input sub,
    input fdiv,
    input [1:0] RM,

    output [63:0] fp,
    output [4:0] IEEEp
);

wire [5:0]  lza, lzb;
wire [3:0]  fla, flb;
wire [10:0] ea, eb;
wire [52:0] nan;
wire [52:0] fa, fb;
wire        sa, sb;

unpackermaster unpack(
    .FA2(fpa),
    .FB2(fpb),
    .sa(sa),
    .sb(sb),
    .ea(ea),
    .eb(eb),
    .db(db),
    .normal(normal),
    .fa(fa),
    .fb(fb),
    .lza(lza),
    .lzb(lzb),
    .fla(fla),
    .flb(flb),
    .nan(nan)
);

wire ss;
wire [10:0] es;
wire [56:0] fs;
wire [57:0] fls;

adder add(
    .fa(fa),
    .ea(ea),
    .sa(sa),
    .fb(fb),
    .eb(eb),
    .sb(sb),
    .sub(sub),
    .fla(fla),
    .flb(flb),
    .nan(nan),
    .RM(RM),
    .es(es),
    .fs(fs),
    .ss(ss),
    .fls(fls)
);

wire [56:0] fq;
wire [12:0] eq;
wire sq;
wire [57:0] flq;

muldiv mul(
    .clk(clk),
    .rst_n(rst_n),
    .fdiv(fdiv),
    .sa(sa),
    .sb(sb),
    .db(db),
    .fa(fa),
    .fb(fb),
    .ea(ea),
    .eb(eb),
    .lza(lza),
    .lzb(lzb),
    .nan(nan),
    .fla(fla),
    .flb(flb),
    .fq(fq),
    .eq(eq),
    .sq(sq),
    .flq(flq)
);

wire OVFen = 1'b0;
wire UNFen = 1'b0;

wire s;
wire [12:0] er;
wire [56:0] fr;
wire [57:0] flr;

assign s = md ? sq : ss;
assign er = md ? eq : {es[10], es[10], es[10:0]};
assign fr = md ? fq : fs;
assign flr = md ? flq : fls;

rounder rnd_add(
    .db(db),
    .s(s),
    .er(er),
    .fr(fr),
    .OVFen(OVFen),
    .UNFen(UNFen),
    .flr(flr),
    .RM(RM),
    .IEEEp(IEEEp),
    .fp(fp)
);

endmodule

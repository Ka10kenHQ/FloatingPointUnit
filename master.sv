`include "./components/adder/adder.sv"
`include "./components/unpacker/unpackermaster.sv"
`include "./components/rounder/rounder.sv"
`include "./components/multiplier/muldiv.sv"

module master  (
    input [63:0] fpa,
    input [63:0] fpb,
    input db,
    input normal,
    input sub,
    input fdiv,
    input [1:0] RM,

    output [63:0] fp_mul_out,
    output [4:0] IEEp_mul,
    output sp_mul_out,
    output [10:0] ep_mul_out,
    output [51:0] f_mul_out,

    output [63:0] fp_add_out,
    output [4:0] IEEp_add,
    output sp_add_out,
    output [10:0] ep_add_out,
    output [51:0] f_add_out
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

rounder rnd_add(
    .db(db),
    .s(ss),
    .er({es[10], es[10], es[10:0]}),
    .fr(fs),
    .OVFen(OVFen),
    .UNFen(UNFen),
    .flr(fls),
    .RM(RM),
    .IEEEp(IEEp_add),
    .fp(fp_add_out),
    .sp_out(sp_add_out),
    .ep_out(ep_add_out),
    .f_out(f_add_out)
);

rounder rnd_mul(
    .db(db),
    .s(sq),
    .er(eq),
    .fr(fq),
    .OVFen(OVFen),
    .UNFen(UNFen),
    .flr(flq),
    .RM(RM),
    .IEEEp(IEEp_mul),
    .fp(fp_mul_out),
    .sp_out(sp_mul_out),
    .ep_out(ep_mul_out),
    .f_out(f_mul_out)
);

endmodule


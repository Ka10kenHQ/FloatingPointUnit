`include "./components/adder/adder.sv";
`include "./components/unpacker/unpackermaster.sv";
`include "./components/rounder/rounder.sv"

module master  (
    input [63:0] fpa,
    input [63:0] fpb,
    input db,
    input normal,
    input sub,
    input [1:0] RM,

    output [63:0] fp_out,
    output [4:0] IEEp
);

wire sa, sb;
wire [10:0] ea,eb;
wire [5:0] lza,lzb;
wire [3:0] fla, flb;
wire [52:0] nan;
wire [52:0] fa,fb;


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

wire [10:0] es;
wire [56:0] fs;
wire ss;
wire [1:0] fls;

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

// TODO: flags to add
wire OVFen = 1'b0;
wire UNFen = 1'b0;

rounder rnd(
    .db(db),
    .s(ss),
    .er(es),
    .fr(fs),
    .OVFen(OVFen),
    .UNFen(UNFen),
    .flr({5'b0, nan}),
    .RM(RM),
    .IEEEp(IEEp),
    .fp(fp_out)
);


endmodule

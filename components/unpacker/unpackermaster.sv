`include "./unpacker.sv"

module unpackermaster(
    input [63:0] FA2,
    input [63:0] FB2,
    input db,
    input normal,

    output [0:0] sa,
    output [10:0] ea,
    output [5:0] lza,
    output [52:0] fa,
    output [3:0] fla,
    
    output [0:0] sb,
    output [10:0] eb,
    output [5:0] lzb,
    output [52:0] fb,
    output [3:0] flb,

    output [52:0] nan
);

wire e_inf1, s1, fz1, e_z1, e_inf2, s2, fz2, e_z2;
wire snan;
wire [51:0] fnan;
wire ZEROa, INFa, SNANa, NANa;
wire ZEROb, INFb, SNANb, NANb;
wire [10:0] e1, e2;
wire [5:0] lz1, lz2;
wire [51:0] h1, h2;
wire [52:0] f1, f2;

unpacker a(
    .fp(FA2),
    .db(db),
    .normal(normal),
    .e_inf(e_inf1),
    .e_z(e_z1),
    .e(e1),
    .s(s1),
    .lz(lz1),
    .f(f1),
    .fz(fz1),
    .h(h1)
);

unpacker b(
    .fp(FB2),
    .db(db),
    .normal(normal),
    .e_inf(e_inf2),
    .e_z(e_z2),
    .e(e2),
    .s(s2),
    .lz(lz2),
    .f(f2),
    .fz(fz2),
    .h(h2)
);

exceptions e (
    .e_inf(e_inf1),
    .h_1(h1[0]),
    .fz(fz1),
    .ez(e_z1),
    .ZERO(ZEROa),
    .INF(INFa),
    .NAN(NANa),
    .SNAN(SNANa)
);

exceptions exc (
    .e_inf(e_inf2),
    .h_1(h2[0]),
    .fz(fz2),
    .ez(e_z2),
    .ZERO(ZEROb),
    .INF(INFb),
    .NAN(NANb),
    .SNAN(SNANb)
);

nanselect nansel(
    .sa(s1),
    .ha(h1),
    .hb(h2),
    .sb(s2),
    .nana(NANa),
    .snan(snan),
    .fnan(fnan)
);

assign sa = s1;
assign ea = e1;
assign lza = lz1;
assign fa = f1;
assign fla[3] = ZEROa;
assign fla[2] = INFa;
assign fla[1] = SNANa;
assign fla[0] = NANa;
assign nan = {snan, fnan};
assign sb = s2;
assign eb = e2;
assign lzb = lz2;
assign fb = f2;
assign flb[3] = ZEROb;
assign flb[2] = INFb;
assign flb[1] = SNANb;
assign flb[0] = NANb;

endmodule


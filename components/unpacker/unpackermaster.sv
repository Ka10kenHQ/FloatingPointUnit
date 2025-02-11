`include "./unpacker.sv"

module unpackermaster(
    input [63:0] FA2,
    input [63:0] FB2,
    input db,
    input normal,

    output reg sa,
    output reg [10:0] ea,
    output reg [5:0] lza,
    output reg [52:0] fa,
    output reg [3:0] fla,
    
    output reg sb,
    output reg [10:0] eb,
    output reg [5:0] lzb,
    output reg [52:0] fb,
    output reg [3:0] flb,

    output reg [52:0] nan
);

reg e_inf1,s1,fz1, e_z1, e_inf2, s2,fz2,e_z2;

wire snan;
wire [51:0] fnan;

wire ZEROa, INFa, SNANa, NANa;
wire ZEROb,INFb,SNANb,NANb;

wire [10:0] e1,e2;

wire [5:0] lz1,lz2;

wire [51:0] h1,h2;
wire [52:0] f1,f2;

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

always @(*)  begin
    sa = s1;
    ea = e1;
    lza = lz1;
    fa = f1;
    fla[3] = ZEROa;
    fla[2] = INFa;
    fla[1] = SNANa;
    fla[0] = NANa;
    nan = {snan, fnan};
    sb = s2;
    eb = e2;
    lzb= lz2;
    fb = f2;
    flb[3] = ZEROb;
    flb[2] = INFb;
    flb[1] = SNANb;
    flb[0] = NANb;
end    

endmodule

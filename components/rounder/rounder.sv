module rounder(
    input db,
    input s,
    // TODO: this is 13 bits but adder output is 11 bits 
    input [12:0] er,
    input [56:0] fr,
    input OVFen,
    input UNFen,
    input [57:0] flr,
    input [1:0] RM,

    output [4:0] IEEEp,
    output [63:0] fp,
    output sp_out,
    output [10:0] ep_out,
    output [51:0] f_out
);

wire [127:0] fn;
wire [10:0] eni;
wire [10:0] en;
wire TINY, OVF1;

normshift nshift(
    .er(er),
    .fr(fr),
    .OVFen(OVFen),
    .UNFen(UNFen),
    .db(db),
    .fn(fn),
    .eni(eni),
    .en(en),
    .TINY(TINY),
    .OVF1(OVF1)
);


wire [54:0] fl;

rept rpt(
    .fn(fn),
    .db(db),
    .f1(fl)
);

wire [53:0] f2;
wire siginx;

sigrnd signd(
    .s(s),
    .db(db),
    .f1(fl),
    .RM(RM),
    .f2(f2),
    .siginx(siginx)
);

wire sigovf;
wire [10:0] e2;
wire [52:0] f3;

postnorm pnorm(
    .en(en),
    .eni(eni),
    .f2(f2),
    .sigovf(sigovf),
    .e2(e2),
    .f3(f3)
);


wire [10:0] e3;
wire OVF;

adjexp adje(
    .e2(e2),
    .db(db),
    .sigovf(sigovf),
    .OVFen(OVFen),
    .e3(e3),
    .OVF(OVF)
);

wire [10:0] eout;
wire [51:0] fout;

exprnd exprn(
    .s(s),
    .e3(e3),
    .f3(f3),
    .RM(RM),
    .OVF(OVF),
    .db(db),
    .OVFen(OVFen),
    .eout(eout),
    .fout(fout)
);

specfprnd specpnd(
    .s(s),
    .eout(eout),
    .fout(fout),
    .siginx(siginx),
    .db(db),
    .nan(flr[52:0]),
    .OVFen(OVFen),
    .UNFen(UNFen),
    .OVF(OVF),
    .TINY(TINY),
    .ZERO(flr[57]),
    .NAN(flr[56]),
    .INF(flr[55]),
    .INV(flr[54]),
    .DBZ(flr[53]),
    .fp_out(fp),
    .sp_out(sp_out),
    .ep_out(ep_out),
    .f_out(f_out),
    .IEEEp(IEEEp)
);


endmodule

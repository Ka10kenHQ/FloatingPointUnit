module normshift(
    input [56:0] fr,
    input [12:0] er,
    input OVFen,
    input UNFen,

    input db,

    output [127:0] fn,
    output [10:0] eni,
    output [10:0] en,
    output TINY,
    output OVF1
);

wire tiny, ovf1;
wire [5:0] lz;
wire [12:0] sh;

flags flgs(
    .fr(fr),
    .er(er),
    .db(db),
    .TINY(tiny),
    .OVF1(ovf1),
    .lz(lz)
);

expnorm exp(
    .er(er[10:0]),
    .lz(lz),
    .db(db),
    .OVFen(OVFen),
    .OVF1(ovf1),
    .UNFen(UNFen),
    .TINY(tiny),
    .eni(eni),
    .en(en)
);

shiftdist sdist(
    .er(er),
    .lz(lz),
    .db(db),
    .TINY(tiny),
    .UNFen(UNFen),
    .sh(sh)
);


signormshift signshift(
    .fr(fr),
    .sh(sh),
    .fn(fn)
);

assign TINY = tiny;
assign OVF1 = ovf1;

endmodule

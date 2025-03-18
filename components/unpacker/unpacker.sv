module unpacker(
    input [63:0]       fp,
    input              db,
    input              normal,

    output             e_inf,
    output             e_z,
    output [10:0]      e,
    output             s,
    output [5:0]       lz,
    output [52:0]      f,
    output             fz,
    output [52:0]      h
);

assign s = fp[63];

exponent exponent_inst(
    .fp(fp),
    .db(db),
    .e_inf(e_inf),
    .e_z(e_z),
    .e(e)
);

significant unpacker_inst(
    .db(db),
    .fp(fp),
    .e_z(e_z),
    .normal(normal),
    .lz(lz),
    .f(f),
    .fz(fz),
    .h(h)
);

endmodule

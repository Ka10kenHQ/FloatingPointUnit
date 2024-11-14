module unpackermaster(
    input [63:0] fp,
    input db,
    input normal,
    output reg         e_inf,
    output reg         e_z,
    output reg [10:0]  e,
    output reg s,
    output reg [5:0] lz,
    output reg [52:0] f,
    output reg fz,
    output reg [51:0] h  
);

exponent exponent_inst(
    .fp(fp),
    .db(db),
    .e_inf(e_inf),
    .e_z(e_z),
    .e(e),
    .s(s)
);

unpacker unpacker_inst(
    .db(db),
    .x(fp),
    .e_z(e_z),
    .normal(normal),
    .lz(lz),
    .f(f),
    .fz(fz),
    .h(h)
);


endmodule
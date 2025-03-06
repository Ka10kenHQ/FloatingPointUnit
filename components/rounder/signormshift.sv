`include "./../unpacker/cls.sv"

module signormshift(
    input [56:0] fr,
    input [12:0] sh,

    output [127:0] fn
);


wire [63:0] v, w, fs;

parameter n = 64;

cls #(n) cl(
    .m(sh[5:0]),
    .x({fr, 7'b0}),
    .y(fs)
);

mask msk(
    .sh(sh),
    .v(v),
    .w(w)
);

assign fn[63:0] = fs & w;
assign fn[127:64] = fs & v;

endmodule

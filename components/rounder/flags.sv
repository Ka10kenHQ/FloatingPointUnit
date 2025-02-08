`include "./../unpacker/leadingzero.sv"

module flags(
    input  [56:0] fr,
    input  [12:0] er,
    input         db,

    output        TINY,
    output        OVF1,
    output [5:0]  lz
);

wire [6:0] lz_out;
wire w1, w2, w3, w4, w5, eq;
wire [12:0] add;
wire [12:0] emax = {3'b0, {3{db}}, {7{1'b1}}};

leadingzero lzero(
    .x({fr, 7'b1111111}),
    .y(lz_out)
);

assign lz = lz_out[5:0];

assign add = er + {3'b0, {3{db}}, 1'b1, ~lz_out[5:0]};
assign TINY = add[12];

assign OVF1 = (fr[0] & (er > emax - 1)) | 
              (fr[1] & (er > emax)) | 
              (fr[2] & (er > emax + 1));


endmodule


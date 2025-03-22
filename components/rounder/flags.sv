`include "./../unpacker/leadingzero.sv"
`include "./../../utils/add.sv"

module flags(
    input  [56:0]  fr,
    input  [12:0]  er,
    input          db,

    output         TINY,
    output         OVF1,
    output  [5:0]  lz
);

wire [6:0] lz_out;

wire [12:0] emax;
assign emax = {3'b0, {3{db}}, {7{1'b1}}};

leadingzero lzero(
    .x({fr, 7'b1111111}),
    .y(lz_out)
);

wire [13:0] sum;

parameter n = 13;
add #(n) ad(
    .a({3'b0, {3{db}}, 1'b1,  ~lz[5:0]}),
    .b(er[12:0]),
    .c_in(1'b0),
    .sum(sum)
);

assign lz = lz_out[5:0];
assign TINY = sum[12];

assign OVF1 = (fr[56] & (er >= emax)) | 
              (fr[55] & (er > emax)) | 
              (fr[54] & (er > emax + 1));

endmodule


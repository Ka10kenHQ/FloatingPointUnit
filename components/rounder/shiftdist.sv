`include "./../../utils/add.sv"

module shiftdist(
    input [12:0] er,
    input [5:0] lz,

    input db,

    input TINY,
    input UNFen,

    output [12:0] sh
);

wire [12:0] emax;
assign emax = {3'b0, {3{db}}, {7{1'b1}}};

parameter n = 13;
wire [13:0] sum;

add #(n) ad(
    .a(er[12:0]),
    .b(emax[12:0]),
    .c_in(1'b0),
    .sum(sum)
);

assign sh = (TINY & ~UNFen) ? sum[12:0] : {7'b0, lz[5:0]};

endmodule

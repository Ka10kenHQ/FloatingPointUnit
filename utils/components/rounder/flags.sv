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
wire [12:0] emax = 13'b1111_1111_1111;

leadingzero lzero(
    .x({fr, 7'b1111111}),
    .y(lz_out)
);

assign lz = lz_out[5:0];

assign add = er + {3'b0, {3{db}}, 1'b1, ~lz_out[5:0]};
assign TINY = add[12];

assign w1 = ~er[12];           
assign w2 = er[11] | er[10];
assign w3 = w1 | w2;
assign w4 = er[9] | er[8] | er[7];
assign w5 = w4 & ~db;
assign eq = (er == emax);      

assign OVF1 = (w3 | w5) | (eq & fr[56]);

endmodule


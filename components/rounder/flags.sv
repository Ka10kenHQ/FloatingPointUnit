`include "./../unpacker/leadingzero.sv"

module flags(
    input  [56:0]     fr,
    input  [12:0]     er,
    input             db,

    output reg        TINY,
    output reg        OVF1,
    output reg [5:0]  lz
);

wire [6:0] lz_out;

reg [12:0] add;
reg [12:0] emax = {3'b0, {3{db}}, {7{1'b1}}};

leadingzero lzero(
    .x({fr, 7'b1111111}),
    .y(lz_out)
);

always @(*) begin
    lz = lz_out[5:0];
    add = er + {3'b0, {3{db}}, 1'b1, ~lz[5:0]};
    TINY = add[12];
    OVF1 = (fr[56] & (er > emax - 1)) | 
              (fr[55] & (er > emax)) | 
              (fr[54] & (er > emax + 1));
end


endmodule


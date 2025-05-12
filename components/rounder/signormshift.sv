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
    .x({fr[56:0], 7'b0}),
    .y(fs)
);

mask msk(
    .sh(sh),
    .v(v),
    .w(w)
);

assign fn[127:64] = bitwise_and(fs, v);
assign fn[63:0]   = bitwise_and(fs, w);

function automatic [63:0] bitwise_and(input [63:0] a, input [63:0] b);
    integer i;
    for (i = 0; i < 64; i = i + 1) begin
        bitwise_and[i] = a[i] & b[i];
    end
endfunction

endmodule

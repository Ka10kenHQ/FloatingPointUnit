`include "./../unpacker/cls.sv"

module signormshift(
    input [56:0] fr,
    input [12:0] sh,

    output reg [127:0] fn
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

always @(*) begin
    fn[63:0] = and_64(fs, v);
    fn[127:64] = and_64(fs, w);
end

function [63:0] and_64(input [63:0] ina, input [63:0] inb);
    integer i;
    begin
        for (i = 0; i < 64; i = i + 1)
            and_64[i] = ina[i] & inb[i];
    end
endfunction


endmodule

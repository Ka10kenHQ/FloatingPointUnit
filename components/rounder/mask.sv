`include "./../../utils/ortree.sv"
`include "./../../utils/HDecJ.sv"

module mask(
    input [12:0] sh,
    output reg [63:0] v,
    output reg [63:0] w
);

reg [11:0] t;
reg [5:0] shp;
reg [63:0] u; 

wire w1;
wire [63:0] h;

parameter n = 6;

ortree #(n) or_tree(
    .x(t[11:6]),
    .or_out(w1)
);

HDecJ #(n) hdec(
    .x(shp),
    .y(h)
);

always @(*) begin
    t = sh[11] ? ~sh[11:0] : sh[11:0];

    shp = w1 ? 6'b111111 : t[5:0];

    u = sh[12] ? flip_bits({h[62:0], 1'b1}) : h;

    v = ~u;
    w = u & sh[12];

end

function [63:0] flip_bits(input [63:0] in);
    integer i;
    begin
        for (i = 0; i < 64; i = i + 1)
            flip_bits[i] = in[63 - i];
    end
endfunction

endmodule


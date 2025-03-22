`include "./../../utils/ortree.sv"
`include "./../../utils/HDecJ.sv"

module mask(
    input  [12:0] sh,
    output [63:0] v,
    output [63:0] w
);

wire w1;

wire [11:0] t;
wire [5:0] shp;
wire [63:0] h;
wire [63:0] u;

assign t = sh[11] ? ~sh[11:0] : sh[11:0];

parameter n = 6;
ortree #(n) or_tree(
    .x(t[11:6]),
    .or_out(w1)
);


assign shp = w1 ? 6'b111111 : t[5:0];

HDecJ #(.N(n)) hdec(
    .x(shp),
    .y(h)
);

assign u = sh[12] ? flip_bits({h[62:0], 1'b1}) : h[63:0];

assign v = ~u;
assign w = u & {64{sh[12]}};


function automatic [63:0] flip_bits(input [63:0] in);
    integer i;
    reg [63:0] temp;
begin
    for (i = 0; i < 64; i = i + 1)
        temp[i] = in[63 - i];
    flip_bits = temp;
end
endfunction

endmodule


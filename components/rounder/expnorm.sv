`include "./../../utils/three2add.sv"
`include "./../../utils/add.sv"

module expnorm(
    input [10:0] er,
    input [5:0] lz,
    input db,
    input OVFen,
    input OVF1,
    input UNFen,
    input TINY,
    output [10:0] eni,
    output [10:0] en
);

wire [1:0] w1;
wire [1:0] w2;
wire [4:0] delta;
wire [10:0] c;
wire [10:0] b;
wire [10:0] emin;
wire [10:0] emin1;

wire [11:0] t, s;

assign w1 = (OVFen & OVF1) ? 2'b11 : 2'b10;
assign w2 = (UNFen & TINY) ? 2'b01 : w1;

assign delta = db ? {w2, 3'b0} : {3'b0, w2};
assign c = {delta, 6'b0};
assign b = {5'b11111, ~lz[5:0]};

three2add add (
    .a(er),
    .b(b),
    .c(c),
    .t(t),
    .s(s)
);

parameter n = 11;
wire [11:0] sum;
add #(n) ad(
    .a(t[10:0]),
    .b(s[10:0]),
    .c_in(1'b1),
    .sum(sum)
);

assign emin = 11'b00000000001;
assign emin1 = 11'b00000000010;

assign en = (~UNFen & TINY) ? emin : sum[10:0];
assign eni = (~UNFen & TINY) ? emin1 : sum[10:0] + 1;

endmodule


`include "./../../utils/add.sv"

module sigadd(
    input [52:0] fa2,
    input [55:0] fb3,
    input  sa2,
    input  sb2,
    input  sx, 
    output [56:0] fs,
    output reg fszero,
    output reg ss1
);

wire [57:0] a, b;
parameter n = 58;
wire [58:0] sum;

assign a = {2'b00, fa2[52:0],3'b000};
assign b = {2'b00^{2{sx}}, fb3^{56{sx}}};

add #(n) ad(
    .a(a),
    .b(b),
    .c_in(sx),
    .sum(sum)
);

wire [57:0] res;
assign res = sum[57:0];
assign fszero = (res == 58'b0);

assign neg = res[57];
assign ss1 = (sb2 & neg) | (sa2 & ~(sb2 & neg));

abs ut(
    .x(res),
    .abs(fs)
);

endmodule

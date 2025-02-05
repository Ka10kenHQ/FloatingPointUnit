module sigadd(
    input [52:0] fa2,
    input [55:0] fb3,
    input  sa2,
    input  sb2,
    input  sx, 
    output reg[56:0] fs,
    output reg fszero,
    output reg ss1
);
reg neg;
reg[57:0] first,second;
reg[57:0] res;

abs ut(
    .x(res),
    .abs(fs)
);

always@(*)begin
    first = {{2'b00, fa2},3'b000};
    second = {{2'b00^sx, fb3^sx},sx};
    res = first + second;
    fszero = res[57:0] != 58'b0;
    neg = res[57];
    ss1 = (sb2 & neg) | (sa2 & ~(sb2 & neg));
end 

endmodule

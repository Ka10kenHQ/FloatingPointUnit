module sigadd(
    input [52:0] fa2,
    input [55:0] fb3,
    input  sa2,
    input  sb2,
    input  sx, 
    output reg[57:0] fs,
    output reg fszero,
    output reg ss1,
    output reg ovf
);
reg neg;
reg[57:0] first,second;
reg[59:0] res;

abs #(58) ut(
    .x(res[58:0]),
    .abs(fs)
);

always@(*)begin
    first = {{2'b00, fa2},3'b000};
    second = {{2'b00^sx, fb3^sx},sx};
    res = first + second;
    ovf = res[59];
    fszero = res[58:0] != 58'b0;
    neg = res[58];
    ss1 = (sb2 & neg)|(sa2 & ~(sb2 & neg));
end 
endmodule

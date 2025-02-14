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
reg[57:0] a, b;
reg[57:0] res;

abs ut(
    .x(res),
    .abs(fs)
);

always@(*)begin
    a = {2'b00, fa2[52:0],3'b000};
    b = {2'b00^{2{sx}}, fb3^{56{sx}}};
    
    res = a + b + sx;

    fszero = (res[57:0] == 58'b0);
    
    neg = res[57];
    
    ss1 = (sb2 & neg) | (sa2 & ~(sb2 & neg));
end 

endmodule

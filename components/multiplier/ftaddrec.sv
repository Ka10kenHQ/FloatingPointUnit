module ftaddrec #(parameter n = 58) (
    input [115:0] partials[n-1:0],
    output reg [115:0] t,
    output reg [115:0] s
);
integer i;
reg [115:0] sum1,sum2,sum3, sum4,sum5, sum6;
reg [116:0] carry, sum;

localparam npof = 2 ** $clog2(n);

reg [115:0] partials1[npof-1:0];


always @(*) begin
    for (i = 0; i < npof; i = i + 1) begin
        if (i < n)
            partials1[i] = partials[i];
        else
            partials1[i] = 0;
    end
end


generate 
if (npof > 4) begin
    ftaddrec #(npof/2) zur1(
        .partials(partials1[npof/2-1:0]),
        .t(sum1),
        .s(sum2)
    );

    ftaddrec #(npof/2) zur2(
        .partials(partials1[npof-1:npof/2]),
        .t(sum3),
        .s(sum4)
    );



always @(*) begin
    carry[0] = 0;

    for (i = 0; i < 116; i = i + 1) begin
        sum5 = sum1[i] + sum2[i] + sum3[i];

        sum[i] = sum5[0];
        carry[i+1] = sum5[1];
    end
    sum[116] = 0;

    t[0] = 0;
    for (i = 0; i < 116; i = i + 1) begin
        sum6 = sum[i] + carry[i] + sum4[i];

        s[i] = sum6[0];
        t[i+1] = sum6[1];
    end
    
end
end
else begin : Base

always @(*) begin
    carry[0] = 0;

    for (i = 0; i < 116; i = i + 1) begin
        sum5 = partials[0][i] + partials[1][i] + partials[2][i];

        sum[i] = sum5[0];
        carry[i+1] = sum5[1];
    end
    sum[116] = 0;

    t[0] = 0;
    for (i = 0; i < 116; i = i + 1) begin
        sum6 = sum[i] + carry[i] + partials[3][i];

        s[i] = sum6[0];
        t[i+1] = sum6[1];
    end
    
end
end
endgenerate
endmodule



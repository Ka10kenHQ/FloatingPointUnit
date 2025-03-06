module ftaddrec #(parameter n = 58) (
    input [115:0] partials[n-1:0],
    output [115:0] t,
    output [115:0] s
);

wire [115:0] sum1, sum2, sum3, sum4;
wire [116:0] carry, sum;

localparam npof = 2 ** $clog2(n);

wire [115:0] partials1 [npof-1:0];

genvar j;
generate
    for (j = 0; j < npof; j = j + 1) begin
        assign partials1[j] = (j < n) ? partials[j] : 0;
    end
endgenerate

genvar i;
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

    assign carry[0] = 0;

    for (i = 0; i < 116; i = i + 1) begin
        wire [1:0] sum5;

        assign sum5 = sum1[i] + sum2[i] + sum3[i];
        assign sum[i] = sum5[0];
        assign carry[i+1] = sum5[1];
    end
     
    assign sum[116] = 0;

    assign t[0] = 0;

    for (i = 0; i < 115; i = i + 1) begin
        wire [1:0] sum6;
        assign sum6 = sum[i] + carry[i] + sum4[i];
        assign s[i] = sum6[0];
        assign t[i+1] = sum6[1];
    end
    wire [1:0] sum6;
    assign sum6 = sum[115] + carry[115] + sum4[115];
    assign s[115] = sum6[0];
        
end else begin : Base

    assign carry[0] = 0;

    for (i = 0; i < 116; i = i + 1) begin
        wire [1:0] sum5;

        assign sum5 = partials1[0][i] + partials1[1][i] + partials1[2][i];
        assign sum[i] = sum5[0];
        assign carry[i+1] = sum5[1];
    end

    assign sum[116] = 0;

    assign t[0] = 0;

    for (i = 0; i < 115; i = i + 1) begin
        wire [1:0] sum6;

        assign sum6 = sum[i] + carry[i] + partials1[3][i];
        assign s[i] = sum6[0];
        assign t[i+1] = sum6[1];
    end
    wire [1:0] sum6;

    assign sum6 = sum[115] + carry[115] + partials1[3][115];
    assign s[115] = sum6[0];
        
end
endgenerate

endmodule

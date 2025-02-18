module ftaddrec #(parameter n = 58) (
    input [115:0] partials[n-1:0],
    output reg [115:0] out1,
    output reg [115:0] out2
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
		.out1(sum1),
		.out2(sum2)
		);

		ftaddrec #(npof/2) zur2(
			.partials(partials1[npof-1:npof/2]),
			.out1(sum3),
			.out2(sum4)
	   );



always @(*) begin
    carry[0] = 0;

    for (i = 0; i < 116; i = i + 1) begin
        sum5 = sum1[i] + sum2[i] + sum3[i];

        sum[i] = sum5[0];
        carry[i+1] = sum5[1];
    end
    sum[116] = 0;

    out1[0] = 0;
    for (i = 0; i < 116; i = i + 1) begin
        sum6 = sum[i] + carry[i] + sum4[i];

        out2[i] = sum6[0];
        out1[i+1] = sum6[1];
    end
    out2[116] = 0;
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

    out1[0] = 0;
    for (i = 0; i < 116; i = i + 1) begin
        sum6 = sum[i] + carry[i] + partials[3][i];

        out2[i] = sum6[0];
        out1[i+1] = sum6[1];
    end
    out2[116] = 0;
end
end
endgenerate
endmodule



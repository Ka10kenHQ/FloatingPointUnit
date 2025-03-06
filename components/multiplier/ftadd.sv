module ftadd #(parameter n = 13) (
    input [n-1:0] a,
    input [n-1:0] b,
    input [n-1:0] c,
    input [n-1:0] d,
    output [n:0] t,
    output [n:0] s
);

integer i;
wire [n+1:0] carry, sum;

// NOTE: this carry = 1 from the construction of sigexpmd
assign carry[0] = 1'b1;

assign sum[n] = 1'b0;
assign t[0] = 1'b0;
assign s[n] = 1'b0;

genvar j;
generate
    for (j = 0; j < n; j = j + 1) begin : sum_carry_gen
        wire [1:0] temp_sum1 = a[j] + b[j] + c[j];
        assign sum[j] = temp_sum1[0];
        assign carry[j+1] = temp_sum1[1];
    end
endgenerate

generate
    for (j = 0; j < n; j = j + 1) begin : t_s_gen
        wire [1:0] temp_sum2 = sum[j] + carry[j] + d[j];
        assign s[j] = temp_sum2[0];
        assign t[j+1] = temp_sum2[1];
    end
endgenerate

endmodule


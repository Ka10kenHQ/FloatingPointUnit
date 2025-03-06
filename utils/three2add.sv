module three2add #(parameter n = 11) (
    input [n-1:0] a,
    input [n-1:0] b,
    input [n-1:0] c,
    output [n:0] t,
    output [n:0] s
);
genvar i;
assign t[0] = 0;

generate
for (i = 0; i < n; i = i + 1) begin : add_bits
    wire [1:0] temp_sum = a[i] + b[i] + c[i];
    assign s[i] = temp_sum[0];
    assign t[i+1] = temp_sum[1];
end
endgenerate

assign s[n] = 0;
endmodule


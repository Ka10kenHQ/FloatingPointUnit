module add #(parameter n = 10) (
    input  [n-1:0] a,
    input  [n-1:0] b,
    input          c_in,
    output [n:0]   sum
);

wire [n-1:0] p, g;
wire [n:0]   c;

assign c[0] = c_in;

genvar i;
generate
for (i = 0; i < n; i = i + 1) begin : pg_calc
    assign g[i] = a[i] & b[i];
    assign p[i] = a[i] ^ b[i];
end
endgenerate

generate
for (i = 0; i < n; i = i + 1) begin : carry_calc
    assign c[i+1] = g[i] | (p[i] & c[i]);
end
endgenerate

generate
for (i = 0; i < n; i = i + 1) begin : sum_calc
    assign sum[i] = p[i] ^ c[i];
end
endgenerate

assign sum[n] = c[n];

endmodule


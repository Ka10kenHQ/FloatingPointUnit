module add #(parameter n = 10) (
    input  [n-1:0]     a,
    input  [n-1:0]     b,
    input              c_in,
    output reg [n:0] sum
);

reg [n-1:0] p, g;
reg [n:0] c;
integer i;


always @(*) begin
    c[0] = c_in;
    for (i = 0; i < n; i = i + 1) begin
        g[i] = a[i] & b[i];
        p[i] = a[i] ^ b[i];
    end

    for (i = 0; i < n; i = i + 1) begin
        c[i+1] = g[i] | (p[i] & c[i]);
    end

    for (i = 0; i < n; i = i + 1) begin
        sum[i] = p[i] ^ c[i];
    end
    sum[n] = c[n];
end

endmodule


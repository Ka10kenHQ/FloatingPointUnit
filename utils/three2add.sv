`ifndef THREE2ADD_SV
`define THREE2ADD_SV

module three2add #(parameter n = 11) (
    input [n-1:0] a,
    input [n-1:0] b,
    input [n-1:0] c,
    input         c_in,
    output [n:0]  t,
    output [n:0]  s
);
genvar i;
assign t[0] = c_in;

generate
for (i = 0; i < n; i = i + 1) begin : add_bits

    // full adder computation
    wire c_p = (a[i] & b[i]) | (a[i] & c[i]) | (b[i] & c[i]);
    wire s_p = a[i] ^ b[i] ^ c[i];

    assign s[i] = s_p;
    assign t[i+1] = c_p;
end
endgenerate

assign s[n] = 0;
endmodule

`endif


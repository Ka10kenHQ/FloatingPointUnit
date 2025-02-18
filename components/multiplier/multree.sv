module multree(
    input [57:0]       a,
    input [57:0]       b,
    output reg [115:0] out
);

reg [115:0] partials [57:0];
wire [115:0] t,s;

parameter n = 58;

ftaddrec #(n) re (
	.partials(partials),
	.t(t),
	.s(s)
);  

integer i, j;
always @(*) begin
  for (i = 0; i < 58; i++) begin
    partials[i] = 0;
    for (j = 0; j < 58; j++) begin
      partials[i][j] = a[i] & b[j];
    end
    partials[i] = partials[i] << i;
  end
  out = t + s;
end
endmodule


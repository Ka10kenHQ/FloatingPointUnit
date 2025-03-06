`include "./../../utils/add.sv"

module multree(
    input  [57:0]        a,
    input  [57:0]        b,
    output [115:0]       out
);

wire [115:0] partials [57:0];
wire [115:0] temp [57:0];
wire [115:0] t,s;


genvar i, j;
generate
  for (i = 0; i < 58; i++) begin
    assign temp[i][115:58] = 0;
    for (j = 0; j < 58; j++) begin
      assign temp[i][j] = a[i] & b[j];
    end
  end

  for(i=0; i < 58; i++) begin
    assign partials[i] = temp[i] << i;
  end
endgenerate

parameter n = 58;

ftaddrec #(n) ftadd(
  .partials(partials),
  .t(t),
  .s(s)
);  

parameter m = 116;
wire [116:0] sum;

add #(m) ad(
  .a(t),
  .b(s),
  .c_in(1'b0),
  .sum(sum)
);

assign out = sum[115:0];

endmodule


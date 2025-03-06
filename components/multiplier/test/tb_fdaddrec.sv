`include "../ftaddrec.sv"
module tb_fdaddrec;

  parameter n = 58;
  reg [115:0] partials[n-1:0];
  wire [115:0] out1, out2;
  
  ftaddrec #(n) uut (
    .partials(partials),
    .t(out1),
    .s(out2)
  );

  integer i;
  
  initial begin

    for (i = 0; i < n; i = i + 1) begin
      partials[i] = $random;
    end

    #10; 
  end

endmodule


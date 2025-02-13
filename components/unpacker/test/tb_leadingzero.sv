`include "./../leadingzero.sv"

module tb_leadingzero;

parameter n = 32;
parameter m = 5;

reg [n-1:0] x;
wire [m:0] y;

leadingzero #(n, m) uut (
  .x(x),
  .y(y)
);

initial begin

  x = 32'b00000000000000000000000000000000;
  #10;
  $display("y = %d", y);

  x = 32'b11111111111111111111111111111111;
  #10;
  $display("y = %d", y);

  x = 32'b10000000000000000000000000000000;
  #10;
  $display("y = %d", y);

  x = 32'b00000000000000001000000000000000;
  #10;
  $display("y = %d", y);

  x = 32'b00000000000000000000000000000001;
  #10;
  $display("y = %d", y);

  x = 32'b00000000000000000000000011111111;
  #10;
  $display("y = %d", y);

  x = 32'b00000000000000000011111111111111;
  #10;
  $display("y = %d", y);

  x = 32'b00000000000011111111111111111111;
  #10;
  $display("y = %d", y);

end

endmodule


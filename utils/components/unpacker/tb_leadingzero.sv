module tb_leadingzero;
 
  parameter n = 32;

  reg [n-1:0] x;
 
  wire [$clog2(n):0] y;
 
  leadingzero #(n) uut (
    .x(x),
    .y(y)
  );
 
 
  initial begin
 
 
    x = 32'b00000000000000000000000000000000;
    #90; // Expected 32 leading zeros
 
    x = 32'b11111111111111111111111111111111;
    #90; // Expected 0 leading zeros
 
    x = 32'b10000000000000000000000000000000;
    #90; // Expected 0 leading zeros
 
    x = 32'b00000000000000001000000000000000;
    #90;  // Expected 16 leading zeros
 
    // Single 1 at the least significant bit
    x = 32'b00000000000000000000000000000001;
    #90;  // Expected 31 leading zeros
 
    // Random test cases
    x = 32'b00000000000000000000000011111111;
    #90;  // Expected 24 leading zeros
 
    x = 32'b00000000000000000011111111111111;
    #90;  // Expected 16 leading zeros
 
    x = 32'b00000000000011111111111111111111;
     // Expected 8 leading zeros
 
  end
 
endmodule

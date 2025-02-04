`include "./../exceptions.sv"

module tb_exceptions;
  reg e_inf;
  reg h_1;
  reg fz;
  reg ez;
  wire ZERO;
  wire INF;
  wire NAN;
  wire SNAN;

  exceptions uut (
    .e_inf(e_inf),
    .h_1(h_1),
    .fz(fz),
    .ez(ez),
    .ZERO(ZERO),
    .INF(INF),
    .NAN(NAN),
    .SNAN(SNAN)
  );

  initial begin
    e_inf = 0; h_1 = 0; fz = 0; ez = 0; #10; // Test case 1
    e_inf = 1; h_1 = 0; fz = 0; ez = 0; #10; // Test case 2
    e_inf = 0; h_1 = 1; fz = 0; ez = 0; #10; // Test case 3
    e_inf = 0; h_1 = 0; fz = 1; ez = 0; #10; // Test case 4
    e_inf = 0; h_1 = 0; fz = 0; ez = 1; #10; // Test case 5
    e_inf = 1; h_1 = 1; fz = 0; ez = 0; #10; // Test case 6
    e_inf = 1; h_1 = 0; fz = 1; ez = 1; #10; // Test case 7
    e_inf = 1; h_1 = 1; fz = 1; ez = 0; #10; // Test case 8
  end

  initial begin
    $monitor("Time = %0t | e_inf = %b, h_1 = %b, fz = %b, ez = %b | ZERO = %b, INF = %b, NAN = %b, SNAN = %b", 
             $time, e_inf, h_1, fz, ez, ZERO, INF, NAN, SNAN);
  end

endmodule


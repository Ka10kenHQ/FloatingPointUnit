`include "./../exp_sub.sv"
module tb_exp_sub;

  reg [10:0] ea;
  reg [10:0] eb;
  wire eb_gt_ea;
  wire [10:0] as;

  exp_sub uut (
    .ea(ea),
    .eb(eb),
    .eb_gt_ea(eb_gt_ea),
    .as(as)
  );

  initial begin
    // ea = 11'b00000000001; eb = 11'b00000000000; #10; // Test case 1: ea > eb
    // ea = 11'b00000000010; eb = 11'b00000000001; #10; // Test case 2: ea > eb
    // ea = 11'b00000000001; eb = 11'b00000000001; #10; // Test case 3: ea == eb
    // ea = 11'b10000000000; eb = 11'b01000000000; #10; // Test case 4: ea < eb
    // ea = 11'b11111111111; eb = 11'b00000000000; #10; // Test case 5: ea > eb
    // ea = 11'b01010101010; eb = 11'b10101010101; #10; // Test case 6: ea < eb
    //
    // ea = 11'b11111111111; eb = 11'b10000000000; #10; // Test case 7: ea > eb
    // ea = 11'b00100100100; eb = 11'b00100100100; #10; // Test case 8: ea == eb
    ea = 11'b00000000001; eb = 11'b00000000001; #10;
    
  end

  initial begin
    $monitor("Time = %0t | ea = %d, eb = %d | eb_gt_ea = %d, as = %d", 
             $time, ea, eb, eb_gt_ea, as);
  end

endmodule


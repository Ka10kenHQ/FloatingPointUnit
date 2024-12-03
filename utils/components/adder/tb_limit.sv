module tb_limit;

    reg [10:0] as;    
    reg eb_gt_ea;        
    wire [5:0] as2;       

    limit uut (
        .as(as),
        .eb_gt_ea(eb_gt_ea),
        .as2(as2)
    );

    initial begin
        $display("Time | as           | eb_gt_ea | as2");
        $monitor("%4t | %b | %b        | %b", $time, as, eb_gt_ea, as2);

        as = 11'b00000000001; eb_gt_ea = 0; #10;  
        as = 11'b00000000001; eb_gt_ea = 1; #10; 
        as = 11'b11111111111; eb_gt_ea = 0; #10;
        as = 11'b11111111111; eb_gt_ea = 1; #10;
        as = 11'b10000000000; eb_gt_ea = 0; #10;
        as = 11'b10000000000; eb_gt_ea = 1; #10;
        as = 11'b01010101010; eb_gt_ea = 0; #10;
        as = 11'b01010101010; eb_gt_ea = 1; #10;

    end

endmodule


`include "./../ortree.sv"

module tb_ortree;

    parameter n = 8;
    reg [n-1:0] x;  
    wire or_out; 

    ortree #(n) uut (
        .x(x),
        .or_out(or_out)
    );

    initial begin
        $display("Time | x              | or_out");
        $monitor("%4t | %b | %b", $time, x, or_out);

        x = 8'b00000000; #10; // 0
        x = 8'b00000001; #10; // 1
        x = 8'b00010000; #10; // 1
        x = 8'b11111111; #10; // 1
        x = 8'b10000000; #10; // 1
        x = 8'b01010101; #10; // 1
        x = 8'b00100100; #10; // 1
        x = 8'b00000010; #10; // 1

    end

endmodule

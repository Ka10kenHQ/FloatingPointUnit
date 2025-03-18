`include "./../add.sv"

module tb_add;

    parameter n = 10;
    reg [n-1:0] a, b;
    reg c_in;
    wire [n:0] sum;

    add #(n) uut (
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum)
    );

    initial begin
        $monitor("Time = %0t | a = %d | b = %d | c_in = %d | sum = %d", $time, a, b, c_in, sum);

        a = 10'b0000000000; b = 10'b0000000000; c_in = 1'b1; #10;
        a = 10'b0000000001; b = 10'b0000000001; #10;
        a = 10'b0000111100; b = 10'b0000000011; #10;
        a = 10'b1111111111; b = 10'b0000000001; c_in = 1'b0; #10;
        a = 10'b1010101010; b = 10'b0101010101; #10;
        a = 10'b1100110011; b = 10'b1010101010; #10;
        a = 10'b0000000000; b = 10'b1111111111; #10;
        a = 10'b1111111111; b = 10'b1111111111; #10;

    end

endmodule


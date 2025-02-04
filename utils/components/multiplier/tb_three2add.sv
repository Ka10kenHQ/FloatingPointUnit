module tb_three2add;
    parameter n = 12;

    reg [n:0] a, b, c;

    wire [n+1:0] t, s;

    three2add #(n) uut (
        .a(a),
        .b(b),
        .c(c),
        .t(t),
        .s(s)
    );

    initial begin

        a = 13'b0000000000001; 
        b = 13'b0000000000010; 
        c = 13'b0000000000100; 
        #10;
        $display("a = %d, b = %d, c = %d, t = %b, s = %b, t + s = %d", a, b, c, t, s, t + s);

        
        a = 13'b1111111111111;
        b = 13'b0000000000001;
        c = 13'b0000000000001;
        #10;
        $display("a = %d, b = %d, c = %d, t = %b, s = %b, t + s = %d", a, b, c, t, s, t + s);


        a = 13'b1010101010101;
        b = 13'b0101010101010;
        c = 13'b0011001100110;
        #10;
        $display("a = %d, b = %d, c = %d, t = %b, s = %b, t + s = %d", a, b, c, t, s, t + s);

        a = 13'b0000000000000;
        b = 13'b0000000000000;
        c = 13'b0000000000000;
        #10;
        $display("a = %d, b = %d, c = %d, t = %b, s = %b, t + s = %d", a, b, c, t, s, t + s);

        
    end
endmodule

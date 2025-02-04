`include "./../signormshift.sv"

module tb_signormshift;

    reg [56:0] fr;
    reg [12:0] sh;
    wire [127:0] fn;

    signormshift uut (
        .fr(fr),
        .sh(sh),
        .fn(fn)
    );

    initial begin
        fr = 57'h123456789ABCDEF;
        sh = 13'b0101010101010;
        
        #10;
        fr = 57'hABCDEF123456789;
        sh = 13'b1110001110001;

        #10;
        $finish;
        $monitor("Time: %0t | fr: %h | sh: %b | fn: %h", $time, fr, sh, fn);
    end

endmodule


`include "./../specmd.sv"
module tb_specmd;

    reg [52:0] nan;
    reg [3:0] fla;
    reg [3:0] flb;
    reg fdiv;

    wire [57:0] flq;

    specmd uut (
        .nan(nan),
        .fla(fla),
        .flb(flb),
        .fdiv(fdiv),
        .flq(flq)
    );

    initial begin
        nan = 53'h0;
        fla = 4'b0000;
        flb = 4'b0000;
        fdiv = 0;

        #10 fla = 4'b1111; flb = 4'b0001; fdiv = 1;
        
        #10 fla = 4'b0101; flb = 4'b1010; fdiv = 0;
        
        #10 fla = 4'b1110; flb = 4'b0000; fdiv = 1;
        
        #10 fla = 4'b0000; flb = 4'b1111; fdiv = 0;
        
        #10 fla = 4'b1000; flb = 4'b1000; fdiv = 1;
        
        #10 fla = 4'b0111; flb = 4'b1110; fdiv = 0;

        #10 $finish;
    end

    initial begin
        $monitor("Time = %0d, nan = %b, fla = %b, flb = %b, fdiv = %b, flq = %b", $time, nan, fla, flb, fdiv, flq);
    end

endmodule


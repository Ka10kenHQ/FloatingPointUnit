`include "./../sigfmd.sv"

module tb_sigfmd;
    reg [52:0] fa, fb;
    reg fdiv, db;
    reg [1:0] oe1;
    reg oe2;
    wire [56:0] fq;

    sigfmd uut (
        .fa(fa),
        .fb(fb),
        .oe1(oe1),
        .oe2(oe2),
        .fdiv(fdiv),
        .db(db),
        .fq(fq)
    );

    initial begin
        oe1 = 2'b11;
        oe2 = 1'b0;
        fa = 53'h1A3B5C7D9E;
        fb = 53'h0F1E2D3C4B;
        fdiv = 0;
        db = 0;
        #10;

        fa = 53'h3F2E1D0C9B;
        fb = 53'h7A6B5C4D3E;
        fdiv = 1;
        db = 1;
        #10;

        fa = 53'h123456789AB;
        fb = 53'hFEDCBA98765;
        fdiv = 0;
        db = 1;
        #10;

    end

endmodule


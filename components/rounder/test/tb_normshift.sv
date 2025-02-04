`include "./../normshift.sv"

module tb_normshift;

    reg [56:0] fr;
    reg [12:0] er;
    reg OVFen;
    reg UNFen;
    reg db;
    wire [127:0] fn;
    wire [10:0] eni;
    wire [10:0] en;
    wire TINY;
    wire OVF1;

    normshift uut (
        .fr(fr),
        .er(er),
        .OVFen(OVFen),
        .UNFen(UNFen),
        .db(db),
        .fn(fn),
        .eni(eni),
        .en(en),
        .TINY(TINY),
        .OVF1(OVF1)
    );

    initial begin
        fr = 57'h123456789ABCDEF;
        er = 13'b0101010101010;
        OVFen = 1'b1;
        UNFen = 1'b0;
        db = 1'b1;
        
        #10;
        fr = 57'hDEADBEEFCAFEBABE;
        er = 13'b1010101010101;
        OVFen = 1'b0;
        UNFen = 1'b1;
        
        #10;
        fr = 57'hABCDEF123456789;
        er = 13'b1110001110001;
        OVFen = 1'b1;
        UNFen = 1'b0;
        
        #10;
        fr = 57'h9ABCDEF123456789;
        er = 13'b0001110001101;
        OVFen = 1'b0;
        UNFen = 1'b1;
        
        #10;
        fr = 57'h0123456789ABCDE;
        er = 13'b1100110011001;
        OVFen = 1'b1;
        UNFen = 1'b0;

        #10;
        $finish;
    end

    initial begin
        $monitor("Time: %0t | fr: %h | er: %b | OVFen: %b | UNFen: %b | db: %b | fn: %h | TINY: %b | OVF1: %b", $time, fr, er, OVFen, UNFen, db, fn, TINY, OVF1);
    end

endmodule


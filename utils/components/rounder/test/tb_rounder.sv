`include "./../rounder.sv"

module tb_rounder;
    reg db, s, OVFen, UNFen;
    reg [12:0] er;
    reg [56:0] fr;
    reg [57:0] flr;
    reg [1:0] RM;

    wire [4:0] IEEEp;
    wire [63:0] fp;

    rounder uut (
        .db(db),
        .s(s),
        .er(er),
        .fr(fr),
        .OVFen(OVFen),
        .UNFen(UNFen),
        .flr(flr),
        .RM(RM),
        .IEEEp(IEEEp),
        .fp(fp)
    );

    initial begin
        $monitor("Time=%0t db=%b s=%b er=%b fr=%b OVFen=%b UNFen=%b flr=%b RM=%b -> IEEEp=%b fp=%b", 
                 $time, db, s, er, fr, OVFen, UNFen, flr, RM, IEEEp, fp);

        db = 0; s = 0; er = 13'b0; fr = 57'b0; OVFen = 0; UNFen = 0; flr = 58'b0; RM = 2'b00; #10;
        db = 1; s = 1; er = 13'b1111111111111; fr = 57'b1010101010101; OVFen = 1; UNFen = 1; flr = 58'b11001100110011; RM = 2'b01; #10;
        db = 0; s = 1; er = 13'b1000000000001; fr = 57'b111000111000111; OVFen = 1; UNFen = 0; flr = 58'b1010101010101010; RM = 2'b10; #10;
        db = 1; s = 0; er = 13'b0110110110110; fr = 57'b1100001100001100; OVFen = 0; UNFen = 1; flr = 58'b1111111111111111; RM = 2'b11; #10;
        db = 0; s = 0; er = 13'b0011001100110; fr = 57'b1111000011110000; OVFen = 1; UNFen = 1; flr = 58'b0000111100001111; RM = 2'b00; #10;
    end
endmodule


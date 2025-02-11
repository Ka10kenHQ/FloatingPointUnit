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
    end
endmodule


`include "./../rounder.sv"

module tb_rounder;
    reg db, s, OVFen, UNFen;
    reg [12:0] er;
    reg [56:0] fr;
    reg [57:0] flr;
    reg [1:0] RM;

    wire [4:0] IEEEp;
    wire [63:0] fp;
    wire sp_out;
    wire [10:0] ep_out;
    wire [51:0] f_out;

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
        .fp(fp),
        .sp_out(sp_out),
        .ep_out(ep_out),
        .f_out(f_out)
    );

    initial begin
        $monitor("s = %b, e = %b, f = %b", sp_out, ep_out, f_out);

        // test 3.0 + 3.0 rounder output
        db = 1;
        s = 0;
        OVFen = 0;
        UNFen = 1;
        er = {2'b0, 11'b00000000001};
        fr =  57'b100100000000000000000000000000000000000000000000000000000;
        flr = 58'b0100000000000000000000000000000000000000000000000000000000;
        RM = 2'b00;

    end
endmodule


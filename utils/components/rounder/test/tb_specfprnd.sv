`include "./../specfprnd.sv"

module tb_specfrpnd;
    reg s;
    reg [10:0] eout;
    reg [51:0] fout;
    reg [52:0] nan;
    reg ZERO;
    reg NAN;
    reg INF;
    reg OVFen;
    reg UNFen;
    reg OVF;
    reg TINY;
    reg DBZ;
    reg siginx;
    reg db;
    reg INV;

    wire [63:0] fp_out;
    wire [4:0] IEEEp;

    specfrpnd uut (
        .s(s),
        .eout(eout),
        .fout(fout),
        .nan(nan),
        .ZERO(ZERO),
        .NAN(NAN),
        .INF(INF),
        .OVFen(OVFen),
        .UNFen(UNFen),
        .OVF(OVF),
        .TINY(TINY),
        .DBZ(DBZ),
        .siginx(siginx),
        .db(db),
        .INV(INV),
        .fp_out(fp_out),
        .IEEEp(IEEEp)
    );

    initial begin
        $monitor("Time=%0t s=%b eout=%b fout=%b nan=%b ZERO=%b NAN=%b INF=%b OVFen=%b UNFen=%b OVF=%b TINY=%b DBZ=%b siginx=%b db=%b INV=%b -> fp_out=%b IEEEp=%b", 
                 $time, s, eout, fout, nan, ZERO, NAN, INF, OVFen, UNFen, OVF, TINY, DBZ, siginx, db, INV, fp_out, IEEEp);
        
        s = 0; eout = 11'b0; fout = 52'b0; nan = 53'b0; ZERO = 0; NAN = 0; INF = 0; OVFen = 0; UNFen = 0; OVF = 0; TINY = 0; DBZ = 0; siginx = 0; db = 0; INV = 0; #10;
        s = 1; eout = 11'b11111111111; fout = 52'b1; nan = 53'b1; ZERO = 1; NAN = 1; INF = 1; OVFen = 1; UNFen = 1; OVF = 1; TINY = 1; DBZ = 1; siginx = 1; db = 1; INV = 1; #10;
        s = 0; eout = 11'b10101010101; fout = 52'b101010101010101; nan = 53'b101010101010101; ZERO = 0; NAN = 1; INF = 0; OVFen = 1; UNFen = 1; OVF = 0; TINY = 0; DBZ = 1; siginx = 1; db = 0; INV = 1; #10;
        s = 1; eout = 11'b01010101010; fout = 52'b1100110011001100; nan = 53'b1100110011001100; ZERO = 1; NAN = 0; INF = 1; OVFen = 0; UNFen = 0; OVF = 1; TINY = 1; DBZ = 0; siginx = 0; db = 1; INV = 0; #10;
        s = 0; eout = 11'b00110011001; fout = 52'b1110001110001110; nan = 53'b1110001110001110; ZERO = 0; NAN = 1; INF = 1; OVFen = 1; UNFen = 1; OVF = 0; TINY = 0; DBZ = 1; siginx = 0; db = 1; INV = 1; #10;
        
    end
endmodule

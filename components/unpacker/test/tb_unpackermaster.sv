`include "./../unpackermaster.sv"

module tb_unpackermaster;

    reg [63:0] FA2, FB2;
    reg db, normal;
    wire sa, sb;
    wire [10:0] ea, eb;
    wire [5:0] lza, lzb;
    wire [52:0] fa, fb;
    wire [3:0] fla, flb;
    wire [52:0] nan;

    unpackermaster uut (
        .FA2(FA2),
        .db(db),
        .normal(normal),
        .FB2(FB2),
        .sa(sa),
        .ea(ea),
        .lza(lza),
        .fa(fa),
        .fla(fla),
        .fb(fb),
        .flb(flb),
        .nan(nan),
        .sb(sb),
        .eb(eb),
        .lzb(lzb)
    );

    initial begin
        FA2 = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};
        FB2 = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};
        db = 1'b1;
        normal = 1'b1;

        #10;
        $display("sa = %b, ea = %b, fa = %b", sa, ea, fa);
        $display("sb = %b, eb = %b, fb = %b", sb, eb, fb);

        FA2 = {1'b0, 11'b10000000010, 52'b0100000000000000000000000000000000000000000000000000};
        FB2 = {1'b0, 11'b10000000010, 52'b0100000000000000000000000000000000000000000000000000};
        db = 1'b1;
        normal = 1'b1;

        #10;
        $display("sa = %b, ea = %b, fa = %b", sa, ea, fa);
        $display("sb = %b, eb = %b, fb = %b", sb, eb, fb);

        // 100 is single precision
        FA2 = {1'b0, 8'b10000101, 23'b10010000000000000000000, 1'b0, 8'b10000101, 23'b10010000000000000000000};
        FB2 = {1'b0, 8'b10000101, 23'b10010000000000000000000,1'b0, 8'b10000101, 23'b10010000000000000000000};

        db = 1'b0;
        normal = 1'b1;

        #10;
        $display("sa = %b, ea = %b, fa = %b", sa, ea, fa);
        $display("sb = %b, eb = %b, fb = %b", sb, eb, fb);


    end


endmodule


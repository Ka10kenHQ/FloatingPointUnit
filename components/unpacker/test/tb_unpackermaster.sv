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
        FA2 = {32'b01000010100010100000000000000000,32'b0};
        FB2 = {32'b01000010100010100000000000000000,32'b0};

        db = 1'b0;
        normal = 1'b1;
        #100;
    end


endmodule


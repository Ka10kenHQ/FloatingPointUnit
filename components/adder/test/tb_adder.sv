module tb_adder;

    reg [63:0] fpa;
    reg [63:0] fpb;
    reg db;
    reg normal;
    reg sub;
    reg [1:0] RM;

    wire sa, sb;
    wire [10:0] ea, eb;
    wire [5:0] lza, lzb;
    wire [3:0] fla, flb;
    wire [52:0] nan;
    wire [52:0] fa, fb;
    wire [10:0] es;
    wire [56:0] fs;
    wire ss;
    wire [57:0] fls;

    real fp_result;


    unpackermaster unpack (
        .FA2(fpa),
        .FB2(fpb),
        .sa(sa),
        .sb(sb),
        .ea(ea),
        .eb(eb),
        .db(db),
        .normal(normal),
        .fa(fa),
        .fb(fb),
        .lza(lza),
        .lzb(lzb),
        .fla(fla),
        .flb(flb),
        .nan(nan)
    );

    adder uut (
        .fa(fa),
        .ea(ea),
        .sa(sa),
        .fb(fb),
        .eb(eb),
        .sb(sb),
        .sub(sub),
        .fla(fla),
        .flb(flb),
        .nan(nan),
        .RM(RM),
        .es(es),
        .fs(fs),
        .ss(ss),
        .fls(fls)
    );

    initial begin
        fpa = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};
        fpb = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};

        db = 1;
        normal = 1;
        sub = 0;
        RM = 2'b00;

        #10;
        $display("ss = %b, es = %b, fs = %b", ss, es, fs);

    end

endmodule


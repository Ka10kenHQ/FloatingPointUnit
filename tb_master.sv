module tb_master;

reg [63:0] fpa, fpb;
reg db, normal, sub;
reg [1:0] RM;

wire [63:0] fp_out;
wire [4:0] IEEp;

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

master uut (
    .fpa(fpa),
    .fpb(fpb),
    .db(db),
    .normal(normal),
    .sub(sub),
    .RM(RM),
    .fp_out(fp_out),
    .IEEp(IEEp),
    .sa(sa),
    .sb(sb),
    .ea(ea),
    .eb(eb),
    .lza(lza),
    .lzb(lzb),
    .fla(fla),
    .flb(flb),
    .nan(nan),
    .fa(fa),
    .fb(fb),
    .es(es),
    .fs(fs),
    .ss(ss),
    .fls(fls)
);

initial begin

    // 3.0
    fpa = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};
    fpb = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};

    db = 1;
    normal = 1;
    sub = 0;
    RM = 2'b00;

    #10;
    $display("fp_out = %b", fp_out);

end

endmodule


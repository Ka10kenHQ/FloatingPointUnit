`include "./../muldiv.sv"

module tb_muldiv;

reg fdiv, db;
reg sa, sb;
reg [52:0] fa, fb;
reg [10:0] ea, eb;
reg [5:0] lza, lzb;
reg [52:0] nan;
reg [3:0] fla, flb;
wire [56:0] fq;
wire [12:0] eq;
wire sq;
wire [57:0] flq;

muldiv dut (
    .fdiv(fdiv),
    .sa(sa),
    .sb(sb),
    .db(db),
    .fa(fa),
    .fb(fb),
    .ea(ea),
    .eb(eb),
    .lza(lza),
    .lzb(lzb),
    .nan(nan),
    .fla(fla),
    .flb(flb),
    .fq(fq),
    .eq(eq),
    .sq(sq),
    .flq(flq)
);

initial begin
    fdiv = 0;
    sa = 0;
    sb = 0;
    fa = 53'b0;
    fb = 53'b0;
    ea = 11'b0;
    eb = 11'b0;
    lza = 6'b0;
    lzb = 6'b0;
    nan = 53'b0;
    fla = 4'b0;
    flb = 4'b0;
    db = 1'b1;
    #5;
    fdiv = 1;
    sa = 0;
    sb = 0;
    fa = 53'b10111111111000000000000000000000000000000000000000000;
    fb = 53'b00111111111000000000000000000000000000000000000000000;
    ea = 11'b01111111111;
    eb = 11'b01111111111;
    lza = 6'b000000;
    lzb = 6'b000000;
    nan = 53'b0;
    fla = 4'b0000;
    flb = 4'b0000;
    db = 1'b1;
end

endmodule

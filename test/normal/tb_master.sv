`include "../../master.sv"

module tb_master;

reg clk, rst_n;
reg [63:0] fpa, fpb;
reg db, md, normal, sub, fdiv;
reg [1:0] RM;

wire [63:0] fp;
wire [4:0] IEEp;

reg [31:0] fa32, fb32;

master uut (
    .clk(clk),
    .rst_n(rst_n),
    .fpa(fpa),
    .fpb(fpb),
    .db(db),
    .md(md),
    .normal(normal),
    .sub(sub),
    .fdiv(fdiv),
    .RM(RM),
    .fp(fp),
    .IEEEp(IEEp)
);

initial clk = 0;
always #5 clk = ~clk;

initial begin
    rst_n = 0;
    #20;
    rst_n = 1;
end

initial begin

    fpa = 64'b0111111111101111111111111111111111111111111111111111111111111111;
    fpb = 64'b0111111111101111111111111111111111111111111111111111111111111111;
    db = 1;
    md = 0;
    normal = 1;
    sub = 0;
    fdiv = 1;
    RM = 2'b01;
    #20;
    // #210;


    // fpa = {1'b0, 11'b10000000001, 52'b1100000000000000000000000000000000000000000000000000 };
    // fpb = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000 };
    // db = 1;
    // normal = 1;
    // sub = 0;
    // fdiv = 1;
    // RM = 2'b10;
    // #200;

    // fa32 = 32'b01111111011111111111111111111111;
    // fb32 = 32'b01111111011111111111111111111111;
    //
    // fpa = { fa32, fa32 };
    // fpb = { fb32, fb32 };
    // db = 0;
    // normal = 1;
    // sub = 0;
    // fdiv = 0;
    // RM = 2'b01;
    // #20;


    $finish;
end

endmodule

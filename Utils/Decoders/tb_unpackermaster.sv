module tb_unpackermaster;
reg [63:0] fp;
reg db;
reg normal;
wire e_inf;
wire e_z;
wire [10:0] e;
wire s;
wire [5:0] lz;
wire [52:0] f;
wire fz;
wire [51:0] h;

unpackermaster uut (
    .fp(fp),
    .db(db),
    .normal(normal),
    .e_inf(e_inf),
    .e_z(e_z),
    .e(e),
    .s(s),
    .lz(lz),
    .f(f),
    .fz(fz),
    .h(h)
);

initial begin
    fp = 64'b0;
    db = 1;
    normal = 1;
    #10;
    $display("Test Case 1:");
    $display("fp: %b, e_inf: %b, e_z: %b, e: %b, s: %b, lz: %b, f: %b, fz: %b, h: %b", 
             fp, e_inf, e_z, e, s, lz, f, fz, h);

    #10;
    fp = 64'h3FF0000000000000;
    db = 0;
    normal = 0;
    #10;
    $display("Test Case 2:");
    $display("fp: %b, e_inf: %b, e_z: %b, e: %b, s: %b, lz: %b, f: %b, fz: %b, h: %b", 
             fp, e_inf, e_z, e, s, lz, f, fz, h);

    #10;
    fp = 64'hBFF0000000000000;
    db = 1;
    normal = 1;
    #10;
    $display("Test Case 3:");
    $display("fp: %b, e_inf: %b, e_z: %b, e: %b, s: %b, lz: %b, f: %b, fz: %b, h: %b", 
             fp, e_inf, e_z, e, s, lz, f, fz, h);

    #10;
    fp = 64'h7FF0000000000000;
    db = 0;
    normal = 0;
    #10;
    $display("Test Case 4:");
    $display("fp: %b, e_inf: %b, e_z: %b, e: %b, s: %b, lz: %b, f: %b, fz: %b, h: %b", 
             fp, e_inf, e_z, e, s, lz, f, fz, h);

    #10;
    fp = 64'h0000000000000000;
    db = 1;
    normal = 1;
    #10;
    $display("Test Case 5:");
    $display("fp: %b, e_inf: %b, e_z: %b, e: %b, s: %b, lz: %b, f: %b, fz: %b, h: %b", 
             fp, e_inf, e_z, e, s, lz, f, fz, h);
end

endmodule
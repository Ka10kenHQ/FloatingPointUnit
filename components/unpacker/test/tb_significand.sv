`include "./../significant.sv"

module tb_significand;

    parameter N = 64;
    
    reg dbs;
    reg [N-1:0] fp;
    reg ez;
    reg normal;

    wire [5:0] lz;
    wire [52:0] f;
    wire fz;
    wire [51:0] h;

    significant #(N) uut (
        .db(dbs),
        .fp(fp),
        .e_z(ez),
        .normal(normal),
        .lz(lz),
        .f(f),
        .fz(fz),
        .h(h)
    );

    initial begin
        dbs = 0;
        fp = 64'hA5A5A5A5A5A5A5A5;  // Sample input value
        ez = 0;
        normal = 1;
        #40;
        
        dbs = 1;
        fp = 64'h1F1F1F1F1F1F1F1F;  // Another sample input value
        ez = 1;
        normal = 0;
        #40;

        dbs = 0;
        fp = 64'hDEADBEEFDEADBEEF;  // Another input pattern
        ez = 0;
        normal = 1;
        #40;

        dbs = 1;
        fp = 64'hFFFFFFFFFFFFFFFF;  // All bits set
        ez = 1;
        normal = 0;
        #40;

        dbs = 0;
        fp = 64'h1234567890ABCDEF;  // Random 64-bit value
        ez = 0;
        normal = 1;
        #40;

    
    end

endmodule

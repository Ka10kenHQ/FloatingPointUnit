`include "./../unpacker.sv"
module tb_large_pattern;
    reg [63:0] fp;
    reg db;      
    reg normal; 
    wire e_inf, e_z; 
    wire [10:0] e;  
    wire s;        
    wire [5:0] lz;
    wire [52:0] f;
    wire fz;    
    wire [51:0] h;

    unpacker uut (
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

    integer i;

    initial begin
        for (i = 0; i < 1000; i = i + 1) begin
            fp = $random;
            db = $random;
            normal = $random;
            #10;
        end

        fp = 64'h0000000000000000; db = 0; normal = 1; #10; // Zero
        fp = 64'h7FF0000000000000; db = 0; normal = 1; #10; // Infinity
        fp = 64'hFFF0000000000000; db = 0; normal = 1; #10; // -Infinity
        fp = 64'h7FF8000000000000; db = 0; normal = 1; #10; // NaN
        fp = 64'h0010000000000000; db = 0; normal = 1; #10; // Smallest normal
        fp = 64'h000FFFFFFFFFFFFF; db = 0; normal = 1; #10; // Largest subnormal
        fp = 64'h7FEFFFFFFFFFFFFF; db = 0; normal = 1; #10; // Largest normal
        fp = 64'h8000000000000000; db = 0; normal = 1; #10; // -0

    end
endmodule


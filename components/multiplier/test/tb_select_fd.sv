`include "./../select_fd.sv"
module tb_select_fb;
    reg [57:0] Da;
    reg [57:0] Db;
    reg [114:0] Eb;
    reg db;
    reg [54:0] E;

    wire [56:0] fd;

    select_fb uut (
        .Da(Da),
        .Db(Db),
        .Eb(Eb),
        .db(db),
        .E(E),
        .fd(fd)
    );

    initial begin
        Da = 58'h0;
        Db = 58'h0;
        Eb = 115'h0;
        db = 1'b0;
        E = 55'h0;

        #10 Da = 58'h3FFFFFFF;
        #10 Db = 58'h1A1A1A1A1A;
        #10 Eb = 115'h3FFFFFFFFFFFFFFFFFFFFFF;
        #10 db = 1'b1;
        #10 E = 55'h1555555555555;
        
        #10 db = 1'b0;
        #10 db = 1'b1;
        
        #10 Da = 58'h123456789ABC;
        #10 Db = 58'h9876543210;
        #10 Eb = 115'hFEDCBA98765432100123456789;
        #10 E = 55'h7FFFFFFFFFFFF;
        
        #10 $stop;
    end

    initial begin
        $monitor("Time=%0t Da=%h Db=%h Eb=%h db=%b E=%h fd=%h", $time, Da, Db, Eb, db, E, fd);
    end
endmodule

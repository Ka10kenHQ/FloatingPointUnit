`include "./../shiftdist.sv"

module tb_shiftdist;

    reg [12:0] er;
    reg [5:0] lz;
    reg TINY;
    reg UNFen;
    reg db;
    wire [12:0] sh;

    shiftdist uut (
        .er(er),
        .lz(lz),
        .db(db),
        .TINY(TINY),
        .UNFen(UNFen),
        .sh(sh)
    );

    initial begin
        er = 13'b0000000000001;
        lz = 6'b000100;
        TINY = 1;
        UNFen = 0;
        db = 1;
        #10;
        $display("sh = %b", sh);

        er = 13'b0000000000001;
        lz = 6'b000100;
        TINY = 0;
        UNFen = 0;
        #10;
        $display("sh = %b", sh);

        er = 13'b1111111111111;
        lz = 6'b101010;
        TINY = 1;
        UNFen = 1;
        #10;
        $display("sh = %b", sh);

        er = 13'b0000000000001;
        lz = 6'b111000;
        TINY = 0;
        UNFen = 1;
        #10;
        $display("sh = %b", sh);

        er = 13'b0000000000000;
        lz = 6'b001111;
        TINY = 1;
        UNFen = 0;
        #10;
        $display("sh = %b", sh);
    end

endmodule



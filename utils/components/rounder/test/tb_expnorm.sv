`include "./../expnorm.sv"

module tb_expnorm;
    reg [10:0] er;
    reg [5:0] lz;
    reg db, OVFen, OVF1, UNFen, TINY;
    wire [10:0] eni, en;

    expnorm uut (
        .er(er),
        .lz(lz),
        .db(db),
        .OVFen(OVFen),
        .OVF1(OVF1),
        .UNFen(UNFen),
        .TINY(TINY),
        .eni(eni),
        .en(en)
    );

    initial begin
        er = 11'b00000000001;
        lz = 6'b000001;
        db = 0;
        OVFen = 0;
        OVF1 = 1;
        UNFen = 0;
        TINY = 0;
        #10;
        
        OVFen = 1;
        OVF1 = 1;
        #10;
        
        OVFen = 0;
        OVF1 = 0;
        UNFen = 1;
        TINY = 1;
        #10;
        
        UNFen = 0;
        TINY = 0;
        db = 1;
        er = 11'b00000001100;
        lz = 6'b000110;
        #10;
        
        er = 11'b10101010101;
        lz = 6'b110011;
        db = 1;
        OVFen = 1;
        OVF1 = 0;
        UNFen = 0;
        TINY = 1;
        #10;
        
        $monitor("Time = %0t | er = %b | lz = %b | db = %b | OVFen = %b | OVF1 = %b | UNFen = %b | TINY = %b | en = %b | eni = %b", 
            $time, er, lz, db, OVFen, OVF1, UNFen, TINY, en, eni);
    end
endmodule


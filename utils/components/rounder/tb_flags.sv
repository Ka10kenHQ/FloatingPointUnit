module tb_flags;

    reg  [56:0] fr;
    reg  [12:0] er;
    reg         db;

    wire        TINY;
    wire        OVF1;
    wire [5:0]  lz;

    flags dut (
        .fr(fr),
        .er(er),
        .db(db),
        .TINY(TINY),
        .OVF1(OVF1),
        .lz(lz)
    );

    initial begin
        
        fr = 57'b000000000000000000000000000000000000000000000000000000000;
        er = 13'b0000000000000;
        db = 1'b0;
        #10;

        fr = 57'b111111111111111111111111111111111111111111111111111111111;
        er = 13'b1111111111111;
        db = 1'b0;
        #10;

        fr = 57'b000011110000111100001111000011110000111100001111000011110;
        er = 13'b0101010101010;
        db = 1'b1;
        #10;

        fr = 57'b000000000000000000000000000000000000000000000000000000000;
        er = 13'b0000000000001;
        db = 1'b1;
        #10;

        fr = 57'b100000000000000000000000000000000000000000000000000000000;
        er = 13'b1111111111110;
        db = 1'b0;
        #10;

        $display("Test completed!");
    end

    initial begin
        $monitor("Time=%0t | fr=%b | er=%b | db=%b || TINY=%b | OVF1=%b | lz=%b", 
                 $time, fr, er, db, TINY, OVF1, lz);
    end

endmodule


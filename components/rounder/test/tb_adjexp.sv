module tb_adjexp;

    reg [10:0] e2;
    reg db;
    reg sigovf;
    reg OVFen;
    wire [10:0] e3;
    wire OVF;

    adjexp uut (
        .e2(e2),
        .db(db),
        .sigovf(sigovf),
        .OVFen(OVFen),
        .e3(e3),
        .OVF(OVF)
    );

    initial begin
        e2 = 11'b00000000001;
        db = 0;
        sigovf = 0;
        OVFen = 0;
        #10;

        e2 = 11'b11111111111;
        db = 1;
        sigovf = 1;
        OVFen = 1;
        #10;

        e2 = 11'b01010101010;
        db = 0;
        sigovf = 1;
        OVFen = 0;
        #10;

        e2 = 11'b00000000000;
        db = 1;
        sigovf = 0;
        OVFen = 1;
        #10;

    end
endmodule


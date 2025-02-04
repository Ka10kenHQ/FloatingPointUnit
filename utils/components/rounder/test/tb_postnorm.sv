`include "./../postnorm.sv"

module tb_postnorm;

    reg [10:0] en, eni;
    reg [53:0] f2;
    wire sigovf;
    wire [10:0] e2;
    wire [52:0] f3;

    postnorm uut (
        .en(en),
        .eni(eni),
        .f2(f2),
        .sigovf(sigovf),
        .e2(e2),
        .f3(f3)
    );

    initial begin
        en = 11'b10101010101;
        eni = 11'b11011011011;
        f2 = 54'h1F_FF_FF_FF_FF;

        #10;
        en = 11'b11111111111;
        eni = 11'b00000000000;
        f2 = 54'h0_00_00_00_00;

        #10;
        en = 11'b11001100110;
        eni = 11'b10101010101;
        f2 = 54'h5A_5A_5A_5A_5A;

        #10;
        en = 11'b11110000000;
        eni = 11'b00001111111;
        f2 = 54'h3C_3C_3C_3C_3C;

        #10;
        $finish;
    end

    initial begin
        $monitor("Time: %0t | en: %b | eni: %b | f2: %h | sigovf: %b | e2: %b | f3: %h", $time, en, eni, f2, sigovf, e2, f3);
    end

endmodule


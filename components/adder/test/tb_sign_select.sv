`include "./../sign_select.sv"
module tb_sign_select;
    reg [1:0] RM;
    reg fz;
    reg sa;
    reg sx;
    reg sb;
    reg ss1;
    reg INFs;
    reg INFa;
    reg NAN;
    wire ZERO;
    wire ss;

    sign_select uut (
        .RM(RM),
        .fz(fz),
        .sa(sa),
        .sx(sx),
        .sb(sb),
        .ss1(ss1),
        .INFs(INFs),
        .INFa(INFa),
        .NAN(NAN),
        .ZERO(ZERO),
        .ss(ss)
    );

    initial begin
        RM = 2'b00; fz = 0; sa = 0; sx = 0; sb = 0; ss1 = 0; INFs = 0; INFa=0; NAN = 0;
        #10 RM = 2'b01; fz = 1; sa = 1; sx = 0; sb = 0; ss1 = 0; INFs = 0;INFa = 0; NAN = 0;
        #10 RM = 2'b10; fz = 0; sa = 0; sx = 1; sb = 1; ss1 = 1; INFs = 0;INFa = 0; NAN = 0;
        #10 RM = 2'b11; fz = 1; sa = 1; sx = 0; sb = 1; ss1 = 0; INFs = 1;INFa = 0; NAN = 0;
        #10 RM = 2'b00; fz = 0; sa = 1; sx = 1; sb = 0; ss1 = 1; INFs = 0;INFa = 0; NAN = 1;
        #10 RM = 2'b01; fz = 1; sa = 0; sx = 0; sb = 1; ss1 = 1; INFs = 1;INFa = 0; NAN = 0;
        #10 RM = 2'b10; fz = 0; sa = 1; sx = 1; sb = 0; ss1 = 0; INFs = 0;INFa = 0; NAN = 0;
        #10 RM = 2'b11; fz = 1; sa = 0; sx = 0; sb = 0; ss1 = 0; INFs = 1;INFa = 0; NAN = 1;
        #10 $finish;
    end

endmodule



module tb_sigadd;

    reg [52:0] fa2;
    reg [55:0] fb3;
    reg sa2, sb2, sx;

    wire [56:0] fs;
    wire fszero;
    wire ss1;

    sigadd uut (
        .fa2(fa2),
        .fb3(fb3),
        .sa2(sa2),
        .sb2(sb2),
        .sx(sx),
        .fs(fs),
        .fszero(fszero),
        .ss1(ss1)
    );

    initial begin
        $monitor("Time=%0t | fa2=%h | fb3=%h | sa2=%b | sb2=%b | sx=%b | fs=%h | fszero=%b | ss1=%b",
                 $time, fa2, fb3, sa2, sb2, sx, fs, fszero, ss1);

        fa2 = 53'h000000000001;
        fb3 = 56'h000000000002;
        sa2 = 0;
        sb2 = 0;
        sx  = 0;
        #10;

        fa2 = 53'h1FFFFFFFFFFFF;
        fb3 = 56'h00FFFFFFFFFFFF;
        sa2 = 1;
        sb2 = 0;
        sx  = 1;
        #10;

        fa2 = 53'h0;
        fb3 = 56'h0;
        sa2 = 0;
        sb2 = 1;
        sx  = 0;
        #10;

        fa2 = 53'h0F0F0F0F0F0F;
        fb3 = 56'hF0F0F0F0F0F0;
        sa2 = 1;
        sb2 = 1;
        sx  = 1;
        #10;

        fa2 = 53'h7FFFFFFFFFFFF;
        fb3 = 56'h3FFFFFFFFFFFF;
        sa2 = 1;
        sb2 = 1;
        sx  = 0;
        #10;

        fa2 = 53'h000000000001;
        fb3 = 56'h000000000001;
        sa2 = 0;
        sb2 = 0;
        sx  = 1;
        #10;

    end

endmodule


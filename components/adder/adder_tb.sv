module adder_tb;

    reg [52:0] fa;
    reg [10:0] ea;
    reg sa;
    reg [52:0] fb;
    reg [10:0] eb;
    reg sb;
    reg sub;
    reg [3:0] fla;
    reg [3:0] flb;
    reg [52:0] nan;

    wire [10:0] es;
    wire [56:0] fs;
    wire ss;
    wire [1:0] fls;

    adder uut (
        .fa(fa),
        .ea(ea),
        .sa(sa),
        .fb(fb),
        .eb(eb),
        .sb(sb),
        .sub(sub),
        .fla(fla),
        .flb(flb),
        .nan(nan),
        .es(es),
        .fs(fs),
        .ss(ss),
        .fls(fls)
    );

    initial begin
        fa = 53'b0; ea = 11'b0; sa = 0;
        fb = 53'b0; eb = 11'b0; sb = 0;
        sub = 0; fla = 4'b0; flb = 4'b0; nan = 4'b0;
        #10;
        
        fa = 53'd100; ea = 11'd10; sa = 0;
        fb = 53'd50; eb = 11'd8; sb = 0;
        sub = 0; fla = 0; flb = 0; nan = 0;
        #10;

        fa = 53'd200; ea = 11'd12; sa = 1;
        fb = 53'd150; eb = 11'd11; sb = 1;
        sub = 1; fla = 4'b1; flb = 4'b1; nan = 0;
        #10;

        fa = 53'd500; ea = 11'd20; sa = 0;
        fb = 53'd300; eb = 11'd18; sb = 0;
        sub = 0; fla = 1; flb = 0; nan = 1;
        #10;

    end

endmodule


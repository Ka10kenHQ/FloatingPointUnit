module tb_adder;

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
    reg [1:0] RM;
    wire [10:0] es;
    wire [56:0] fs;
    wire ss;
    wire [57:0] fls;

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
        .RM(RM),
        .es(es),
        .fs(fs),
        .ss(ss),
        .fls(fls)
    );

    initial begin
        fa = 53'h1FFFFFFFFFFFFF; 
        ea = 11'h3FF;
        sa = 0;
        fb = 53'h10000000000000;
        eb = 11'h400;
        sb = 0;
        sub = 0;
        fla = 4'b0000;
        flb = 4'b0000;
        nan = 53'h0;
        RM = 2'b00;
        
        #10;
        
        fa = 53'h0;
        ea = 11'h000;
        sa = 1;
        fb = 53'h1FFFFFFFFFFFFF;
        eb = 11'h3FF;
        sb = 1;
        sub = 1;
        fla = 4'b0010;
        flb = 4'b0001;
        nan = 53'h1;
        RM = 2'b01;
        
        #10;
        
        fa = 53'hFFFFFFFFFFFFF;
        ea = 11'h7FF;
        sa = 0;
        fb = 53'hFFFFFFFFFFFFF;
        eb = 11'h7FF;
        sb = 1;
        sub = 0;
        fla = 4'b1000;
        flb = 4'b0100;
        nan = 53'h0;
        RM = 2'b10;
        
        #10;
        
    end

endmodule


module adder(
    input [52:0] fa,
    input [10:0] ea,
    input sa,

    input [52:0] fb,
    input [10:0] eb,
    input sb,

    input sub,

    input [3:0] fla,
    input [3:0] flb,

    input [52:0] nan,
    
    input [1:0] RM,

    output [10:0] es,
    output [56:0] fs,
    output ss,
    output [57:0] fls
);

wire [55:0] fb3;
wire [52:0] fa2;
wire sa2, sx, sb2;
wire sb_adj;

assign sb_adj = sb ^ sub;

alignment align(
    .ea(ea),
    .eb(eb),
    .fa(fa),
    .sa(sa),
    .fb(fb),
    .sb(sb_adj),
    .es(es),
    .fb3(fb3),
    .fa2(fa2),
    .sa2(sa2),
    .sx(sx),
    .sb2(sb2)
);

wire INFs,NANs,INV;

spec spc(
    .sb(sb_adj),
    .sa(sa),
    .fla(fla),
    .flb(flb),
    .INFs(INFs),
    .NANs(NANs),
    .INV(INV)
); 

wire fszero;
wire ss1;

sigadd add(
    .fa2(fa2),
    .fb3(fb3),
    .sa2(sa2),
    .sb2(sb2),
    .sx(sx),
    .fs(fs),
    .fszero(fszero),
    .ss1(ss1)
);

wire INFa = fla[2];
wire ZERO;

sign_select sign(
    .RM(RM),
    .fz(fszero),
    .sa(sa),
    .sx(sx),
    .sb(sb_adj),
    .ss1(ss1),
    .INFs(INFs),
    .INFa(INFa),
    .NAN(NANs),
    .ZERO(ZERO),
    .ss(ss)
);

assign fls = {nan, ZERO, INFs, NANs, INV, 1'b0};


endmodule

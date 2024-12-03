module adder(
    input [52:0] fa,
    input [10:0] ea,
    input sa,
    input [52:0] fb,
    input [10:0] eb,
    input sb,
    input sub,
    input fla,
    input flb,
    input nan,
    output [10:0] es,
    output [56:0] fs,
    output ss,
    //FIXME: what the hell is fls ???
    output fls
    );

reg [1:0] RM = 2'b0;


wire [55:0] fb3;
wire [52:0] fa2;
wire sa2, sx, sb2, sb_p;
wire INFs,NANs,INV;
wire ZERO;

wire fszero;
wire ss1;
wire ovf;


alignment align(
    .ea(ea),
    .eb(eb),
    .fa(fa),
    .sa(sa),
    .fb(fb),
    .sb(sb ^ sub),
    .es(es),
    .fb3(fb3),
    .fa2(fa2),
    .sa2(sa2),
    .sx(sx),
    .sb2(sb2)
);


spec spc(
    .sb(sb),
    .sa(sa),
    .fla(fla),
    .flb(flb),
    .INFs(INFs),
    .NANs(NANs),
    .INV(INV)
); 


sigadd add(
    .fa2(fa2),
    .fb3(fb3),
    .sa2(sa2),
    .sb2(sb2),
    .sx(sx),
    .fs(fs),
    .fszero(fszero),
    .ss1(ss1),
    .ovf(ovf)
);


sign_select sign(
    .RM(RM),
    .fz(fz),
    .sa(sa),
    .sx(sx),
    .sb(sb),
    .ss1(ss1),
    .INF(INFs),
    .NAN(NANs),
    .ZERO(ZERO),
    .ss(ss)
);

assign fls = 0;


endmodule

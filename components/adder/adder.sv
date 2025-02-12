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
    output reg [57:0] fls
);

reg INFa = fla[2];

wire [55:0] fb3;
wire [52:0] fa2;

wire sa2, sx, sb2, sb_p;
wire INFs,NANs,INV;
wire ZERO;

wire fszero;
wire ss1;


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
    .sb(sb ^ sub),
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
    .ss1(ss1)
);


sign_select sign(
    .RM(RM),
    .fz(fszero),
    .sa(sa),
    .sx(sx),
    .sb(sb ^ sub),
    .ss1(ss1),
    .INFs(INFs),
    .INFa(INFa),
    .NAN(NANs),
    .ZERO(ZERO),
    .ss(ss)
);

always @(*) begin
    // TODO: 1 bit is missing flr is [57:0] but fls is [56:0]
    fls = {ZERO, INV, INFs, NANs, nan};
end


endmodule

module alignment(
    input [10:0] ea,
    input [10:0] eb,

    input [52:0] fa,
    input  sa,
    
    input [52:0] fb,
    input  sb,
    
    output [10:0] es,
    output [55:0] fb3,
    output [52:0] fa2,
    output  sa2,
    output  sx,
    output  sb2
);

wire [10:0] as;
wire eb_gt_ea;

exp_sub exps(
    .ea(ea),
    .eb(eb),
    .as(as),
    .eb_gt_ea(eb_gt_ea)
);

wire [5:0] as2;

limit lim(
    .as(as),
    .eb_gt_ea(eb_gt_ea),
    .as2(as2)
);

wire [54:0] fb2;
swap swp(
    .fa(fa),
    .fb(fb),
    .sa(sa),
    .sb(sb),
    .eb_gt_ea(eb_gt_ea),
    .fb2(fb2),
    .fa2(fa2),
    .sa2(sa2),
    .sb2(sb2)
);

wire [54:0] fp3_h;

lrs log_r_s(
.as2(as2),
.fb2(fb2),
.fb3(fp3_h)
);

wire sticky;
sticky stky(
.as2(as2),
.fb2(fb2),
.sticky(sticky)
);

assign sx = sa2 ^ sb2;
assign es = eb_gt_ea ? eb : ea;
assign fb3 = {fp3_h[54:0], sticky};

endmodule

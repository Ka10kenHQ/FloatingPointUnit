module alignment(
    input [10:0] ea,
    input [10:0] eb,

    input [52:0] fa,
    input  sa,
    
    input [52:0] fb,
    input  sb,
    
    output reg[10:0] es,
    output reg[55:0] fb3,
    output [52:0] fa2,
    output  sa2,
    output reg sx,
    output  sb2
);

wire [10:0] as;
wire [54:0] temp;
wire [54:0] fb2;
wire [5:0] as2;
wire eb_gt_ea;

exp_sub uut(
    .ea(ea),
    .eb(eb),
    .as(as),
    .eb_gt_ea(eb_gt_ea)
);

limit uut1(
    .as(as),
    .eb_gt_ea(eb_gt_ea),
    .as2(as2)
);

swap uut2(
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

lrs uut3(
.as2(as2),
.fb2(fb2),
.fb3(temp)
);

sticky uut4(
.as2(as2),
.fb2(fb2),
.sticky(sticky)
);

always@(*) begin
sx = sa2 ^ sb2;
es = eb_gt_ea ? eb : ea;
fb3 = {temp, sticky};
end    
endmodule

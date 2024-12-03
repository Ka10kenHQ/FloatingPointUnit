module alignment(
input wire[10:0] ea,
input wire[10:0] eb,
input wire[52:0] fa,
input wire sa,
input wire[52:0] fb,
input wire sb,
output reg[10:0] es,
output reg[55:0] fb3,
output reg[52:0] fa2,
output reg sa2,
output reg sx,
output reg sb2
);
reg[12:0] as;
reg eb_gt_ea;
reg[5:0] as2;
reg[54:0] fb2;
reg[54:0] temp;
expsub uut(
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
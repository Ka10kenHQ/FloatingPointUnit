module rndexceptions(
    input NAN,
    input INF,
    input ZERO,
    input OVFen,
    input UNFen,
    input OVF,
    input TINY,
    input INV,
    input DBZ,
    input siginx,

    output reg [4:0] IEEEp
);

wire OVFp, UNFp, INXp, INX;
wire spec;

assign spec = (NAN | INF | ZERO);
assign OVFp = ~spec & OVF;
assign INX = siginx | (OVF & ~OVFen);

assign UNFp = ~spec & TINY & (UNFen | INX);
assign INXp = ~spec & INX;
assign IEEEp = {INV, DBZ, OVFp, UNFp, INXp};


endmodule

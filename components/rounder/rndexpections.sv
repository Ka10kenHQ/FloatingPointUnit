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

reg OVFp, UNFp, INXp, INX;
reg spec;

always @(*) begin
    spec = (NAN | INF | ZERO);
    OVFp = ~spec & OVF;
    INX = siginx | (OVF & ~OVFen);

    UNFp = ~spec & TINY & (UNFen | INX);
    INXp = ~spec & INX;
    IEEEp = {INV, DBZ, OVFp, UNFp, INXp};
end


endmodule

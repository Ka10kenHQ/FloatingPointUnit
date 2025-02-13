module specfrpnd(
    input s,
    input [10:0] eout,
    input [51:0] fout,
    input [52:0] nan,
    input ZERO,
    input NAN,
    input INF,
    input INV,
    input OVF,
    input OVFen,
    input UNFen,
    input TINY,
    input DBZ,
    input siginx,
    input db,

    output reg [63:0] fp_out,
    output reg sp_out,
    output reg [10:0] ep_out,
    output reg [51:0] f_out,
    output [4:0] IEEEp
);

wire sp;
wire [10:0] ep;
wire [51:0] fp;

specselect specs(
    .s(s),
    .eout(eout),
    .fout(fout),
    .nan(nan),
    .ZERO(ZERO),
    .NAN(NAN),
    .INF(INF),
    .sp(sp),
    .ep(ep),
    .fp(fp)
);

rndexceptions rndexep(
    .NAN(NAN),
    .INF(INF),
    .ZERO(ZERO),
    .OVFen(OVFen),
    .UNFen(UNFen),
    .OVF(OVF),
    .TINY(TINY),
    .INV(INV),
    .DBZ(DBZ),
    .siginx(siginx),
    .IEEEp(IEEEp)
);


always @(*) begin
    sp_out = sp;
    ep_out = ep;
    f_out = fp;
    if(db) begin
        fp_out = {sp, ep, fp[51:0]};
    end
    else begin
        fp_out = {sp, ep[7:0], fp[51:28], sp, ep[7:0], fp[51:28]};
    end
end


endmodule

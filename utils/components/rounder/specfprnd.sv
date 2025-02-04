module specfrpnd(
    input s,
    input [10:0] eout,
    input [51:0] fout,
    input [52:0] nan,
    input ZERO,
    input NAN,
    input INF,
    input UNFen,
    input TINY,
    input DBZ,
    input siginx,
    input db,

    output reg [63:0] fp_out
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

always @(*) begin
    if(db) begin
        fp_out = {sp, ep, fp};
    end
    else begin
        fp_out = {sp, ep[7:0], fp[22:0], sp, ep[7:0], fp[22:0]};
    end

end


endmodule

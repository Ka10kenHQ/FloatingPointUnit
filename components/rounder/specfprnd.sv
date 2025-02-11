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
    if(db) begin
        fp_out = {sp, ep, rev_52(fp)};
    end
    else begin
        fp_out = {sp, ep[7:0], rev_22(fp[22:0]), sp, ep[7:0], rev_22(fp[22:0])};
    end
end

function [22:0] rev_22;
    input [22:0] fp_in;
    integer i;
    begin
        for (i = 0; i < 23; i = i + 1) begin
            rev_22[i] = fp_in[22 - i];
        end
    end
endfunction

function [52:0] rev_52;
    input [52:0] fp_in;
    integer i;
    begin
        for (i = 0; i < 53; i = i + 1) begin
            rev_52[i] = fp_in[52 - i];
        end
    end
endfunction



endmodule

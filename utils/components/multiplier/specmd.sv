module specmd(
    input [52:0] nan,
    input [3:0] fla,
    input [3:0] flb,
    input fdiv,

    output reg [57:0] flq
);

reg ZEROq;
reg INFq;
reg NANq;
reg INV;
reg DBZ;

always @(*) begin
    DBZ = fdiv & flb[3] & ~(fla[3] | fla[2] | fla[1] | fla[0]);
    if(fdiv) begin
        INV = (fla[3] & flb[3]) | (fla[2] & flb[2]) | (fla[1] & flb[1]);
    end
    else begin
        INV = (fla[2] & flb[3]) | (fla[3] & flb[2]) | (fla[1] | flb[1]);
    end
    NANq = INV | (fla[0] | flb[0]);

    if(fdiv) begin
        INFq = (fla[2] & ~NANq) | DBZ;
    end
    else begin
        INFq = (fla[2] | flb[2]) & ~NANq;
    end

    if(fdiv) begin
        ZEROq = (fla[3] | flb[2]) & ~NANq;
    end
    else begin
        ZEROq = (fla[3] | flb[3]) & ~NANq;
    end

    flq = {nan, ZEROq, INFq, NANq, INV, DBZ};
end



endmodule

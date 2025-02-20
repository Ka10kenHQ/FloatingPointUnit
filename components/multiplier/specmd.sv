module specmd(
    input [52:0] nan,
    input [3:0] fla,
    input [3:0] flb,
    input fdiv,

    output [57:0] flq
);

wire ZEROq;
wire INFq;
wire NANq;
wire INV;
wire DBZ;

assign DBZ = fdiv & flb[3] & ~(fla[3] | fla[2] | fla[1] | fla[0]);

assign INV = fdiv ? ((fla[3] & flb[3]) | (fla[2] & flb[2]) | (fla[1] & flb[1])) :
                    ((fla[2] & flb[3]) | (fla[3] & flb[2]) | (fla[1] | flb[1]));

assign NANq = INV | (fla[0] | flb[0]);

assign INFq = fdiv ? ((fla[2] & ~NANq) | DBZ) :
                     ((fla[2] | flb[2]) & ~NANq);

assign ZEROq = fdiv ? ((fla[3] | flb[2]) & ~NANq) :
                      ((fla[3] | flb[3]) & ~NANq);

assign flq = {nan, ZEROq, INFq, NANq, INV, DBZ};

endmodule


module spec(
    input sb,
    input sa,
    input [52:0] fla,
    input [52:0] flb,
    output INFs,
    output NANs,
    output INV
    );

    assign INV = (fla[1] | flb[1]) | (fla[2] | flb[2]) & (sa ^ sb);
    assign NANs = INV | (fla[0] | fla[0]);
    assign INFs = (fla[2] | flb[2]) & ~NANs;


endmodule

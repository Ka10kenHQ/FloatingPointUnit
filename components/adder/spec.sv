module spec(
    input sb,
    input sa,
    input [3:0] fla,
    input [3:0] flb,
    output reg INFs,
    output reg NANs,
    output reg INV
);

always @(*) begin
   INV = (fla[1] | flb[1]) | (fla[2] | flb[2]) & (sa ^ sb);
   NANs = INV | (fla[0] | fla[0]);
   INFs = (fla[2] | flb[2]) & ~NANs;
end

endmodule

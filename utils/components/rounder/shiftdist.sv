module shiftdist(
    input [12:0] er,
    input [5:0] lz,

    input TINY,
    input UNFen,

    output reg [12:0] sh
);

reg mask;
reg [12:0] add;
// 1 - emin = 1 - (-2^(n-1) + 2) = 2^(n-1) - 1 = emax
wire [12:0] emax = 13'b1111_1111_1111;

always @(*) begin
    mask = TINY & ~UNFen;

    if(mask) begin
        sh = er + emax;
    end
    else begin
        sh = {7'b0, lz};
    end


end


endmodule

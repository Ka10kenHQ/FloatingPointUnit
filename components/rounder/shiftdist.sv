module shiftdist(
    input [12:0] er,
    input [5:0] lz,

    input db,

    input TINY,
    input UNFen,

    output reg [12:0] sh
);

// 1 - emin = emax
wire [12:0] emax = {3'b0, {3{db}}, {7{1'b1}}};

always @(*) begin

    if(TINY & ~UNFen) begin
        sh = er + emax;
    end
    else begin
        sh = {7'b0, lz[5:0]};
    end
end

endmodule

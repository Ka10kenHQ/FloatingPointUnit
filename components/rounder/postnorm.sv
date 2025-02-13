module postnorm(
    input [10:0] en,eni,
    input [53:0] f2,

    output reg sigovf,
    output reg [10:0] e2,
    output reg [52:0] f3
);

always @(*) begin

    sigovf = f2[53];

    if(f2[53:52] == 2'b10 && f2[51:0] == 52'b0) begin
        e2 = eni;
        f3 = {1'b1, 52'b0};
    end
    else begin
        e2 = en;
        f3 = f2[52:0];
    end

end


endmodule

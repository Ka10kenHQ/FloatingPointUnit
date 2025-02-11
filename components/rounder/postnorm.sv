module postnorm(
    input [10:0] en,eni,
    input [53:0] f2,

    output reg sigovf,
    output reg [10:0] e2,
    output reg [52:0] f3
);

always @(*) begin

    sigovf = f2[0];

    if(f2[0]) begin
        e2 = eni;
    end
    else begin
        e2 = en;
    end

    f3 = {f2[53] | f2[52], f2[51:0]};

end


endmodule

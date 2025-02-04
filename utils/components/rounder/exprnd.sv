module exprnd(
    input s,
    input [10:0] e3,
    input [52:0] f3,
    input [1:0] RM,
    input OVF,
    input db,
    input OVFen,

    output reg [10:0] eout,
    output reg [51:0] fout
);


reg inf;

always @(*) begin
    inf = (RM == 2'b01) | (RM == 2'b10 & ~s) | (RM == 2'b11 & s);

    if(OVF & OVFen) begin
        if(inf) begin
            // infinity
            eout = {{3{db}}, 8'b11111111};
            fout = 52'b0;
        end
        else begin
            // Xmax
            eout = {{3{db}}, 7'b1111111, 1'b0};
            fout = {{23{1'b1}}, {29{db}}};
        end
    end
    else begin
        eout = e3 & {11{f3[0]}};
        fout = f3[52:1];
    end
end


endmodule

`include "./../../utils/HDecJ.sv"
`include "./../../utils/ortree.sv"

module sticky (
    input [5:0] as2,
    input [54:0] fb2,
    output sticky
);

reg [54:0] temp;
wire [63:0] y;
parameter N = 6;
parameter n = 55;


HDecJ #(N) hdec(
    .x(as2),
    .y(y)
);

always @(*) begin
    integer i;
    for(i =0; i<= 54;i = i+1) begin
        temp[i] = fb2[i] & y[i];
    end
end

ortree #(n) or_tree(
    .x(temp),
    .or_out(sticky)
);


endmodule

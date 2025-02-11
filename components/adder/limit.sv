`include "./../../utils/ortree.sv"

module limit (
    input [10:0] as,
    input eb_gt_ea,
    output reg [5:0] as2
);
reg [10:0] as1;
wire or_out;

parameter n = 8;


ortree #(n) or_tree (
    .x({3'b000, as1[10:6]}),
    .or_out(or_out)
);

always @(*) begin
    as1 = eb_gt_ea ? ~as : as;
    as2 = as1[5:0] | or_out;
end


endmodule


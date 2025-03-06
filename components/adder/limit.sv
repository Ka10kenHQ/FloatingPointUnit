`include "./../../utils/ortree.sv"

module limit (
    input [10:0] as,
    input eb_gt_ea,
    output reg [5:0] as2
);
wire [10:0] as1;
assign as1 = eb_gt_ea ? ~as : as;


wire or_out;

parameter n = 5;

ortree #(n) or_tree (
    .x(as1[10:6]),
    .or_out(or_out)
);

assign as2 = as1[5:0] | or_out;


endmodule


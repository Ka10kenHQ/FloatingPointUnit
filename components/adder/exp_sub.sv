`include "./../../utils/add.sv"
// FIXME: some things dont line up with eb_gt_ea in tests
module exp_sub (
    input [10:0] ea,
    input [10:0] eb,

    output eb_gt_ea,
    output [10:0] as
);

wire [11:0] ina, inb;
wire [12:0] sum;

assign ina = {ea[10], ea[10:0]};
assign inb = {~eb[10], ~eb[10:0]};

parameter n = 12;
add #(n) ad(
    .a(ina),
    .b(inb),
    .c_in(1'b1),
    .sum(sum)
);

assign eb_gt_ea = sum[11];
assign as = sum[10:0];

endmodule

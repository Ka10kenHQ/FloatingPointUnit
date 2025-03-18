`include "./../../utils/add.sv"

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
    .a(inb),
    .b(ina),
    .c_in(1'b1), // NOTE: carry in
    .sum(sum)
);

assign eb_gt_ea = sum[11];
assign as = sum[10:0];

endmodule

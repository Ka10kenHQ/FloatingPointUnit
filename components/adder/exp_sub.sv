module exp_sub (
    input [10:0] ea,
    input [10:0] eb,

    output eb_gt_ea,
    output [10:0] as
);

wire [11:0] ina, inb, sum;

assign ina = {ea[10], ea[10:0]};
assign inb = {~eb[10], ~eb[10:0]};

assign sum = ina + inb + 1;
assign eb_gt_ea = sum[11];
assign as = sum[10:0];

endmodule

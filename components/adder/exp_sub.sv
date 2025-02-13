module exp_sub (
    input [10:0] ea,
    input [10:0] eb,

    output reg eb_gt_ea,
    output reg [10:0] as
);

reg [11:0] ina;
reg [11:0] inb;
reg [11:0] sum;

always @(*) begin
    ina = {ea[10],ea[10:0]};
    inb = {~eb[10],~eb[10:0]};

    sum = ina + inb + 1;
    eb_gt_ea = sum[11];
    as = sum[10:0];
end

endmodule

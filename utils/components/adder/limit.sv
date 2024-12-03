module limit (
    input [10:0] as,
    input eb_gt_ea,
    output [5:0] as2
);
    wire [10:0] as1;
    wire or_out;
    parameter n = 8;

    assign as1 = eb_gt_ea ? ~as : as;

    ortree #(n) or_tree (
        .x({3'b000, as1[10:6]}),
        .or_out(or_out)
    );

    assign as2 = as1[5:0] | {5'b00000, or_out};

endmodule


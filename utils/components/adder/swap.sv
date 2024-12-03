module swap (
    input sa,
    input [52:0] fa,
    input sb,
    input [52:0] fb,
    input eb_gt_ea,
    output sa2,
    output [52:0] fa2,
    output sb2,
    output [54:0] fb2
    );
    assign sa2 = eb_gt_ea ? sb : sa;
    assign fa2 = eb_gt_ea ? fb : fa;

    assign sb2 = eb_gt_ea ? sa : sb;
    assign fb2 = eb_gt_ea ? {2'b00, fb} : {fb, 2'b00};
endmodule

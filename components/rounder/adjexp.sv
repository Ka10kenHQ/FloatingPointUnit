module adjexp(
    input [10:0] e2,
    input db,
    input sigovf,
    input OVFen,

    output [10:0] e3,
    output OVF
);

wire [10:0] in = db ? e2 : {3'b111, e2[7:0]};
wire [7:0] emax1alpha = {2'b0, {3{db}}, 6'b111111};
wire out;

andtree andt(
    .x(in),
    .and_out(out)
);

assign OVF = sigovf & out;
assign e3 = (~OVFen & sigovf & out) ? {3'b000, emax1alpha} : e2;

endmodule


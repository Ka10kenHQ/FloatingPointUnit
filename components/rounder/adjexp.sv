module adjexp(
    input [10:0] e2,
    input db,
    input sigovf,
    input OVFen,

    output [10:0] e3,
    output OVF
);

wire [10:0] in;
wire [7:0] emax1alpha;
wire out;

assign in = db ? e2 : {3'b111, e2[7:0]};
assign emax1alpha = {2'b0, {3{db}}, 6'b111111};

andtree andt(
    .x(in),
    .and_out(out)
);

assign OVF = sigovf & out;
assign e3 = (~OVFen & sigovf & out) ? {3'b0,emax1alpha} : e2;

endmodule


module exprnd(
    input s,
    input [10:0] e3,
    input [52:0] f3,
    input [1:0] RM,
    input OVF,
    input db,
    input OVFen,

    output [10:0] eout,
    output [51:0] fout
);

wire inf;
wire [10:0] exp_xmax_inf;
wire [51:0] fp_xmax_inf;

assign inf = RM[1] ? ~(RM[0] ^ s) : RM[0];

assign exp_xmax_inf = inf ? {11'b11111111111} : {10'b1111111111, 1'b0};
assign fp_xmax_inf = inf ? 52'b0 : {{23{1'b1}}, {29{1'b1}}};


assign eout = (OVF & ~OVFen) ? exp_xmax_inf : e3[10:0] & {11{f3[52]}};
assign fout = (OVF & ~OVFen) ? fp_xmax_inf: f3[51:0];

endmodule


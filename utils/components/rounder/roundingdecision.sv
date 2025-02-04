module roundingdecision(
    input l,
    input r,
    input st,
    input s,
    input [1:0] RM,

    output inc
);

assign l1 = l | st;
assign l2 = r & RM[0];
assign l3 = l1 & l2;

assign r1 = st | r;
assign r2 = s ^ RM[0];
assign r3 = r1 & r2;

assign inc = RM[1] ? r3 : l3;

endmodule

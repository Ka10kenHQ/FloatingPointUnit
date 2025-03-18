module sigrnd(
    input s,
    input db,
    input [54:0] f1,
    input [1:0] RM,

    output [53:0] f2,
    output siginx
);

wire [53:0] temp;
wire l, r, st;

wire inc;

assign l = db ? f1[2] : f1[34];
assign r = db ? f1[1] : f1[33];
assign st = db ? f1[0] : f1[32];

assign siginx = r | st;

roundingdecision rdc(
    .l(l),
    .r(r),
    .st(st),
    .s(s),
    .RM(RM),
    .inc(inc)
);

assign temp = db ? (f1[54:2] + 1) : ({f1[54:31], {29{1'b1}}} + 1);

assign f2 = inc ? temp : {1'b0, f1[54:2]};

endmodule


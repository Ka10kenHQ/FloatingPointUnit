`include "./../../utils/three2add.sv"
`include "./../../utils/add.sv"

module select_fd(
    input  [57:0]  Da,
    input  [57:0]  Db,
    input  [114:0] Eb,
    input  [57:0]  E,
    input          db,

    output [56:0]  fd
);

wire [115:0] a, b, c;
wire [116:0] t, s;
wire [116:0] beta;
wire [55:0] r;
wire neg, zero;

assign a = {1'b0, Da, 56'b0, 1'b1};
assign b = {1'b1, ~Eb};
assign c = db ? {{26{1'b1}}, ~({29'b0, Db}), 3'b111}
              : {{26{1'b1}}, ~({Db, 29'b0}), 3'b111};

parameter n = 116;
three2add #(n) add(
    .a(a),
    .b(b),
    .c(c),
    .c_in(1'b0),
    .t(t),
    .s(s)
);

parameter m = 117;
wire [117:0] sum;
add #(m) ad(
    .a(t),
    .b(s),
    .c_in(1'b1),
    .sum(sum)
);

assign beta = sum[116:0];
assign neg = sum[117];
assign zero = (beta == 117'b0);

assign r = neg ?
        {1'b0, E[57:3]}
        : db ?
            (E[57:3] + 1)
            : {E[57:33], {29{1'b1}}} + 1;

assign fd[56:30] = r[55:29];
assign fd[29] = (db == 1) ? r[28] : ~zero;
assign fd[28:1] = r[27:0];
assign fd[0] = ~zero & db;

endmodule

`include "./../unpacker/leadingzero.sv"
`include "./../../utils/add.sv"

module flags(
    input  [56:0]  fr,
    input  [12:0]  er,
    input          db,

    output         TINY,
    output         OVF1,
    output  [5:0]  lz
);

wire [12:0] emax;
wire [12:0] emax_plus_1;

wire [13:0] sum;
wire [6:0] lz_out;

assign emax        = {3'b0, {3{db}}, {7{1'b1}}};
assign emax_plus_1 = {2'b0, 1'b1, ~db, {2{db}}, 7'b0};

wire er_gte_emax;
wire er_gt_emax;
wire er_gt_emax_plus_1;

leadingzero lzero(
    .x({fr, 7'b1111111}),
    .y(lz_out)
);

parameter n = 13;
add #(n) ad(
    .a({3'b0, {3{db}}, 1'b1,  ~lz_out[5:0]}),
    .b(er[12:0]),
    .c_in(1'b0),
    .sum(sum)
);

assign lz = lz_out[5:0];
assign TINY = sum[12];

structural_gte tester_gte (
    .a(er),
    .b(emax),
    .out(er_gte_emax)
);

structural_gt tester_gt_emax (
    .a(er),
    .b(emax),
    .out(er_gt_emax)
);

structural_gt tester_gt_emax_plus (
    .a(er),
    .b(emax_plus_1),
    .out(er_gt_emax_plus_1)
);

assign OVF1 = (fr[56] & er_gte_emax) 
                | (fr[55] & ~fr[56] & er_gt_emax) 
                | (fr[54] & ~fr[56] & ~fr[55] & er_gt_emax_plus_1);

endmodule


module signed_subtractor_13bit (
    input  wire [12:0] a,
    input  wire [12:0] b,
    output wire [12:0] diff,
    output wire        ovf
);

wire [13:0] c;
assign c[0] = 1'b1;

genvar i;
generate
    for (i = 0; i < 13; i = i + 1) begin
        assign diff[i] = a[i] ^ (~b[i]) ^ c[i];
        assign c[i+1]  = (a[i] & ~b[i]) | (c[i] & (a[i] ^ ~b[i]));
    end
endgenerate

assign ovf = (a[12] == 1'b0 && b[12] == 1'b1 && diff[12] == 1'b1) |
                  (a[12] == 1'b1 && b[12] == 1'b0 && diff[12] == 1'b0);

endmodule

module structural_gte (
    input  wire [12:0] a,
    input  wire [12:0] b,
    output wire        out
);

wire [12:0] diff;
wire        ovf;

signed_subtractor_13bit sub (
    .a(a),
    .b(b),
    .diff(diff),
    .ovf(ovf)
);

assign out = ovf ? diff[12] : ~diff[12];

endmodule


module structural_gt (
    input  wire [12:0] a,
    input  wire [12:0] b,
    output wire        out
);

wire gte_signal;
wire is_equal;

structural_gte gte_inst (
    .a(a),
    .b(b),
    .out(gte_signal)
);

assign is_equal = (a == b); 
assign out = gte_signal & ~is_equal;

endmodule


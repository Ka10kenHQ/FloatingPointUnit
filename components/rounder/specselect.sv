module specselect(
    input s,
    input [10:0] eout,
    input [51:0] fout,
    input [52:0] nan,
    input ZERO,
    input NAN,
    input INF,

    output sp,
    output [10:0] ep,
    output [51:0] fp
);

assign spec = (NAN | INF | ZERO);
assign sp =  spec ? nan[52] : s;
assign ep = spec ? {10'b0, ~ZERO} : eout;
assign fp = spec ? (NAN ? nan[51:0] : 52'b0) : fout;


endmodule

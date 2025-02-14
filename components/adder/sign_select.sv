module sign_select(
    input [1:0] RM,
    input       fz,
    input       sa,
    input       sx,
    input       sb,
    input       ss1,
    input       INFa,
    input       INFs,
    input       NAN,
    output      ZERO,
    output      ss
);

wire ss2, ss3;

assign ss2 = sx ? sa : RM[0] & RM[1];
assign ss3 = INFa ? sa : sb;
assign ss = INFs ? ss3 : (fz ? ss2 : ss1);
assign ZERO = ~(INFs | NAN) & fz;

endmodule


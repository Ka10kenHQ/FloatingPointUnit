module sign_select(
    input [1:0] RM,
    input fz,
    input sa,
    input sx,
    input sb,
    input ss1,
    input INF,
    input NAN,
    output ZERO,
    output ss
);

wire ss2, ss3;

assign ss2 = sx ? sa : RM[0] & RM[1];
assign ss3 = INF ? sa : sb;
assign ss = INF ? ss3 : (fz ? ss1 : ss2);
assign ZERO = ~(INF | NAN);

endmodule


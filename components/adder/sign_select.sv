module sign_select(
    input [1:0] RM,
    input fz,
    input sa,
    input sx,
    input sb,
    input ss1,
    input INFa,
    input INFs,
    input NAN,
    output reg ZERO,
    output reg ss
);

reg ss2, ss3;

always @(*) begin
    ss2 = sx ? sa : RM[0] & RM[1];
    ss3 = INFa ? sa : sb;
    ss = INFs ? ss3 : (fz ? ss2 : ss1);
    ZERO = ~(INFs | NAN) & fz;
end

endmodule


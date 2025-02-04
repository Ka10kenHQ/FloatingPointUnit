module sigrnd(
    input s,
    input db,
    input [54:0] f1,
    input [1:0] RM,

    output reg [53:0] f2,
    output reg siginx

);

reg [53:0] temp;
reg l,r,st;

wire inc;

roundingdecision rdc(
    .l(l),
    .r(r),
    .st(st),
    .s(s),
    .RM(RM),
    .inc(inc)
);


always @(*) begin

    if(db) begin
        temp = f1[52:0] + 1;
        l = f1[52];
        r = f1[53];
        st = f1[54];
    end
    else begin
        temp = {f1[23:0], {29{1'b1}}} + 1;
        l = f1[23];
        r = f1[24];
        st = f1[25];
    end

    siginx = r | st;

    if(inc) begin
        f2 = temp;
    end
    else begin
        f2 = {1'b0, f1[52:0]};
    end
end


endmodule

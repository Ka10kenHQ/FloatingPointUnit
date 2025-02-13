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
        l = f1[2];
        r = f1[1];
        st = f1[0];
    end
    else begin
        temp = {f1[54:31], {29{1'b1}}} + 1;
        l = f1[34];
        r = f1[33];
        st = f1[32];
    end

    siginx = r | st;

    if(inc) begin
        f2 = temp;
    end
    else begin
        //NOTE: modification from slides (its not in book)
        if(db) begin
            f2 = {1'b0, f1[52:0]};
        end
        else begin
            f2 = {1'b0, f1[52:32], 30'b0};
        end
    end
end


endmodule

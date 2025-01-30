module select_fb(
    input [57:0] Da,
    input [57:0] Db,

    input [114:0] Eb,

    input db,
    input [54:0] E,

    output reg [56:0] fd
);

reg [115:0] a,b,c;

wire [116:0] t,s;
reg [116:0] beta;
reg neg, zero;
reg [55:0] r;

parameter n = 115;


three2add #(n) add(
    .a(a),
    .b(b),
    .c(c),
    .c_in(0),
    .t(t),
    .s(s)
);

always @(*) begin
    a = {{1'b0, Da}, {56'b0, 1'b1}};
    b = {1'b1, ~Eb};
    
    if(db) begin
        c = {{26{1'b1}}, ~({29'b0, Db}), 3'b111};
    end
    else begin
        c = {{26{1'b1}}, ~({Db, 29'b0}), 3'b111};
    end

    beta = t + s + 1;
    neg = beta[116];

    zero = (beta == 117'b0);


    if(neg) begin
        r = {1'b0, E};
    end
    else begin
        if(db) begin
            r = E + 1;
        end
        else begin
            r = {E[25:0], {29{1'b1}}} + 1;
        end
    end

    fd[26:0] = r[26:0];
    fd[27] = (db == 1)? r[27] : ~zero;
    fd[55:28] = r[55:28];
    fd[56] = ~zero & db;

end



endmodule

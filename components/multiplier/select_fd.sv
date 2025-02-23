`include "./../../utils/three2add.sv"
`include "./../../utils/add.sv"

module select_fd(
    input wire [57:0]  Da,
    input wire [57:0]  Db,

    input wire [114:0] Eb,
    input wire [54:0]  E,

    input wire         db,

    output reg [56:0]  fd
);

reg [115:0] a,b,c;

wire [116:0] t,s;
reg [116:0] beta;
reg neg, zero;
reg [55:0] r;

parameter n = 116;

three2add #(n) add(
    .a(a),
    .b(b),
    .c(c),
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

always @(*) begin
    a = {1'b0, Da, 56'b0, 1'b1};
    b = {1'b1, ~Eb};
    
    if(db) begin
        c = {{26{1'b1}}, ~({29'b0, Db}), 3'b111};
    end
    else begin
        c = {{26{1'b1}}, ~({Db, 29'b0}), 3'b111};
    end
    beta = sum[116:0];
    neg = beta[117];

    zero = (beta == 117'b0);


    if(neg) begin
        r = {1'b0, E};
    end
    else begin
        if(db) begin
            r = E + 1;
        end
        else begin
            r = {E[54:30], {29{1'b1}}} + 1;
        end
    end

    fd[56:30] = r[55:29];
    fd[29] = (db == 1)? r[28] : ~zero;
    fd[28:1] = r[27:0];
    fd[0] = ~zero & db;

end



endmodule

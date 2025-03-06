`include "./../../utils/ortree.sv"

// FIXME: needs to remove always@(*) 
module sigfmd (
    input [52:0]      fa,
    input [52:0]      fb,
    input             fdiv,
    input             db,
    input             init,
    output reg [56:0] fq
);

wire [7:0] look_up;

rom256X8 rm(
    .addr(fb[51:44]),
    .data(look_up)
);

reg [57:0] fa_in, fb_in;
wire [115:0] mul_out;

multree mlt(
    .a(fa_in),
    .b(fb_in),
    .out(mul_out)
);

wire [56:0] fd_out;

select_fd fd_inst(
    .Da({fa, 5'b0}),
    .Db({fb, 5'b0}),
    .Eb(mul_out[114:0]),
    .E({mul_out[115:90], ({29{db}} & mul_out[89:61])}),
    .db(db),
    .fd(fd_out)
);

wire [115:0] regular_mul;
multree regmul(
    .a({fa, 5'b0}),
    .b({fb, 5'b0}),
    .out(regular_mul)
);

parameter n = 60;
wire or_out;
ortree #(n) or_inst(
    .x(regular_mul[59:0]),
    .or_out(or_out)
);

reg [2:0] state;
reg [1:0] Dcnt;
reg [1:0] oe1_reg;
reg oe2_reg;

always @(posedge init) begin
    Dcnt <= db ? 2'b11 : 2'b10;
    #5;
    state <= 0;
end

always @(state) begin
    case (state)
        0: begin
            fa_in <= {2'b01, look_up[7:0], 48'b0};
            fb_in <= {fb , 5'b0};
            state <= 1;
        end
        1: begin
            fa_in <= mul_out[115:58];
            fb_in <= {fb, 5'b0};
            Dcnt <= Dcnt - 1;
            state <= 2;
        end
        2: begin
            fa_in <= ~mul_out[115:90];
            fb_in <= mul_out[115:68];
            Dcnt <= Dcnt - 1;
            state <= 3;
        end
        3: begin
            fa_in <= {fa, 5'b0};
            fb_in <= mul_out[115:68];
            state <= 4;
        end
        4: begin
            fa_in <= {mul_out[115:90], ({29{db}} & mul_out[89:61]), 3'b0};
            fb_in <= {fb, 5'b0};
            state <= 5;
        end
        default: begin $display("doing nothing"); end
    endcase
end

always @(*) begin
    fq = fdiv ? fd_out : {regular_mul[115:60], or_out};
end

endmodule


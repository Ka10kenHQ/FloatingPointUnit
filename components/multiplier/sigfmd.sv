`include "./../../utils/ortree.sv"

module sigfmd (
    input [52:0]      fa,
    input [52:0]      fb,
    input             fdiv,
    input             db,
    input [1:0]       oe1,
    input             oe2,
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

reg [1:0] Dcnt;
reg [2:0] iter;
reg [1:0] oe1_reg;
reg oe2_reg;

integer i;
always @(oe1[0] & oe1[1] & ~oe2) begin
    Dcnt = db ? 2'b11 : 2'b10;
    iter = 1;
    oe1_reg = oe1;
    oe2_reg = oe2;

    do begin
        if(oe1_reg[0] & oe1_reg[1] & ~oe2_reg) begin
            if(iter == 1) begin
                $display("im here 1");
                fa_in = {2'b01, look_up[7:0], 48'b0};
                fb_in = {fb , 5'b0};
            end
            else if(iter == 2) begin
                $display("im here 2");
                fa_in = mul_out[115:58];
                fb_in = {fb, 5'b0};
                oe1_reg = 2'b10;
                oe2_reg = 1'b1;
            end
            Dcnt = Dcnt - 1;
            $display("Dcnt = %d", Dcnt);
        end
        else if(~oe1_reg[0] & oe1_reg[1] & oe2_reg) begin
            fa_in = ~mul_out[115:90];
            fb_in = mul_out[115:68];
        end
        $display("iter = %d", iter);
        iter = iter + 1;

        if(iter == 5 && Dcnt > 0) begin 
            iter = 1;
        end
        else if(Dcnt == 0) begin
            oe1_reg = 2'b01;
            oe2_reg = 1'b1;
        end
    end while(Dcnt > 0);

    $display("then i am here");
    for(i = 1; i < 5; i = i +1) begin
        if(~oe1_reg[1] & oe1_reg[0] & oe2_reg) begin
            fa_in = {fa, 5'b0};
            fb_in = mul_out[115:68];
            oe2_reg = 1'b0;
            $display("Am i inside?");
        end
        else if(~oe1_reg[1] & oe1_reg[0] & ~oe2_reg) begin
            fa_in = {fa, 5'b0};
            fb_in = {mul_out[115:68]};
            oe1_reg = 2'b00;
            oe2_reg = 1'b0;
            $display("Am i inside 2 ?");
        end
        else if(~oe1_reg[1] & ~oe1_reg[0] & ~oe2_reg) begin
            fa_in = {mul_out[115:90], ({29{db}} & mul_out[89:61]), 3'b0};
            fb_in = {fb, 5'b0};
            $display("Am i inside 3 ?");

        end
    end
end

always @(*) begin
    fq = fdiv ? fd_out : {regular_mul[115:60], or_out};
end

endmodule


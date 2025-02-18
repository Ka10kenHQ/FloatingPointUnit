`include "./../../utils/ortree.sv"

module sigfmd (
    input [52:0] fa,
    input [52:0] fb,
    input fdiv,
    input db,
    output reg [56:0] fq
);

reg [7:0] look_up;

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

wire [115:0] quot1_out, quot2_out, quot3_out, quot4_out;

multree quot1(
    .a({fa, 5'b0}),
    .b(mul_out[115:58]),
    .out(quot1_out)
);

multree quot2(
    .a({fa, 5'b0}),
    .b(quot1_out[115:58]),
    .out(quot2_out)
);

multree quot3(
    .a({quot2_out[115:90], ({29{db}} & quot2_out[89:61]), 3'b0}),
    .b({fb, 5'b0}),
    .out(quot3_out)
);

multree quot4(
    .a({quot3_out[115:90], ({29{db}} & quot3_out[89:61]), 3'b0}),
    .b({fb, 5'b0}),
    .out(quot4_out)
);

wire [56:0] fd_out;

select_fb fd_inst(
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


integer Dcnt;
integer iter;

reg [1:0] oe1;
reg oe2;

initial begin
    oe2 = 1'b0;
    Dcnt = db ? 3 : 2;
    iter = 1;
    oe1 = 2'b11;
end

always @(*) begin
    do begin
        if((oe1 == 2'b11) && ~oe2) begin
            if(iter == 1) begin
                fa_in = {2'b01, look_up[7:0], 48'b0};
                fb_in = {fb , 5'b0};
            end
            else
            if(iter == 2) begin
                fa_in = mul_out[115:58];
                fb_in = {fb, 5'b0};
            end
            Dcnt = Dcnt - 1;
        end
        else if((oe1 == 2'b10) && oe2) begin
            fa_in = ~mul_out[115:90];
            fb_in = mul_out[115:68];
        end
        iter = iter + 1;
    end while(Dcnt > 0);
    
    fq = fdiv ? fd_out : {regular_mul[115:60], or_out};
end

endmodule


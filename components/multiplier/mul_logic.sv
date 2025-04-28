module mul_logic (
    input [52:0] fa,        
    input [52:0] fb,  
    output [56:0] fq 
);

wire [57:0] fa_in, fb_in;
assign fa_in = {fa, 5'b0};
assign fb_in = {fb, 5'b0};


wire [115:0] mul_out;        
multree mlt (
    .a(fa_in),
    .b(fb_in),
    .out(mul_out)
);


parameter n = 60;
wire or_out;
ortree #(n) or_inst (
    .x(mul_out[59:0]),
    .or_out(or_out)
);

assign fq = {mul_out[115:60], or_out};


endmodule


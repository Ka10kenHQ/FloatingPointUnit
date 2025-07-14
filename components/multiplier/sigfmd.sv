`include "./../../utils/ortree.sv"

module sigfmd (
    input             clk,      
    input             rst_n,     
    input [52:0]      fa,        
    input [52:0]      fb,  
    input             fdiv, 
    input             db,      
    output [56:0]     fq
);


wire [56:0] fq_mul;
wire [56:0] fq_div;

div_logic divis (
    .clk(clk),
    .rst_n(rst_n),
    .fa(fa),
    .fb(fb),
    .db(db),
    .fdiv(fdiv),
    .fq(fq_div)
);

mul_logic mult (
    .fa(fa),
    .fb(fb),
    .fq(fq_mul)
);

assign fq = (fdiv) ? fq_div : fq_mul;
 
endmodule

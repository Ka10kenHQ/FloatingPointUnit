`include "./../../utils/ortree.sv"

module sigfmd (
    input [52:0]      fa,        
    input [52:0]      fb,  
    input             fdiv, 
    input             db,      
    output [56:0] fq         
);


wire [56:0] fq_mul;
wire [56:0] fq_div;

div_logic div_inst (
    .fa(fa),
    .fb(fb),
    .db(db),
    .fdiv(fdiv),
    .fq(fq_div)
);

mul_logic mul_inst (
    .fa(fa),
    .fb(fb),
    .fq(fq_mul)
);

assign fq = (fdiv) ? fq_div : fq_mul;
 
endmodule

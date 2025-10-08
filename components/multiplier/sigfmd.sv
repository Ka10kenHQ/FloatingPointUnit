`include "./../../utils/ortree.sv"

module sigfmd (
    input           clk,
    input           rst_n,
    input   [52:0]  fa,        
    input   [52:0]  fb,  
    input           fdiv, 
    input           db,      
    output  [56:0]  fq         
);

reg [56:0] fq_mul;
reg [56:0] fq_div;

div_logic div_inst (
    .clk(clk),
    .rst_n(rst_n),
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

assign fq = fdiv ? fq_div : fq_mul;

endmodule

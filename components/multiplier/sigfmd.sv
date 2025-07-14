`include "./../../utils/ortree.sv"

module sigfmd (
    input             clk,       // Add clock input
    input             rst_n,     // Add reset input
    input             start_div, // Add start signal for division
    input [52:0]      fa,        
    input [52:0]      fb,  
    input             fdiv, 
    input             db,      
    output [56:0]     fq,        
    output            div_ready  // Add ready signal
);


wire [56:0] fq_mul;
wire [56:0] fq_div;
wire div_ready_sig;

div_logic divis (
    .clk(clk),
    .rst_n(rst_n),
    .start_div(start_div),
    .fa(fa),
    .fb(fb),
    .db(db),
    .fdiv(fdiv),
    .fq(fq_div),
    .div_ready(div_ready_sig)
);

mul_logic mult (
    .fa(fa),
    .fb(fb),
    .fq(fq_mul)
);

assign fq = (fdiv) ? fq_div : fq_mul;
assign div_ready = fdiv ? div_ready_sig : 1'b1; // Multiplication is combinational, always ready
 
endmodule

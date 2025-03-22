module cls #(parameter N = 53)(
    input  [5:0] m,
    input   [N-1:0] x, 
    output [N-1:0] y  
);
    
assign y = (x >> (N - m) | (x << m));    

endmodule

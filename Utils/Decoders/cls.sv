module cls #(
    parameter N = 53
)(
    input wire [5:0] m,
    input  wire [N-1:0] x, 
    output reg [N-1:0] y  
);
    
always @* begin
    y =(x >> (N - m) | (x << m));    
end
endmodule

module Dec #(
    parameter N = 2
)(
    input  wire [N-1:0] x, 
    output reg [2**N-1:0] y  
);

    reg [N/2-1:0] x1;
    reg [N/2-1:0] x2;
    reg [2**(N/2)-1:0] U;
    reg [2**(N/2)-1:0] V;
    
    generate
        if (N > 1) begin : recursive_case
            Dec #(N/2) higher_decoder (
                .x(x[N-1:N/2]),          
                .y(U)               
            );
            
            Dec #(N/2) lower_decoder (
                .x(x[N/2-1:0]),          
                .y(V)               
            );
            
            integer i,j;
            always @* begin
                y = 0;
                for(i = 0; i < 2**(N/2); i = i + 1) begin
                    for(j = 0; j < 2**(N/2); j=j+1) begin
                        y[i*2**(N/2) + j] = U[i] & V[j];
                    end
                end 
            end
        end
        else begin : base_case
                assign y[0] = ~x[0];        
                assign y[1] = x[0];     
          
        end
    endgenerate

endmodule

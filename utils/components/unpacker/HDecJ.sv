module HDecJ #(
    parameter N = 2
)(
    input  [N-1:0] x, 
    output reg [2**N-1:0] y  
);

    reg [N/2-1:0] x1;
    reg [N/2-1:0] x2;
    reg [2**(N/2)-1:0] U;
    reg [2**(N/2)-1:0] V;
    
    generate
        if (N > 1) begin : recursive_case
            HDecJ #(N/2) higher_decoder (
                .x(x[N-1:N/2]),          
                .y(U)               
            );
            
            HDecJ #(N/2) lower_decoder (
                .x(x[N/2-1:0]),          
                .y(V)               
            );
            
            integer i;
            always @* begin
		integer IL, IH;
                for(i = 0; i < 2**N; i = i + 1) begin
                    IL = i % (2**(N/2));
                    IH = i / (2**(N/2));
                    if (IH == 0) begin
                        y[IL] = U[0] | V[IL]; 
                    end else begin
                        y[i] = U[IH] | (U[IH-1] & V[IL]); 
                    end
                end 
            end
        end
        else begin : base_case
                assign y[0] = x[0];        
                assign y[1] = 0;     
          
        end
    endgenerate

endmodule

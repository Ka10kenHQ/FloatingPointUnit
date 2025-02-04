module HDec #(
    parameter N = 2
)(
    input  logic [N-1:0] x, 
    output logic [2**N-1:0] y  
);

    generate
        if (N > 1) begin : recursive_case
            logic [2**(N-1)-1:0] U;
            HDec #(N-1) lower_decoder (
                .x(x[N-2:0]),          
                .y(U)               
            );

            assign y[2**(N-1)-1:0]     = U | {2**(N-1){x[N-1]}};  
            assign y[2**N-1:2**(N-1)]  = U & {2**(N-1){x[N-1]}};   
        end
        else begin : base_case
            assign y[0] = x[0];        
            assign y[1] = 0;     
        end
    endgenerate

endmodule

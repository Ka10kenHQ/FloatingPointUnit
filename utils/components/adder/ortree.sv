module ortree #(
    parameter n = 2
)(
    input [n-1:0] x, 
    output or_out 
);

    localparam next_power_of_2 = 2 ** $clog2(n);

    generate
        if (n > 1) begin : recursive_case
            wire L;
            wire U;
            
            ortree #(n/2) lower_or (
                .x(x[(n/2) - 1:0]),          
                .or_out(L)               
            );

            ortree #(n/2) upper_or (
                .x(x[n-1:n/2]),          
                .or_out(U)               
            );

            assign or_out = L | U;
        end
        else begin : base_case
            assign or_out = x[0]; 
        end
    endgenerate

endmodule


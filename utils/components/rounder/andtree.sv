module andtree #(
    parameter n = 2
)(
    input [n-1:0] x, 
    output and_out 
);

    localparam npof2 = 2 ** $clog2(n);

    wire [npof2-1:0] padded_x;
    assign padded_x = { {npof2 - n{1'b0}}, x };

    generate
        if (npof2 > 1) begin : recursive_case
            wire L;
            wire U;

            andtree #(npof2 / 2) lower_and (
                .x(padded_x[(npof2 / 2) - 1:0]),          
                .and_out(L)               
            );

            andtree #(npof2 / 2) upper_and (
                .x(padded_x[npof2-1:(npof2 / 2)]),          
                .and_out(U)               
            );

            assign and_out = L & U;
        end
        else begin : base_case
            assign and_out = padded_x[0]; 
        end
    endgenerate

endmodule



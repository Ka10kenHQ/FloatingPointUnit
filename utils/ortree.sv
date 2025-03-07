module ortree #(
    parameter n = 2,
    parameter npof2 = 2 ** $clog2(n)
)(
    input [n-1:0] x, 
    output or_out 
);
    wire [npof2-1:0] padded_x;
    assign padded_x = { {npof2 - n{1'b0}}, x};

    generate
        if (npof2 > 1) begin : recursive_case
            wire L;
            wire U;

            ortree #(.n(npof2 / 2), .npof2(npof2 / 2)) lower_or (
                .x(padded_x[(npof2 / 2) - 1:0]),          
                .or_out(L)               
            );

            ortree #(.n(npof2 / 2), .npof2(npof2 / 2)) upper_or (
                .x(padded_x[npof2-1:(npof2 / 2)]),          
                .or_out(U)               
            );

            assign or_out = L | U;
        end
        else begin : base_case
            assign or_out = padded_x[0]; 
        end
    endgenerate

endmodule

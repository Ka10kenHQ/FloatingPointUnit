// hdec.sv - Hierarchical Decoder

module HDec #(
    parameter N = 2  // Width of the input (number of bits)
)(
    input  logic [N-1:0] x,    // Input vector
    output logic [2**N-1:0] y  // Output decoded vector
);

    // Recursive case: when N > 1
    if (N > 1) begin
        // Intermediate signals
        logic [2**(N-1)-1:0] U;     // Output from (N-1)-bit decoder

        // Instantiate (N-1)-bit decoder
        HDec #(N-1) lower_decoder (
            .x(x[N-2:0]),           // Connect lower bits of input
            .y(U)                   // Connect to U output
        );

        // Generate higher and lower outputs based on MSB (x[N-1])
        assign y[2**(N-1)-1:0]     = U & {2**(N-1){~x[N-1]}};  // Lower half selected when x[N-1] = 0
        assign y[2**N-1:2**(N-1)]  = U & {2**(N-1){x[N-1]}};   // Upper half selected when x[N-1] = 1
    end
    // Base case: when N = 1
    else begin
        assign y[0] = ~x[0];        // For x = 0, set y[0]
        assign y[1] = x[0];         // For x = 1, set y[1]
    end

endmodule
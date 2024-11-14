module tb_HDec;

    // Parameters and signals
    parameter N = 3;  // Set the input width to 3 for testing
    logic [N-1:0] x;  // Input vector
    logic [2**N-1:0] y;  // Output vector

    // Instantiate the Device Under Test (DUT)
    HDec #(N) dut (
        .x(x),
        .y(y)
    );

    // Apply test cases
    initial begin
        // Apply different inputs
        for (int i = 0; i < 2**N; i++) begin
            x = i;  // Apply input
            #50;   
        end

        $finish;  // End the simulation
    end

endmodule

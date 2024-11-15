module tb_CLS;

    // Parameters and signals

    parameter N = 53;  // Set the input width to 3 for testing
    logic [N-1:0] x;  // Input vector
    logic [N-1:0] y;  // Output vector
    logic [5:0] m;    
    // Instantiate the Device Under Test (DUT)
    CLS #(N) dut (
        .m(m),
        .x(x),
        .y(y)
    );

    
    // Apply test cases
    initial begin
        u = 0;
        m = 6'b000110;
        // Apply different inputs
        for (int i = 0; i < N; i++) begin
            x = i;  // Apply input
            #10;   
        end
         
        $finish;  // End the simulation
    end

endmodule

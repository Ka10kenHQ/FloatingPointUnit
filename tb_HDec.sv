module tb_HDec;

    // Testbench parameters
    parameter N = 3;  // Set the input width to 3 for testing (adjust as needed)
    
    // Testbench signals
    logic [N-1:0] x;      // Input vector (x)
    logic [2**N-1:0] y;    // Output vector (y)

    // Instantiate the Device Under Test (DUT)
    HDec #(N) dut (
        .x(x),
        .y(y)
    );

    // Generate a clock (if necessary, not used here but added for completeness)
    logic clk;
    always begin
        #5 clk = ~clk;  // 100MHz clock
    end

    // Apply test cases
    initial begin
        // Initialize signals
        clk = 0;
        x = 0;

        // Display header for the results
        $display("Time\tInput (x)\tOutput (y)");

        // Test all input combinations for N=3 (x goes from 0 to 7)
        for (int i = 0; i < 2**N; i++) begin
            x = i;  // Apply each possible input combination
            #10;    // Wait for simulation to settle (adjust if needed)

            // Display input and output values
            $display("%0t\t%b\t\t%b", $time, x, y);
        end

        // Finish the simulation
        $finish;
    end

endmodule
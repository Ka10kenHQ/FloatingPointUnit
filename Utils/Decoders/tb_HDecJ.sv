module tb_HDecJ;

    // Parameters
    parameter N = 4;
    
    // Test Inputs
    reg [N-1:0] x;
    
    // Test Outputs
    wire [2**N-1:0] y;
    
    // Instantiate the Unit Under Test (UUT)
    HDecJ #(N) uut (
        .x(x),
        .y(y)
    );
    
    initial begin
        // Apply Test Stimulus
        x = 4'b1000;  // Test input 00
        #50;        // Wait 10 time units
        
        x = 4'b0001;  // Test input 01
        #50;        // Wait 10 time units
        
        x = 4'b0011;  // Test input 10
        #50;        // Wait 10 time units
        
        x = 4'b1100;  // Test input 11
        #50;        // Wait 10 time units

    end
    
endmodule

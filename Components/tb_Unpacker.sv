module tb_Unpacker;

    // Parameters and signals
    parameter N = 64;
    
    // Input signals
    reg dbs;
    reg [N-1:0] x;
    reg ez;
    reg normal;

    // Output signals
    wire [5:0] lz;
    wire [52:0] f;
    wire fz;
    wire [51:0] h;

    // Instantiate the Unpacker module (DUT)
    Unpacker #(N) uut (
        .dbs(dbs),
        .x(x),
        .ez(ez),
        .normal(normal),
        .lz(lz),
        .f(f),
        .fz(fz),
        .h(h)
    );

    // Apply test cases
    initial begin
        // Test case 1
        dbs = 0;
        x = 64'hA5A5A5A5A5A5A5A5;  // Sample input value
        ez = 0;
        normal = 1;
        #10;
        
        // Test case 2
        dbs = 1;
        x = 64'h1F1F1F1F1F1F1F1F;  // Another sample input value
        ez = 1;
        normal = 0;
        #10;

        // Test case 3
        dbs = 0;
        x = 64'hDEADBEEFDEADBEEF;  // Another input pattern
        ez = 0;
        normal = 1;
        #10;

        // Test case 4
        dbs = 1;
        x = 64'hFFFFFFFFFFFFFFFF;  // All bits set
        ez = 1;
        normal = 0;
        #10;

        // Test case 5
        dbs = 0;
        x = 64'h1234567890ABCDEF;  // Random 64-bit value
        ez = 0;
        normal = 1;
        #10;

        $finish;  // End simulation
    end

    // Display the values of the outputs
    initial begin
        $monitor("At time %t, dbs = %b, x = %h, ez = %b, normal = %b, lz = %h, f = %h, fz = %b, h = %h", 
                  $time, dbs, x, ez, normal, lz, f, fz, h);
    end

endmodule
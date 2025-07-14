// `include "./../sigfmd.sv"

module tb_sigfmd;
    reg clk, rst_n, start_div;
    reg [52:0] fa, fb;
    reg fdiv, db;
    wire [56:0] fq;
    wire div_ready;
    
    sigfmd uut (
        .clk(clk),
        .rst_n(rst_n),
        .start_div(start_div),
        .fa(fa),
        .fb(fb),
        .fdiv(fdiv),
        .db(db),	
        .fq(fq),
        .div_ready(div_ready)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        start_div = 0;
        fdiv = 0;
        db = 0;
        fa = 0;
        fb = 0;
        
        // Reset sequence
        #10 rst_n = 1;
        #10;
        
        // Test division
        fa = 53'h3F2E1D0C9B;
        fb = 53'h7A6B5C4D3E;
        fdiv = 1;
        db = 1;
        start_div = 1;
        #10 start_div = 0;
        
        // Wait for division to complete
        wait(div_ready);
        #10;
        
        $display("Division result: %h", fq);
        $finish;
    end

endmodule


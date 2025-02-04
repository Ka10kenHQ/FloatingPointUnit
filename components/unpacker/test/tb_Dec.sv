`include "./../Dec.sv"
module tb_Dec;

    parameter N = 3;  
    reg [N-1:0] x;  
    wire [2**N-1:0] y; 

    Dec #(N) dut (
        .x(x),
        .y(y)
    );

    initial begin
        for (int i = 0; i < 2**N; i++) begin
            x = i;  
            #10;   
        end

    end

endmodule

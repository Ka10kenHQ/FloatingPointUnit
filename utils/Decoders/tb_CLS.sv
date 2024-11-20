module tb_CLS;


    parameter N = 53;
    wire [N-1:0] x;
    wire [N-1:0] y; 
    wire [5:0] m;

    cls #(N) dut (
        .m(m),
        .x(x),
        .y(y)
    );

    
    initial begin
        u = 0;
        m = 6'b000110;
        for (int i = 0; i < N; i++) begin
            x = i;  
            #10;   
        end  
    end

endmodule

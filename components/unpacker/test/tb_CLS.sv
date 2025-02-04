`include "./../cls.sv"
module tb_CLS;


    parameter N = 53;
    reg [N-1:0] x;
    reg [5:0] m;
    wire [N-1:0] y; 


    cls #(N) dut (
        .m(m),
        .x(x),
        .y(y)
    );

    reg u;

    initial begin
        u = 0;
        m = 6'b000110;
        for (int i = 0; i < N; i++) begin
            x = i;  
            #10;   
        end  
    end

endmodule

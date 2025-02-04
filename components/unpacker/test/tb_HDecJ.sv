`include "./../HDecJ.sv"

module tb_HDecJ;

    parameter N = 4;
    
    reg [N-1:0] x;
    
    wire [2**N-1:0] y;
    
    HDecJ #(N) uut (
        .x(x),
        .y(y)
    );
    
    initial begin
        x = 4'b1000;  
        #50;        
        
        x = 4'b0001;
        #50;    
        
        x = 4'b0011;
        #50;       
        
        x = 4'b1100;
        #50;      

    end
    
endmodule

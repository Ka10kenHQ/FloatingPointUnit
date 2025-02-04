module tb_exprnd;

    reg s;
    reg [10:0] e3;
    reg [52:0] f3;
    reg [1:0] RM;
    reg OVF;
    reg OVFen;
    
    wire [10:0] eout;
    wire [51:0] fout;
    
    exprnd uut (
        .s(s),
        .e3(e3),
        .f3(f3),
        .RM(RM),
        .OVF(OVF),
        .OVFen(OVFen),
        .eout(eout),
        .fout(fout)
    );
    
    initial begin
        $monitor("Time=%0t s=%b e3=%b f3=%b RM=%b OVF=%b OVFen=%b -> eout=%b fout=%b", 
                 $time, s, e3, f3, RM, OVF, OVFen, eout, fout);
        
        s = 0; e3 = 11'b00000000000; f3 = 53'b0; RM = 2'b00; OVF = 0; OVFen = 0; #10;
        s = 0; e3 = 11'b11111111111; f3 = 53'b1; RM = 2'b01; OVF = 1; OVFen = 1; #10;
        s = 1; e3 = 11'b10101010101; f3 = 53'b101010101010101; RM = 2'b10; OVF = 1; OVFen = 1; #10;
        s = 0; e3 = 11'b01010101010; f3 = 53'b1100110011001100; RM = 2'b11; OVF = 1; OVFen = 1; #10;
        s = 1; e3 = 11'b00110011001; f3 = 53'b1110001110001110; RM = 2'b00; OVF = 0; OVFen = 1; #10;
        
    end

endmodule

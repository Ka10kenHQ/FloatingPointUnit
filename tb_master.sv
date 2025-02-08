module tb_master;

    reg [63:0] fpa, fpb;
    reg db, normal, sub;
    reg [1:0] RM;
    
    wire [63:0] fp_out;
    wire [4:0] IEEp;
    
    master uut (
        .fpa(fpa),
        .fpb(fpb),
        .db(db),
        .normal(normal),
        .sub(sub),
        .RM(RM),
        .fp_out(fp_out),
        .IEEp(IEEp)
    );
    
    initial begin
        fpa = 64'h4016000000000000; 
        fpb = 64'h400c000000000000; 
        db = 0;
        normal = 1;
        sub = 0;
        RM = 2'b00; 
        
        #10;
        $display("Test Case 1: %f + %f = %f", $bitstoreal(fpa), $bitstoreal(fpb), $bitstoreal(fp_out));
        
        fpa = 64'hc016000000000000; 
        fpb = 64'h400c000000000000; 
        sub = 1;
        
        #10;
        $display("Test Case 2: %f - %f = %f", $bitstoreal(fpa), $bitstoreal(fpb), $bitstoreal(fp_out));
        
        fpa = 64'h7FF0000000000000; 
        fpb = 64'h4000000000000000;
        sub = 0;
        
        #10;
        $display("Test Case 3: %f + %f = %f", $bitstoreal(fpa), $bitstoreal(fpb), $bitstoreal(fp_out));
        
        #10;
    end
    
endmodule


`include "./../sigrnd.sv"

module tb_sigrnd;

    reg s;
    reg db;
    reg [54:0] f1;
    reg [1:0] RM;
    wire [53:0] f2;
    wire siginx;

    sigrnd uut (
        .s(s),
        .db(db),
        .f1(f1),
        .RM(RM),
        .f2(f2),
        .siginx(siginx)
    );

    initial begin
        s = 1'b0;
        db = 1'b1;
        f1 = 55'h123456789ABCDE;
        RM = 2'b01;
        
        #10;
        s = 1'b1;
        db = 1'b0;
        f1 = 55'hAABBCCDDEEFF00;
        RM = 2'b10;

        #10;
        s = 1'b0;
        db = 1'b1;
        f1 = 55'h11223344556677;
        RM = 2'b11;

        #10;
        s = 1'b1;
        db = 1'b0;
        f1 = 55'h87654321ABCDEF;
        RM = 2'b00;
        
        #10;
        $finish;
    end

    initial begin
        $monitor("Time: %0t | s: %b | db: %b | f1: %h | RM: %b | f2: %h | siginx: %b", $time, s, db, f1, RM, f2, siginx);
    end

endmodule


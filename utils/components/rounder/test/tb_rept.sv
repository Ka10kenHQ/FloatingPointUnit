`include "./../rept.sv"

module tb_rept;

    reg [127:0] fn;
    reg db;
    wire [54:0] f1;

    rept uut (
        .fn(fn),
        .db(db),
        .f1(f1)
    );

    initial begin
        fn = 128'hA1B2C3D4E5F60789ABCDEF0123456789;
        db = 1'b1;

        #10;
        fn = 128'h1234567890ABCDEFFEDCBA0987654321;
        db = 1'b0;

        #10;
        fn = 128'h87654321ABCDEF0123456789ABCDE012;
        db = 1'b1;

        #10;
        fn = 128'hAABBCCDD00112233445566778899AABB;
        db = 1'b0;

        #10;
        $finish;
    end

    initial begin
        $monitor("Time: %0t | fn: %h | db: %b | f1: %h", $time, fn, db, f1);
    end

endmodule


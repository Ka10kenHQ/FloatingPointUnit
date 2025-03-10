`include "./../master.sv"

module tb_master;

reg [63:0] fpa, fpb;
reg db, normal, sub, fdiv;
reg [1:0] RM;

wire [63:0] fp_add_out, fp_mul_out;
wire [4:0] IEEp_add, IEEp_mul;

wire sp_add_out, sp_mul_out;
wire [10:0] ep_add_out, ep_mul_out;
wire [51:0] f_add_out, f_mul_out;

master uut (
    .fpa(fpa),
    .fpb(fpb),
    .db(db),
    .normal(normal),
    .sub(sub),
    .fdiv(fdiv),
    .RM(RM),

    .fp_add_out(fp_add_out),
    .IEEp_add(IEEp_add),
    .sp_add_out(sp_add_out),
    .ep_add_out(ep_add_out),
    .f_add_out(f_add_out),

    .fp_mul_out(fp_mul_out),
    .IEEp_mul(IEEp_mul),
    .sp_mul_out(sp_mul_out),
    .ep_mul_out(ep_mul_out),
    .f_mul_out(f_mul_out)
);

initial begin

    // Test Case 1: 3.0 + 3.0, 3.0 * 3.0
    fpa = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};
    fpb = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};

    db = 1;
    normal = 1;
    sub = 0;
    fdiv = 0;
    RM = 2'b01;

    #20;
    $display("Adder Result: fp_add_out = %b", fp_add_out);
    $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);
    $display("------------------------------------------------------------------------------------------");
    $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);

    // Test Case 2: 10.0 + 10.0, 10.0 * 10.0
    fpa = {1'b0, 11'b10000000010, 52'b0100000000000000000000000000000000000000000000000000};
    fpb = {1'b0, 11'b10000000010, 52'b0100000000000000000000000000000000000000000000000000};

    db = 1;
    normal = 1;
    sub = 0;
    fdiv = 0;
    RM = 2'b01;
    
    #20;
    $display("Adder Result: fp_add_out = %b", fp_add_out);
    $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);
    $display("------------------------------------------------------------------------------------------");
    $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);

    // Test Case 3: 100.0 + 100.0, 100.0 * 100.0
    fpa = {1'b0, 11'b10000100101, 52'b1001000000000000000000000000000000000000000000000000};
    fpb = {1'b0, 11'b10000100101, 52'b1001000000000000000000000000000000000000000000000000};

    db = 0;
    normal = 1;
    sub = 0;
    fdiv = 0;
    RM = 2'b01;
    
    #20;
    $display("Adder Result: fp_add_out = %b", fp_add_out);
    $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);
    $display("------------------------------------------------------------------------------------------");
    $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);

    // Test Case 4: 1.2 + 2.7 = 3.9, 1.2 * 2.7
    fpa = {1'b0, 11'b01111111111, 52'b0011001100110011001100110011001100110011001100110011};
    fpb = {1'b0, 11'b10000000000, 52'b0101100110011001100110011001100110011001100110011010};

    db = 1;
    normal = 1;
    sub = 0;
    fdiv = 0;
    RM = 2'b00;

    #20;
    $display("Adder Result: fp_add_out = %b", fp_add_out);
    $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);
    $display("------------------------------------------------------------------------------------------");
    $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);

end

endmodule


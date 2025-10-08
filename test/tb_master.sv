`include "./../master.sv"

module tb_master;

reg clk, rst_n;
reg [63:0] fpa, fpb;
reg db, normal, sub, fdiv;
reg [1:0] RM;

wire [63:0] fp_mul_out;
wire [4:0] IEEp_mul;
wire sp_mul_out;
wire [10:0] ep_mul_out;
wire [51:0] f_mul_out;

wire [63:0] fp_add_out;
wire [4:0] IEEp_add;
wire sp_add_out;
wire [10:0] ep_add_out;
wire [51:0] f_add_out;

master uut (
    .clk(clk),
    .rst_n(rst_n),
    .fpa(fpa),
    .fpb(fpb),
    .db(db),
    .normal(normal),
    .sub(sub),
    .fdiv(fdiv),
    .RM(RM),
    .fp_mul_out(fp_mul_out),
    .IEEp_mul(IEEp_mul),
    .sp_mul_out(sp_mul_out),
    .ep_mul_out(ep_mul_out),
    .f_mul_out(f_mul_out),
    .fp_add_out(fp_add_out),
    .IEEp_add(IEEp_add),
    .sp_add_out(sp_add_out),
    .ep_add_out(ep_add_out),
    .f_add_out(f_add_out)
);

initial clk = 0;
always #5 clk = ~clk;

initial begin
    rst_n = 0;
    #20;
    rst_n = 1;
end

integer fd_in,fd_out;
reg [1050:0] line;

// always @(uut.mul.sig.div_inst.state) begin
//     $display("Time=%0t | State changed: %b", $time, uut.mul.sig.div_inst.state);
// end
//
// always @(uut.mul.sig.div_inst.fd_out) begin
//     $display("Time=%0t | fd_out changed: %b", $time, uut.mul.sig.div_inst.fd_out);
// end
//
// always @(uut.mul.sig.div_inst.fd_out) begin
//     $display("Time=%0t | fd_out changed: %b", $time, uut.mul.sig.div_inst.fq);
// end

initial begin

    //NOTE: add_sub 64-32 bits

    //ADD 64:

    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f64.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/add_sub_output_results.txt", "w");

    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f64_denormal.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/add_sub_output_results_denormal.txt", "w");

    // SUB 64:

    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f64.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/add_sub_output_results_sub.txt", "w");

    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f64_denormal.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/add_sub_output_results_sub_denormal.txt", "w");


    //ADD 32:
    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f32.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/add_sub_output_results_32.txt", "w");

    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f32_denormal.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/add_sub_output_results_32_denormal.txt", "w");

    // SUB 32:
    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f32.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/add_sub_output_results_sub_32.txt", "w");

    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f32_denormal.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/add_sub_output_results_sub_32_denormal.txt", "w");


    // NOTE: mul-div 64-32 bits
    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f64.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/mul_div_output_results_64.txt", "w");


    // fd_in = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f32.txt", "r");
    // fd_out = $fopen("/home/achir/FloatingPointUnit/test/mul_div_output_results_32.txt", "w");
 
    // if (fd_in == 0 || fd_out == 0) begin
    //     $display("Error opening file.");
    //     $finish;
    // end
    //
    // $monitor("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);
    //
    // while (!$feof(fd_in)) begin
    //     $fgets(line, fd_in); 
    //     $display("Line read: %s", line);
    //     $sscanf(line, "%b;%b", fpa, fpb);
    //
    //     db = 0;
    //     normal = 0;
    //     sub = 1;
    //     fdiv = 0;
    //     RM = 2'b01;
    //     #1;
    //
    //      $fdisplay(fd_out, "%b", fp_add_out);
    //      // $fdisplay(fd_out, "%b", fp_mul_out);
    // end

    // NOTE: Double precision numbers

    // Test Case 1: 3.0 * 3.0 and 3.0 + 3.0
    // fpa = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};
    // fpb = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};
    // db = 1;
    // normal = 1;
    // sub = 0;
    // fdiv = 0;
    // RM = 2'b00;
    // #20;
    // $display("------------------------------------------------------------------------------------------");
    // $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    // $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);
    //
    // $display("------------------------------------------------------------------------------------------");
    // $display("Adder Result: fp_add_out = %b", fp_add_out);
    // $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);

    // Test Case 1: -2.0 * -2.0 and -2.0 + -2.0
    // fpa = {1'b1, 11'b10000000000, 52'b0000000000000000000000000000000000000000000000000000};
    // fpb = {1'b1, 11'b10000000000, 52'b0000000000000000000000000000000000000000000000000000};
    // db = 1;
    // normal = 1;
    // sub = 0;
    // fdiv = 0;
    // RM = 2'b00;
    // #20;
    // $display("------------------------------------------------------------------------------------------");
    // $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    // $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);
    //
    // $display("------------------------------------------------------------------------------------------");
    // $display("Adder Result: fp_add_out = %b", fp_add_out);
    // $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);


    // Test Case 1: 4.0 / 2.0 and 4.0 - 2.0
    fpa = {1'b0, 11'b10000000001, 52'b0000000000000000000000000000000000000000000000000000};
    fpb = {1'b0, 11'b10000000000, 52'b0000000000000000000000000000000000000000000000000000};
    db = 1;
    normal = 1;
    sub = 0;
    fdiv = 1;
    RM = 2'b01;
    #20;
    $display("------------------------------------------------------------------------------------------");
    $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);

    $display("------------------------------------------------------------------------------------------");
    $display("Adder Result: fp_add_out = %b", fp_add_out);
    $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);


     // Test Case 2: 4.0 * 4.0 and 4.0 + 4.0
    // fpa = {1'b0, 11'b10000000001, 52'b0000000000000000000000000000000000000000000000000000};
    // fpb = {1'b0, 11'b10000000001, 52'b0000000000000000000000000000000000000000000000000000};
    // db = 1;
    // normal = 1;
    // sub = 0;
    // fdiv = 0;
    // RM = 2'b01;
    // #20;
    // $display("------------------------------------------------------------------------------------------");
    // $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    // $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);
    //
    // $display("------------------------------------------------------------------------------------------");
    // $display("Adder Result: fp_add_out = %b", fp_add_out);
    // $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);


    // Test Case 3: 4.1 + 3.7
    // fpa = {1'b0,11'b10000000001,52'b0000011001100110011001100110011001100110011001100110};
    // fpb = {1'b0,11'b10000000000,52'b1101100110011001100110011001100110011001100110011010};
    // db = 1;
    // normal = 1;
    // sub = 0;
    // fdiv = 0;
    // RM = 2'b01;
    // #20;
    // $display("------------------------------------------------------------------------------------------");
    // $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    // $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);
    //
    // $display("------------------------------------------------------------------------------------------");
    // $display("Adder Result: fp_add_out = %b", fp_add_out);
    // $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);


    // Test Case 3: 2.1 * 3.34 and 2.1 + 3.34
    // fpa = {1'b0,11'b10000000000,52'b0000110011001100110011001100110011001100110011001101};
    // fpb = {1'b0,11'b10000000000,52'b1010101110000101000111101011100001010001111010111000};
    // db = 1;
    // normal = 1;
    // sub = 0;
    // fdiv = 0;
    // RM = 2'b01;
    // #20;
    // $display("------------------------------------------------------------------------------------------");
    // $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    // $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);
    //
    // $display("------------------------------------------------------------------------------------------");
    // $display("Adder Result: fp_add_out = %b", fp_add_out);
    // $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);
    

    // NOTE: Single Precision Number

    // 69.0 + 3.14
    // fpa = {1'b0,8'b10000101,23'b00010100000000000000000,1'b0,8'b10000101,23'b00010100000000000000000};
    // fpb = {1'b0,8'b10000000,23'b10010001111010111000011,1'b0,8'b10000000,23'b10010001111010111000011};
    // db = 0;
    // normal = 1;
    // sub = 0;
    // fdiv = 0;
    // RM = 2'b01;
    // #20;
    // $display("------------------------------------------------------------------------------------------");
    // $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    // $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);
    //
    // $display("------------------------------------------------------------------------------------------");
    // $display("Adder Result: fp_add_out = %b", fp_add_out);
    // $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);


    // (f32::MIN + 30.75) + f32::MAX
    // fpa = {1'b1, 8'b11111110, 23'b11111111111111111111111, 1'b1, 8'b11111110, 23'b11111111111111111111111};
    // fpb = {1'b0, 8'b11111110, 23'b11111111111111111111111, 1'b0, 8'b11111110, 23'b11111111111111111111111};
    // db = 0;
    // normal = 1;
    // sub = 0;
    // fdiv = 0;
    // RM = 2'b00;
    // #20;
    // $display("------------------------------------------------------------------------------------------");
    // $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    // $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);
    //
    // $display("------------------------------------------------------------------------------------------");
    // $display("Adder Result: fp_add_out = %b", fp_add_out);
    // $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);

    // 102.1234 - 571.321
    // fpa = {1'b0, 8'b10000101, 23'b10011000011111100101110, 1'b0, 8'b10000101, 23'b10011000011111100101110};
    // fpb = {1'b0, 8'b10001000, 23'b00011101101010010001011, 1'b0, 8'b10001000, 23'b00011101101010010001011};
    // db = 0;
    // normal = 1;
    // sub = 1;
    // fdiv = 0;
    // RM = 2'b00;
    // #20;
    // $display("------------------------------------------------------------------------------------------");
    // $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    // $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);
    //
    // $display("------------------------------------------------------------------------------------------");
    // $display("Adder Result: fp_add_out = %b", fp_add_out);
    // $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);

    // 69.0 - 3.14
    // fpa = {1'b0, 8'b10000101, 23'b00010100000000000000000, 1'b0, 8'b10000101, 23'b00010100000000000000000};
    // fpb = {1'b0, 8'b10000000, 23'b10010001111010111000011, 1'b0, 8'b10000000, 23'b10010001111010111000011};
    // db = 0;
    // normal = 1;
    // sub = 1;
    // fdiv = 0;
    // RM = 2'b00;
    // #20;
    // $display("------------------------------------------------------------------------------------------");
    // $display("Muldiv Result: fp_mul_out = %b", fp_mul_out);
    // $display("Muldiv Details: sp_out = %b, ep_out = %b, f_out = %b", sp_mul_out, ep_mul_out, f_mul_out);
    //
    // $display("------------------------------------------------------------------------------------------");
    // $display("Adder Result: fp_add_out = %b", fp_add_out);
    // $display("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);


end

endmodule

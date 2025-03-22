`include "./../master.sv"

module tb_master;

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

// integer fd;
// reg [1050:0] line;

initial begin
    
    // fd = $fopen("/home/achir/FloatingPointUnit/test_gen/decomposed_f64.txt", "r");  
    // if (fd == 0) begin
    //     $display("Error opening file.");
    //     $finish;
    // end
    //
    // $monitor("Adder Details: sp_out = %b, ep_out = %b, f_out = %b", sp_add_out, ep_add_out, f_add_out);
    //
    // while (!$feof(fd)) begin
    //     $fgets(line, fd); 
    //     $display("Line read: %s", line);
    //     $sscanf(line, "%b;%b", fpa, fpb);
    //     db = 1;
    //     normal=1;
    //     sub = 0;
    //     fdiv = 0;
    //     RM = 0;
    //     #1;
    // end
    // $fclose(fd); 


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

    // 23.14 + 0.19
    // fpa = {1'b0,8'b10000011,23'b01110010011001100110011,1'b0,8'b10000011,23'b01110010011001100110011};
    // fpb = {1'b0,8'b01111100,23'b10000101000111101011100,1'b0,8'b01111100,23'b10000101000111101011100};
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


end

endmodule

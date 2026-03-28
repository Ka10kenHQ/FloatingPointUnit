`include "./../master.sv"

module tb_sub_32_edge;

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


initial begin

    fd_in = $fopen("/home/Zura/FloatingPointUnit/ieee754_test_suite/decomposed_f32_edge.txt", "r");
    fd_out = $fopen("/home/Zura/FloatingPointUnit/test/add_sub_output_results_32_sub_edge.txt", "w");

    if (fd_in == 0 || fd_out == 0) begin
        $display("Error opening file.");
        $finish;
    end

    $monitor("Time=%0t | Adder Details: sp_out = %b, ep_out = %b, f_out = %b", $time, sp_mul_out, ep_mul_out, f_mul_out);

    #5;

    while (!$feof(fd_in)) begin
        $fgets(line, fd_in); 
        $display("Time = %0t | Line read: %s", $time, line);
        $sscanf(line, "%b;%b", fpa, fpb);

        db = 0;
        normal = 1;
        sub = 1;
        fdiv = 1;
        RM = 2'b01;
        #211;

        $display("Time=%0t | STATE: %b", $time, uut.mul.sig.div_inst.curr_state);

        $display("Time=%0t | final result: %b", $time, fp_mul_out);

        $fdisplay(fd_out, "%b", fp_add_out);

        rst_n = 0;
        #20;
        rst_n = 1;
    end
end


endmodule



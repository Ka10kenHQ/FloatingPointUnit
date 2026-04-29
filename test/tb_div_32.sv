`include "./../master.sv"

module tb_div_32;

reg clk, rst_n;
reg [63:0] fpa, fpb;
reg db, md, normal, sub, fdiv;
reg [1:0] RM;

wire [63:0] fp;
wire [4:0] IEEp;

master uut (
    .clk(clk),
    .rst_n(rst_n),
    .fpa(fpa),
    .fpb(fpb),
    .db(db),
    .md(md),
    .normal(normal),
    .sub(sub),
    .fdiv(fdiv),
    .RM(RM),
    .fp(fp),
    .IEEEp(IEEp)
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

    fd_in = $fopen("/home/achir/dev/thesis/FloatingPointUnit/ieee754_test_suite/decomposed_f32.txt", "r");
    fd_out = $fopen("/home/achir/dev/thesis/FloatingPointUnit/test/mul_div_output_results_32_div.txt", "w");

    // fd_in = $fopen("/home/achir/dev/thesis/FloatingPointUnit/ieee754_test_suite/decomposed_f32_denormal.txt", "r");
    // fd_out = $fopen("/home/achir/dev/thesis/FloatingPointUnit/test/mul_div_output_results_32_div_denormal.txt", "w");


    if (fd_in == 0 || fd_out == 0) begin
        $display("Error opening file.");
        $finish;
    end

    #5;

    while (!$feof(fd_in)) begin
        $fgets(line, fd_in); 
        $display("Time = %0t | Line read: %s", $time, line);
        $sscanf(line, "%b;%b", fpa, fpb);

        db = 0;
        md = 1;
        normal = 1;
        sub = 0;
        fdiv = 1;
        RM = 2'b01;
        #211;

        $display("Time=%0t | final result: %b", $time, fp);

        $fdisplay(fd_out, "%b", fp);

        rst_n = 0;
        #20;
        rst_n = 1;
    end
end


endmodule

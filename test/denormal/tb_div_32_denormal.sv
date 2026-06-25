`include "../../master.sv"

module tb_div_32_denormal;

parameter string BASE_PATH = ".";

string input_path;
string output_path;

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
integer total_lines, line_count;
reg [1050:0] line;


initial begin

    input_path  = $sformatf("%s/ieee754_test_suite/decomposed_f32_denormal.txt", BASE_PATH);
    output_path = $sformatf("%s/test/outputs/denormal/mul_div_output_results_32_div_denormal.txt", BASE_PATH);

    fd_in = $fopen(input_path, "r");
    fd_out = $fopen(output_path, "w");


    if (fd_in == 0 || fd_out == 0) begin
        $display("Error opening file.");
        $finish;
    end

    #5;

    total_lines = 0;
    while ($fgets(line, fd_in)) begin
        total_lines = total_lines + 1;
    end
    $fclose(fd_in);
    fd_in = $fopen(input_path, "r");

    line_count = 0;
    while ($fgets(line, fd_in)) begin
        line_count = line_count + 1;
        if (line_count % (total_lines / 10 + 1) == 0) begin
            $display("Progress: %0d%%", line_count * 100 / total_lines);
        end
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
    $finish;
end


endmodule

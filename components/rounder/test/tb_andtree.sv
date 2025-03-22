`include "./../andtree.sv"

module tb_andtree;

parameter n = 11;

reg [n-1:0] x;
wire and_out;

andtree #(.n(n)) uut(
    .x(x),
    .and_out(and_out)
);

initial begin
    x = {n{1'b1}};
    #10;
    $display("Input: %b, AND Output: %b", x, and_out);

    x = {n{1'b0}};
    #10;
    $display("Input: %b, AND Output: %b", x, and_out);

    x = {n{1'b1}};
    x[5] = 1'b0;
    #10;
    $display("Input: %b, AND Output: %b", x, and_out);

    x = 11'b10101010101;
    #10;
    $display("Input: %b, AND Output: %b", x, and_out);

    x = {1'b1, {n-1{1'b0}}};
    #10;
    $display("Input: %b, AND Output: %b", x, and_out);
end

endmodule

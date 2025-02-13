`include "./../exponent.sv"

module tb_exponent;
reg [63:0] fp;
reg db;

wire e_inf, e_z, s;
wire [10:0] e;

exponent uut(
    .fp(fp),
    .db(db),
    .e_inf(e_inf),
    .e_z(e_z),
    .e(e),
    .s(s)
);

initial begin
    fp = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};
    db = 1;
end

endmodule

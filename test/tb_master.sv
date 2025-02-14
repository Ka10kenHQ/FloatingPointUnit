`include "./../master.sv"

module tb_master;

reg [63:0] fpa, fpb;
reg db, normal, sub;
reg [1:0] RM;

wire [63:0] fp_out;
wire [4:0] IEEp;

wire sp_out;
wire [10:0] ep_out;
wire [51:0] f_out;

master uut (
    .fpa(fpa),
    .fpb(fpb),
    .db(db),
    .normal(normal),
    .sub(sub),
    .RM(RM),
    .fp_out(fp_out),
    .IEEp(IEEp),
    .sp_out(sp_out),
    .ep_out(ep_out),
    .f_out(f_out)
);

initial begin

    // 3.0
    fpa = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};
    fpb = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000};

    db = 1;
    normal = 1;
    sub = 0;
    RM = 2'b01;

    #20;
    $display("fp_out = %b", fp_out);
    $display("sp_out = %b, ep_out = %b, f_out = %b", sp_out, ep_out, f_out);

    // 10.0
    fpa = {1'b0, 11'b10000000010, 52'b0100000000000000000000000000000000000000000000000000};
    fpb = {1'b0, 11'b10000000010, 52'b0100000000000000000000000000000000000000000000000000};

    db = 1;
    normal = 1;
    sub = 0;
    RM = 2'b01;
    
    #20;
    $display("fp_out = %b", fp_out);
    $display("sp_out = %b, ep_out = %b, f_out = %b", sp_out, ep_out, f_out);

    // 100.0
    fpa = {1'b0, 11'b10000100101, 52'b1001000000000000000000000000000000000000000000000000};
    fpb = {1'b0, 11'b10000100101, 52'b1001000000000000000000000000000000000000000000000000};

    db = 0;
    normal = 1;
    sub = 0;
    RM = 2'b01;
    
    #20;
    $display("fp_out = %b", fp_out);
    $display("sp_out = %b, ep_out = %b, f_out = %b", sp_out, ep_out, f_out);

    // 1.2 + 2.7 = 3.9
    fpa = {1'b0, 11'b01111111111, 52'b0011001100110011001100110011001100110011001100110011};
    fpb = {1'b0, 11'b10000000000, 52'b0101100110011001100110011001100110011001100110011010};

    db = 1;
    normal = 1;
    sub = 0;
    RM = 2'b00;

    #20;
    $display("fp_out = %b", fp_out);
    $display("sp_out = %b, ep_out = %b, f_out = %b", sp_out, ep_out, f_out);

end

endmodule


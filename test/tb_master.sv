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

reg [31:0] fa32, fb32;

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

function string state_name(input [3:0] state);
    case (state)
        4'd0:  return "UNPACK";
        4'd1:  return "LOOKUP";
        
        4'd2:  return "NEWTON1";
        4'd3:  return "NEWTON2";
        4'd4:  return "NEWTON3";
        4'd5:  return "NEWTON4";
        
        4'd6:  return "QUOT1";
        4'd7:  return "QUOT2";
        4'd8:  return "QUOT3";
        4'd9:  return "QUOT4";
        
        4'd10: return "SELECT_FD"; 
        4'd11: return "ROUND1";
        4'd12: return "ROUND2";
        
        default: return "UNKNOWN";
    endcase
endfunction

always @(uut.mul.sig.div_inst.curr_state) begin
    $display("Time=%0t | curr_state changed: %04b (%s)", 
             $time, uut.mul.sig.div_inst.curr_state, 
             state_name(uut.mul.sig.div_inst.curr_state));
end

always @(uut.mul.sig.div_inst.fd_out) begin
    $display("Time=%0t | fd_out changed: %b", $time, uut.mul.sig.div_inst.fd_out);
end

// always @(uut.mul.sig.div_inst.cce) begin
//     $display("Time=%0t | cce changed: %b", $time, uut.mul.sig.div_inst.cce);
// end
//
// always @(uut.mul.sig.div_inst.sce) begin
//     $display("Time=%0t | sce changed: %b", $time, uut.mul.sig.div_inst.sce);
// end
//
// always @(uut.mul.sig.div_inst.c) begin
//     $display("Time=%0t | c changed: %b", $time, uut.mul.sig.div_inst.c);
// end
//
// always @(uut.mul.sig.div_inst.s) begin
//     $display("Time=%0t | s changed: %b", $time, uut.mul.sig.div_inst.s);
// end

always @(uut.mul.sig.div_inst.fq) begin
    $display("Time=%0t | fq changed: %b", $time, uut.mul.sig.div_inst.fq);
end

always @(uut.mul.sig.div_inst.E) begin
    $display("Time=%0t | E changed: %b", $time, uut.mul.sig.div_inst.E);
end

always @(uut.mul.sig.div_inst.Eb) begin
    $display("Time=%0t | Eb changed: %b", $time, uut.mul.sig.div_inst.Eb);
end

always @(uut.mul.sig.div_inst.fd_out) begin
    $display("Time=%0t | fd_out changed: %b", $time, uut.mul.sig.div_inst.fd_out);
end

always @(uut.mul.sig.div_inst.select_f.neg) begin
    $display("Time=%0t | neg changed: %b", $time, uut.mul.sig.div_inst.select_f.neg);
end

always @(uut.mul.sig.div_inst.select_f.beta) begin
    $display("Time=%0t | beta changed: %b", $time, uut.mul.sig.div_inst.select_f.beta);
end

always @(uut.mul.sig.div_inst.Da) begin
    $display("Time=%0t | Da changed: %b", $time, uut.mul.sig.div_inst.Da);
end

always @(uut.mul.sig.div_inst.Db) begin
    $display("Time=%0t | Db changed: %b", $time, uut.mul.sig.div_inst.Db);
end

always @(uut.mul.sig.div_inst.mul_out) begin
    $display("Time=%0t | mul_out changed: %b", $time, uut.mul.sig.div_inst.mul_out);
end

always @(uut.mul.sig.div_inst.x) begin
    $display("Time=%0t | x changed: %b", $time, uut.mul.sig.div_inst.x);
end

always @(uut.mul.sig.div_inst.A) begin
    $display("Time=%0t | A changed: %b", $time, uut.mul.sig.div_inst.A);
end

always @(uut.mul.sig.div_inst.fa) begin
    $display("Time=%0t | fa changed: %b", $time, uut.mul.sig.div_inst.fa);
end

always @(uut.mul.sig.div_inst.fb) begin
    $display("Time=%0t | fb changed: %b", $time, uut.mul.sig.div_inst.fb);
end

always @(uut.mul.sig.div_inst.look_up) begin
    $display("Time=%0t | look_up changed: %b", $time, uut.mul.sig.div_inst.look_up);
end

always @(uut.mul.sig.div_inst.tlu) begin
    $display("Time=%0t | tlu changed: %b", $time, uut.mul.sig.div_inst.tlu);
end

always @(uut.mul.sig.div_inst.fa_in) begin
    $display("Time=%0t | fa_in changed: %b", $time, uut.mul.sig.div_inst.fa_in);
end

always @(uut.mul.sig.div_inst.fb_in) begin
    $display("Time=%0t | fb_in changed: %b", $time, uut.mul.sig.div_inst.fb_in);
end

always @(fp_mul_out) begin
    $display("Time=%0t | final result changed: %b", $time, fp_mul_out);
end

always @(uut.mul.sig.div_inst.rom_inst.data) begin
    $display("Time=%0t | ROM data result changed: %b", $time, uut.mul.sig.div_inst.rom_inst.data);
end

initial begin

    fpa = {1'b0, 11'b10000000101, 52'b0001010000000000000000000000000000000000000000000000 };
    fpb = {1'b0, 11'b10000000000, 52'b1001000111101011100001010001111010111000010100011111 };
    db = 1;
    normal = 1;
    sub = 0;
    fdiv = 1;
    RM = 2'b10;
    #210;


    // fpa = {1'b0, 11'b10000000001, 52'b1100000000000000000000000000000000000000000000000000 };
    // fpb = {1'b0, 11'b10000000000, 52'b1000000000000000000000000000000000000000000000000000 };
    // db = 1;
    // normal = 1;
    // sub = 0;
    // fdiv = 1;
    // RM = 2'b10;
    // #200;

    // fa32 = { 1'b0, 8'b10000001, 23'b11000000000000000000000 };
    // fb32 = { 1'b0, 8'b10000000, 23'b10000000000000000000000 };
    //
    // fpa = { fa32, fa32 };
    // fpb = { fb32, fb32 };
    // db = 0;
    // normal = 1;
    // sub = 0;
    // fdiv = 1;
    // RM = 2'b10;
    // #20;


end

endmodule

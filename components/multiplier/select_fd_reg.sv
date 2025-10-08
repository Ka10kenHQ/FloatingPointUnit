module select_fd_reg(
    input  clk,
    input  [57:0]  Da,
    input  [57:0]  Db,
    input  [114:0] Eb,
    input  [54:0]  E,
    input          db,
    output reg [56:0] fd
);
wire [56:0] fd_comb;
select_fd comb (.Da(Da), .Db(Db), .Eb(Eb), .E(E), .db(db), .fd(fd_comb));
    
always @(posedge clk) begin
    fd <= fd_comb;
end

endmodule

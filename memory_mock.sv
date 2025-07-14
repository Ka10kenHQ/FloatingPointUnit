module memory_mock(
    input addr,
    output [63:0] fpa,
    output [63:0] fpb
);

reg [63:0] fpu1_memory [0:10];
reg [63:0] fpu2_memory [0:10];


initial begin
   fpu1_memory[0] = 64'b0100000000001000000000000000000000000000000000000000000000000000;
   fpu2_memory[0] = 64'b0100000000001000000000000000000000000000000000000000000000000000;
end


assign fpa = fpu1_memory[addr];
assign fpb = fpu2_memory[addr];

endmodule

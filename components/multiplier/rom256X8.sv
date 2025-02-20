module rom256X8(
    input wire [7:0] addr,
    output reg [7:0] data
);

reg [15:0] rom [255:0];

initial begin
    $readmemb("/home/achir/FloatingPointUnit/components/multiplier/lookup_table.txt", rom);
end

always @(*) begin
    data = rom[addr][14:7];
end

endmodule


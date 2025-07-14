module rom256X8(
    input wire [7:0] addr,
    output wire [7:0] data
);

reg [63:0] rom [255:0];

initial begin
    $readmemb("/home/achir/FloatingPointUnit/components/multiplier/lookup_table.txt", rom);
end

assign data = rom[addr][63:56];

endmodule


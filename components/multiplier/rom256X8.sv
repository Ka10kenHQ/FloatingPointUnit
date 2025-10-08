module rom256X8(
    input wire [7:0] addr,
    output wire [7:0] data
);

reg [15:0] rom [255:0];

initial begin
    $readmemb("/home/achir/dev/FloatingPointUnit/test_gen/lookup_table.txt", rom);
end

assign data = rom[addr][15:8];

endmodule


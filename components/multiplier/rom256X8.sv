module rom256X8(
    input wire [7:0] addr,
    output reg [7:0] data
);

reg [7:0] rom [255:0];

initial begin
    $readmemh("lookup_table.hex", rom);
end

always @(*) begin
    data = rom[addr];
end


endmodule

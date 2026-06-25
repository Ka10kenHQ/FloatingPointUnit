module rom256X8(
    input wire [7:0] addr,
    output wire [7:0] data
);

parameter string BASE_PATH = ".";

reg [15:0] rom [255:0];

initial begin
    $readmemb({BASE_PATH, "/ieee754_test_suite/lookup_table.txt"}, rom);
end

assign data = rom[addr][14:7];

endmodule


`include "./../rom256X8.sv"

module tb_rom256X8;

    reg [7:0] addr;

    wire [7:0] data;

    rom256X8 uut (
        .addr(addr),
        .data(data)
    );

    initial begin
        addr = 8'h00;

        #100;

        addr = 8'h00;
        #10;
        $display("Address %h: Expected 00, Got %h", addr, data);

        addr = 8'h80;
        #10;
        $display("Address %h: Expected some value, Got %h", addr, data);

        addr = 8'hFF;
        #10;
        $display("Address %h: Expected FF, Got %h", addr, data);

        addr = 8'hA5;
        #10;
        $display("Address %h: Expected some value, Got %h", addr, data);

    end

endmodule

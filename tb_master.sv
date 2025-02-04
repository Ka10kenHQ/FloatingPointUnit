module tb_master;

    reg [63:0] fpa;
    reg [63:0] fpb;

    wire [10:0] es;
    wire [56:0] fs;
    wire ss;
    wire [1:0] fls;

    master uut (
        .fpa(fpa),
        .fpb(fpb),
        .es(es),
        .fs(fs),
        .ss(ss),
        .fls(fls)
    );

    initial begin

        fpa = {32'b01000010100010100000000000000000,32'b0};
        fpb = {32'b01000010100010100000000000000000,32'b0};
        #10;
        
    end

endmodule


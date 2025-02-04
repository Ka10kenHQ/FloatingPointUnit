`include "./../mask.sv"

module tb_mask;

    reg [12:0] sh;
    wire [63:0] v, w;

    mask uut (
        .sh(sh),
        .v(v),
        .w(w)
    );

    initial begin
        sh = 13'b0000000000000;
        #10 sh = 13'b1010101010101;
        #10 sh = 13'b1111111111111;
        #10 sh = 13'b0000001111111;
        #10 sh = 13'b1111110000000;
        #10 sh = 13'b0101010101010;
    end

endmodule


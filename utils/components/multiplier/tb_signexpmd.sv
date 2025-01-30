module tb_signexpmd;

    reg sa;
    reg [10:0] ea;
    reg [5:0] lza;
    reg sb;
    reg [10:0] eb;
    reg [5:0] lzb;

    reg fdiv;

    wire sq;
    wire [12:0] eq;

    signexpmd uut (
        .sa(sa),
        .ea(ea),
        .lza(lza),
        .sb(sb),
        .eb(eb),
        .lzb(lzb),
        .sq(sq),
        .eq(eq)
    );

    initial begin
        sa = 0; sb = 0;
        ea = 11'b01010101010;
        lza = 6'b101010;
        eb = 11'b10101010101;
        lzb = 6'b010101;
        fdiv = 0;

        #10;
        $display("Test 1 -> sq: %b, eq: %b", sq, eq);

        sa = 1; sb = 0;
        ea = 11'b11010101010; 
        lza = 6'b000111;
        eb = 11'b10100110010;
        lzb = 6'b111000;
        fdiv = 2;

        #10;
        $display("Test 2 -> sq: %b, eq: %b", sq, eq);

        sa = 1; sb = 1;
        ea = 11'b01111111111;
        lza = 6'b111111;
        eb = 11'b11111111110;
        lzb = 6'b000000;
        fdiv = 0;

        #10;
        $display("Test 3 -> sq: %b, eq: %b", sq, eq);

        sa = 0; sb = 1;
        ea = 11'b00000000001;
        lza = 6'b100101;
        eb = 11'b11111111111;
        lzb = 6'b011010;
        fdiv = 1;

        #10;
        $display("Test 4 -> sq: %b, eq: %b", sq, eq);

        sa = 0; sb = 0;
        ea = 11'b0;
        lza = 6'b0;
        eb = 11'b0;
        lzb = 6'b0;
        fdiv = 0;

        #10;
        $display("Test 5 -> sq: %b, eq: %b", sq, eq);
    end
endmodule


`include "./../../utils/three2add.sv"

module expnorm(
    input [10:0] er,
    input [5:0] lz,
    input db,
    input OVFen,
    input OVF1,
    input UNFen,
    input TINY,
    output reg [10:0] eni,
    output reg [10:0] en
);

reg [1:0] w1;
reg [4:0] delta;
reg [10:0] c;
reg [10:0] b;
reg [10:0] emin;
reg [10:0] emin1;
reg [11:0] sum;

wire [11:0] t, s;


three2add add (
    .a(er),
    .b(b),
    .c(c),
    .t(t),
    .s(s)
);

always @(*) begin
    emin = 11'b00000000001;
    emin1 = 11'b00000000010;

    if(OVFen & OVF1) begin
        w1 = 2'b11;
    end
    else w1 = 2'b10;

    if(UNFen & TINY) begin
        w1 = 2'b01;
    end

    delta = db ? {w1, 3'b000} : {3'b000, w1};

    c = {delta, 6'b0};
    b = {5'b11111, lz};

    sum = t + s + 1;

    if (~UNFen & TINY) begin
        en = emin;
        eni = emin1;
    end else begin
        en = sum[10:0];
        eni = sum[10:0] + 1;
    end
end

endmodule


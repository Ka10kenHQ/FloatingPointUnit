`include "./../multiplier/three2add.sv"

// FIXME: getting dont care terms in en and eni
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
reg [10:0] b = {{5{1'b1}}, lz};
reg [11:0] t, s;
reg [10:0] emin = 11'b00000000001;
reg [10:0] emin1 = 11'b00000000010;
reg [11:0] sum;


three2add add (
    .a(er),
    .b(b),
    .c(c),
    .t(t),
    .s(s)
);

always @(*) begin
    case ({OVFen & OVF1, UNFen & TINY})
        2'b10: w1 = 2'b11;
        2'b01: w1 = 2'b01;
        default: w1 = 2'b10;
    endcase

    delta = db ? {w1, 3'b000} : {3'b000, w1};

    c = {delta, 6'b000000};

    sum = t + s + 1;

    if (~UNFen & TINY) begin
        en = emin;
        eni = emin1;
    end else begin
        en = sum[10:0];
        eni = sum[10:0];
    end
end



endmodule


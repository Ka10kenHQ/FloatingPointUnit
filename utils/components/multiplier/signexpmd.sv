module signexpmd(
    input sa,
    input [10:0] ea,
    input [5:0] lza,

    input sb,
    input [10:0] eb,
    input [5:0] lzb,

    input fdiv,

    output reg sq,
    output reg [12:0] eq
);

reg [12:0] a,b,c,d;

reg carry = 1;
parameter n = 12;

wire [13:0] t,s;

ftadd #(n) add(
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .c_in(0),

    .t(t),
    .s(s)
);

always @(*) begin

    sq = sa ^ sb;

    a = {ea[10], ea[10], ea};
    b = {7'b1111111, ~lza};

    if (fdiv) begin
        c = {~eb[10], ~eb[10], ~eb};

        d = {7'b0,lzb};
    end
    else begin 
        c = {eb[10], eb[10], eb};

        d = {7'b1111111,lzb};
    end

    eq = t + s + carry;
end

endmodule

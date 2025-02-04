`include "./components/adder/adder.sv";
`include "./components/unpacker/unpackermaster.sv";

module master  (
    input [63:0] fpa,
    input [63:0] fpb,
    output [10:0] es,
    output [56:0] fs,
    output ss,
    output reg [1:0] fls
);

wire sa, sb;
wire [10:0] ea,eb;
wire [5:0] lza,lzb;
wire [3:0] fla, flb;
wire [52:0] nan;
wire [52:0] fa,fb;

unpackermaster unpack(
    .FA2(fpa),
    .db(1'b0),
    .normal(1'b0),
    .FB2(fpb),
    .sa(sa),
    .sb(sb),
    .ea(ea),
    .eb(eb),
    .fa(fa),
    .fb(fb),
    .lza(lza),
    .lzb(lzb),
    .nan(nan)
);

adder add(
    .fa(fa),
    .ea(ea),
    .sa(sa),
    .fb(fb),
    .eb(eb),
    .sb(sb),
    .sub(1'b0),
    .fla(fla),
    .flb(flb),
    .nan(nan),
    .es(es),
    .fs(fs),
    .ss(ss),
    .fls(fls)
);


endmodule

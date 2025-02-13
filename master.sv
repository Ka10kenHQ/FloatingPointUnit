`include "./components/adder/adder.sv";
`include "./components/unpacker/unpackermaster.sv";
`include "./components/rounder/rounder.sv"

module master  (
    input [63:0] fpa,
    input [63:0] fpb,
    input db,
    input normal,
    input sub,
    input [1:0] RM,

    output [63:0] fp_out,
    output [4:0] IEEp,
    

    output sp_out,
    output [10:0] ep_out,
    output [51:0] f_out
);

wire [5:0]  lza, lzb;
wire [3:0]  fla, flb;
wire [10:0] ea, eb;
wire [52:0] nan;
wire [52:0] fa, fb;
wire        sa, sb;

unpackermaster unpack(
    .FA2(fpa),
    .FB2(fpb),
    .sa(sa),
    .sb(sb),
    .ea(ea),
    .eb(eb),
    .db(db),
    .normal(normal),
    .fa(fa),
    .fb(fb),
    .lza(lza),
    .lzb(lzb),
    .fla(fla),
    .flb(flb),
    .nan(nan)
);


wire ss;
wire [10:0] es;
wire [56:0] fs;
wire [57:0] fls;

adder add(
    .fa(fa),
    .ea(ea),
    .sa(sa),
    .fb(fb),
    .eb(eb),
    .sb(sb),
    .sub(sub),
    .fla(fla),
    .flb(flb),
    .nan(nan),
    .RM(RM),
    .es(es),
    .fs(fs),
    .ss(ss),
    .fls(fls)
);

// TODO: flags to add
reg OVFen = 1'b0;
reg UNFen = 1'b0;
reg [11:0] temp_er;
reg [12:0] er;


rounder rnd(
    .db(db),
    .s(ss),
    .er({es[10], es[10], es}),
    .fr(fs),
    .OVFen(OVFen),
    .UNFen(UNFen),
    .flr(fls),
    .RM(RM),
    .IEEEp(IEEp),
    .fp(fp_out),
    .sp_out(sp_out),
    .ep_out(ep_out),
    .f_out(f_out)
);

always @(*) begin
    temp_er = es + 1;
    // er = {};
end

endmodule


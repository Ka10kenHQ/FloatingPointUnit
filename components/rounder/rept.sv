`include "./../../utils/ortree.sv"

module rept(
    input [127:0] fn,
    input db,

    output reg [54:0] f1
);

parameter n1 = 74;
parameter n2 = 29;

wire sta, st_db;


ortree #(n1) or1(
    //NOTE: transformed [0:127] into [127:0]
    .x(fn[73:0]),
    .or_out(st_db)
);

ortree #(n2) or2(
    //NOTE: transformed [0:127] into [127:0]
    .x(fn[102:74]),
    .or_out(sta)
);

always @(*) begin
    //NOTE: transformed [0:127] into [127:0]

    f1[54:30] = fn[127:103];

    if (db) begin
        f1[29:0] = {fn[102:74], st_db};
    end
    else begin
        f1[29:0] = {sta | st_db, 29'b0};
    end

end


endmodule

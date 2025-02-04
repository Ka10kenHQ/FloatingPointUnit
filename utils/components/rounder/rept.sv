`include "./../adder/ortree.sv"

module rept(
    input [127:0] fn,
    input db,

    output reg [54:0] f1
);

parameter n1 = 74;
parameter n2 = 29;

wire sta, st_db;


ortree #(n1) or1(
    .x(fn[127:54]),
    .or_out(st_db)
);

ortree #(n2) or2(
    .x(fn[53:25]),
    .or_out(sta)
);

always @(*) begin
    f1[24:0] = fn[24:0];

    if (db) begin
        f1[54:25] = {fn[53:25], st_db};
    end
    else begin
        f1[54:25] = {sta | st_db, 29'b0};
    end

end


endmodule

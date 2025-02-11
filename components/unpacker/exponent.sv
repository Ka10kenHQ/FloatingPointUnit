module exponent (
    input [63:0]       fp,
    input              db,
    output reg         e_inf,
    output reg         e_z,
    output reg [10:0]  e,
    output reg         s
);
 
reg [10:0] temp_e_db;
reg [10:0] inc;
reg [7:0] temp_e;
 
always @(*) begin
    s = fp[63];
    if(db) begin

        e_z = fp[62:52] == 11'b0;
        e_inf = (fp[62:52] == 11'b11111111111);
        e_inf = (~fp[62:52]) == 11'b0;

        temp_e_db = {fp[62:53], e_z | fp[52]};
        inc = temp_e_db + 1;
        e = {~inc[10], inc[9:0]};
    end
    else begin

        e_z = fp[62:55] == 8'b0;
        e_inf = (~fp[62:55]) == 8'b0;

        temp_e = {fp[62:56], e_z | fp[55]};
        inc = temp_e + 1;
        e = {{4{~inc[7]}}, inc[6:0]};
    end
end
 
 
endmodule

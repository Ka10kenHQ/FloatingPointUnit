module exponent (
    input [63:0]       fp,
    input              db,
    output             e_inf,
    output             e_z,
    output  [10:0]     e
);

wire [10:0] temp_e_db;
wire [7:0] temp_e_sp;

wire [10:0] inc_db;
wire [7:0] inc_sp;

assign e_zd = (fp[62:52] == 11'b0);
assign e_zs = (fp[62:55] == 8'b0);
assign e_z = db ? e_zd : e_zs;

assign e_inf = db ? (~fp[62:52] == 11'b0) : (~fp[62:55] == 8'b0);

assign temp_e_db = {fp[62:53], e_zd | fp[52]};
assign temp_e_sp = {fp[62:56], e_zs | fp[55]};

assign inc_db = temp_e_db + 1;
assign inc_sp = temp_e_sp + 1;

assign e = db ? {~inc_db[10], inc_db[9:0]} : { {4{~inc_sp[7]}}, inc_sp[6:0] };

endmodule


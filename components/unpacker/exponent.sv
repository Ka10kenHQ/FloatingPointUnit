module exponent (
    input [63:0]       fp,
    input              db,
    output             e_inf,
    output             e_z,
    output  [10:0]     e,
    output             s
);

wire [10:0] temp_e_db;
wire [7:0] temp_e;
wire [10:0] inc;

assign s = fp[63];

assign e_z = db ? (fp[62:52] == 11'b0) : (fp[62:55] == 8'b0);
assign e_inf = db ? (~fp[62:52] == 11'b0) : (~fp[62:55] == 8'b0);

assign temp_e_db = {fp[62:53], e_z | fp[52]};
assign inc = temp_e_db + 1;
assign e = db ? {~inc[10], inc[9:0]} : { {4{~inc[7]}}, inc[6:0] };

endmodule


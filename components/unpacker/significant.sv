module significant (
    input db,
    input [63:0] x,
    input e_z,
    input normal, 
    output reg [5:0] lz,
    output reg [52:0] f,
    output reg fz,
    output reg [51:0] h  
);

parameter n = 64;
parameter m = 6;
reg [11:0] d = 11'b11111111111;
reg [63:0] temp;
reg [52:0] te;   
reg [51:0] F2D;
reg [23:0] F2S;

wire [52:0] temp1;
wire [6:0] lz_out;

leadingzero #(n,m) leadingzero_inst (
    .x(temp), 
    .y(lz_out)   
);

cls CLS_inst (
    .m(lz), 
    .x(te), 
    .y(temp1) 
);


always @* begin
    F2D = x[51:0]; 
    F2S = x[54:32];
    h = (db == 1) ? F2D : {F2S, 29'b0};
    temp = {~e_z, h, d};
    te = {~e_z, h};
    fz = (52'b0 == h);
    f = (normal == 1) ? temp1 : te; 
    lz = lz_out[5:0];
end

endmodule

module significant (
    input         db,
    input [63:0]  fp,
    input         e_z,
    input         normal, 
    output [5:0]  lz,
    output [52:0] f,
    output        fz,
    output [52:0] h  
);

parameter n = 64;
parameter m = 6;

wire [63:0] temp;
wire [52:0] te;   

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


assign h[52] = ~e_z;
assign h[51:0] = db ? fp[51:0] : {fp[54:32], 29'b0};
assign temp = {~e_z, h[51:0], {11{1'b1}}};
assign te = {~e_z, h};
assign fz = (52'b0 == h);
assign f = (normal == 1) ? temp1 : te; 
assign lz = lz_out[5:0];

endmodule

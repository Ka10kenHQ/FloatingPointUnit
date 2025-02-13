module significant (
    input db,
    input [63:0] fp,
    input e_z,
    input normal, 
    output reg [5:0] lz,
    output reg [52:0] f,
    output reg fz,
    output reg [51:0] h  
);

parameter n = 64;
parameter m = 6;

reg [63:0] temp;
reg [52:0] te;   

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
    h = db ? fp[51:0] : {fp[54:32], 29'b0};
    temp = {~e_z, h[51:0], {11{1'b1}}};
    te = {~e_z, h};
    fz = (52'b0 == h);
    f = (normal == 1) ? temp1 : te; 
    lz = lz_out[5:0];
end

endmodule

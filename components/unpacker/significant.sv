module significant #(parameter N = 64)(
    input db,
    input [N-1:0] x,
    input e_z,
    input normal, 
    output reg [5:0] lz,
    output reg [52:0] f,
    output reg fz,
    output reg [51:0] h  
);

parameter n = 64;
parameter m = 6;
reg [28:0] x1 = 0;
reg [11:0] d = 11'b11111111111;
reg [51:0] zero = 0;
reg [63:0] temp; 
reg [52:0] te;   
reg [51:0] F2D;
reg [23:0] F2S;

wire [52:0] temp1;

leadingzero #(n,m) leadingzero_inst (
    .x(temp), 
    .y(lz)   
);

cls CLS_inst (
    .m(lz), 
    .x(te), 
    .y(temp1) 
);


always @* begin
    F2D = x[51:0]; 
    F2S = x[54:32];
    h = (db == 1) ? F2D : {F2S, x1};
    temp = {{~e_z, h}, d};
    te = {~e_z, h};
    fz = (zero == h);
    f = (normal == 1) ? temp1 : te; 
end

endmodule

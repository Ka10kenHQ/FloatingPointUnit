module Unpacker #(
    parameter N = 64
)(
    input wire dbs,
    input  wire [N-1:0] x,
    input wire ez,
    input wire normal, 
    output reg [5:0] lz,
    output reg [52:0] f,
    output reg fz,
    output reg [51:0] h  
);
    
reg[28:0] x1 = 0;
reg[51:0] zero = 0;
reg [52:0] temp;
reg[52:0] temp1;
reg[51:0] F2D = x[51:0];
reg[23:0] F2S = x[54:32];
always @* begin
    if (dbs) begin
        h = F2D;
    end
    else begin
        h = {F2S, x1};
    end
    fz = (zero != h);
    temp = {~ez, h};
    leadingzero #(n = 53) uut (
      .x(temp),
      .y(lz)
    );
     CLS #(n = 53) ut (
       .m(lz),
      .x(temp),
      .y(temp1)
    );
    if(normal) begin
        f = temp1;
    end
    else begin
        f = temp;
    end

end
endmodule

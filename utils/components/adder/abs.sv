module abs#(parameter N=58)(
input wire[N-1:0] x,
output reg[N-2:0] abs
);

always@(*)begin
    abs = x[N-1] ? ~x[N-2:0]+1 : x[N-2:0];
end



endmodule

module abs#(parameter N=58)(
input  [N-1:0] x,
output [N-2:0] abs
);

assign abs = x[N-1] ? (~x[N-2:0] + 1) : x[N-2:0];

endmodule

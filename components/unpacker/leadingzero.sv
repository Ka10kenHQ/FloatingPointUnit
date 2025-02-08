module leadingzero #(parameter n = 64, m = 6) (
    input  [n - 1 : 0] x,
    output [m : 0] y
);
reg [m-1:0] y_H;
reg [m-1:0] y_L;
reg high_zero;
generate
if (m > 1) begin : rec

    leadingzero #(n/2, $clog2(n/2)) lower (
        .x(x[(n/2)-1 : 0]),
        .y(y_L)
        );
        leadingzero #(n/2, $clog2(n/2)) upper (
            .x(x[n-1 :n/2]),
            .y(y_H)
            );

            assign high_zero = (y_H[m-1] == 0);
            assign y = high_zero ? {1'b0, y_H} : {y_L[m-1], ~y_L[m-1], y_L[m-2:0]};
        end
        else if (m == 0) begin: bc_2
            assign   y = ~x[0];
        end
else begin : bc
            assign   y = {~x[1] & ~x[0], ~x[1] & x[0]};
end

endgenerate

endmodule
 

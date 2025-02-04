module inf_selector (
    input [1:0] RM,
    input s,
    output inf
);

    assign inf = (RM == 2'b01) | 
                 (RM == 2'b10 & ~s) | 
                 (RM == 2'b11 & s);

endmodule


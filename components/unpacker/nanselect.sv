module nanselect(
    input sa, 
    input [52:0] ha,
    input [52:0] hb,
    input sb,
    input nana,
    output snan,
    output [51:0] fnan 
);

assign snan = nana == 1 ? sa : sb;
assign fnan = nana == 1 ? {1'b1, ha[50:0]} : {1'b1, hb[50:0]};

endmodule




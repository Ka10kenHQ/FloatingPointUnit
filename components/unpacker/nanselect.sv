module nanselect(
    input sa, 
    input [51:0] ha,
    input [51:0] hb,
    input sb,
    input nana,
    output snan,
    output [51:0] fnan 
);

assign snan = nana == 1 ? sa : sb;
assign fnan = nana == 1 ? ha : hb;

endmodule




module nanselect(
input sa, 
input [51:0] ha,
input [51:0] hb,
input sb,
input nana,
output snan,
output [51:0] fnan 
);

always @(*) begin
snan = nana == 1 ? sa : sb;
fnan = nana == 1 ? ha : hb;
end    




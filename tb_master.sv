module tb_master;

reg [63:0] fpa, fpb;
reg db, normal, sub;
reg [1:0] RM;

wire [63:0] fp_out;
wire [4:0] IEEp;

wire sa, sb;
wire [10:0] ea, eb;
wire [5:0] lza, lzb;
wire [3:0] fla, flb;
wire [52:0] nan;
wire [52:0] fa, fb;
wire [10:0] es;
wire [56:0] fs;
wire ss;
wire [57:0] fls;
wire [12:0] er;

master uut (
    .fpa(fpa),
    .fpb(fpb),
    .db(db),
    .normal(normal),
    .sub(sub),
    .RM(RM),
    .fp_out(fp_out),
    .IEEp(IEEp),
    .sa(sa),
    .sb(sb),
    .ea(ea),
    .eb(eb),
    .lza(lza),
    .lzb(lzb),
    .fla(fla),
    .flb(flb),
    .nan(nan),
    .fa(fa),
    .fb(fb),
    .es(es),
    .fs(fs),
    .ss(ss),
    .fls(fls),
    .er_out(er)
);

initial begin
    fpa = 64'h4016000000000000; 
    fpb = 64'h400c000000000000; 
    db = 1;
    normal = 1;
    sub = 0;
    RM = 2'b11; 

    #10;
    $display("Test Case 1: %f + %f = %f", $bitstoreal(fpa), $bitstoreal(fpb), $bitstoreal(fp_out));

    $display("sa: %b", sa);
    $display("sb: %b", sb);
    $display("ea: %b", ea);
    $display("eb: %b", eb);
    $display("lza: %b", lza);
    $display("lzb: %b", lzb);
    $display("fla: %b", fla);
    $display("flb: %b", flb);
    $display("nan: %b", nan);
    $display("fa: %b", fa);
    $display("fb: %b", fb);
    $display("es: %b", es);
    $display("fs: %b", fs);
    $display("ss: %b", ss);
    $display("fls: %b", fls);
    $display("er: %b", er);

    fpa = 64'hc016000000000000; 
    fpb = 64'h400c000000000000; 
    sub = 1;

    #10;
    $display("Test Case 2: %f - %f = %f", $bitstoreal(fpa), $bitstoreal(fpb), $bitstoreal(fp_out));

    $display("sa: %b", sa);
    $display("sb: %b", sb);
    $display("ea: %b", ea);
    $display("eb: %b", eb);
    $display("lza: %b", lza);
    $display("lzb: %b", lzb);
    $display("fla: %b", fla);
    $display("flb: %b", flb);
    $display("nan: %b", nan);
    $display("fa: %b", fa);
    $display("fb: %b", fb);
    $display("es: %b", es);
    $display("fs: %b", fs);
    $display("ss: %b", ss);
    $display("fls: %b", fls);
    $display("er: %b", er);

    fpa = 64'h7FF0000000000000; 
    fpb = 64'h4000000000000000;
    sub = 0;

    #10;
    $display("Test Case 3: %f + %f = %f", $bitstoreal(fpa), $bitstoreal(fpb), $bitstoreal(fp_out));

    $display("sa: %b", sa);
    $display("sb: %b", sb);
    $display("ea: %b", ea);
    $display("eb: %b", eb);
    $display("lza: %b", lza);
    $display("lzb: %b", lzb);
    $display("fla: %b", fla);
    $display("flb: %b", flb);
    $display("nan: %b", nan);
    $display("fa: %b", fa);
    $display("fb: %b", fb);
    $display("es: %b", es);
    $display("fs: %b", fs);
    $display("ss: %b", ss);
    $display("fls: %b", fls);
    $display("er: %b", er);

    #10;
end
    
endmodule


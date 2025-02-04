`include "./../unpacker.sv"
module tb_unpacker;
    reg [63:0] fp;       
    reg db;              
    reg normal;          
    wire e_inf;        
    wire e_z;          
    wire [10:0] e;     
    wire s;           
    wire [5:0] lz;     
    wire [52:0] f;     
    wire fz;           
    wire [51:0] h;      

    unpacker uut (
        .fp(fp),
        .db(db),
        .normal(normal),
        .e_inf(e_inf),
        .e_z(e_z),
        .e(e),
        .s(s),
        .lz(lz),
        .f(f),
        .fz(fz),
        .h(h)
    );

    integer fd;     
    reg [430:0] line;
    reg [7:0] e32;  
    reg [22:0] f32; 
    reg s32;      
    reg [10:0] e64;
    reg [51:0] f64; 
    reg s64;

    initial begin
        fd = $fopen("./decomposed_f32.txt", "r");  
        if (fd == 0) begin
            $display("Error opening file.");
            $finish;
        end

        while (!$feof(fd)) begin
            $fgets(line, fd); 
            $display("Line read: %s", line);
                $sscanf(line, "f32: s = %b, e = %8b, f = %23b", s32, e32, f32);
                fp = {s32, e32, f32, 32'b0};
                db = 0;
                normal=0;
                #100;
        end
        $fclose(fd); 
    end

endmodule


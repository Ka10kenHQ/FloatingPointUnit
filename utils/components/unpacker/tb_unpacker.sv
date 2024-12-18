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
    reg [6:0] e32;  
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

            if (line[0] == "f" && line[1] == "3" && line[2] == "2") begin
                $display("Here");
                $sscanf(line, "f32: s = %b, e = %8b, f = %23b", s32, e32, f32);
                fp = {s32, e32, f32, 32'b0};
                db = 0;
                normal = 0;
                #10;
                $display("Test Case for f32:");
                $display("fp: %b, e_inf: %b, e_z: %b, e: %b, s: %b, lz: %b, f: %b, fz: %b, h: %b", 
                         fp, e_inf, e_z, e, s, lz, f, fz, h);
        end

        $fclose(fd); 
        #100;
        $finish; 
    end

endmodule


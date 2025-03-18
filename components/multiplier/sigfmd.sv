`include "./../../utils/ortree.sv"

module sigfmd (
    input [52:0]      fa,        
    input [52:0]      fb,  
    input             fdiv, 
    input             db,      
    output reg [56:0] fq         
);

wire [7:0] look_up;
rom256X8 rm (
    .addr(fb[51:44]),
    .data(look_up)
);

reg [57:0] fa_in, fb_in;     
wire [115:0] mul_out;        
multree mlt (
    .a(fa_in),
    .b(fb_in),
    .out(mul_out)
);


parameter n = 60;
wire or_out;
ortree #(n) or_inst (
    .x(mul_out[59:0]),
    .or_out(or_out)
);


reg [3:0] state = 0;             
reg [1:0] Dcnt;             
reg [57:0] x;               
reg [57:0] A;
reg [57:0] Da, Db;
reg [54:0] E;
reg [115:0] Eb;

wire [56:0] fd_out;
select_fd fd_inst (
    .Da(Da),
    .Db(Db),
    .Eb(Eb[114:0]),
    .E(E),
    .db(db),
    .fd(fd_out)
);


always @(state or posedge fdiv) begin
    case (state)
        0: begin 
            Dcnt <= db ? 2'b11 : 2'b10;
            x <= {2'b01, look_up, 48'b0};
            state <= 1;  // non-blocking assignment
        end
        1: begin         // NEWTON 1: Compute x_i * fb
            fa_in <= x;
            fb_in <= {fb, 5'b0};
            Dcnt <= Dcnt - 1;
            state <= 2;
        end
        2: begin         // NEWTON 2: Compute A = 2 - (x_i * fb)
            A <= ~mul_out[115:58];
            state <= 3;
        end
        3: begin         // NEWTON 3:  x_{i+1} = floor(A * x_i)
            fa_in <= A;
            fb_in <= x;
            state <= 4;
        end
        4: begin        // NEWTON 4: clock x reg
            x <= mul_out[115:58];
            state <= (Dcnt > 0) ? 1 : 5;
        end
        5: begin      // Quotient 1: E = floor(f_a * x)
            fa_in <= {fa, 5'b0};
            fb_in <= x;
            state <= 6;
        end
        6: begin     // Quotient 2: Da = fa and Db = fa
            Da <= {fa, 5'b0};
            Db <= {fb, 5'b0};
            state <= 7;  
        end
        7: begin    // Quotient 3: E_b = E * fb
            E <= {mul_out[115:90], mul_out[89:61] & {29{db}}};
            fa_in <= {mul_out[115:90], mul_out[89:61] & {29{db}}, 3'b0};
            fb_in <= {fb, 5'b0};
            state <= 8;
        end
        8: begin  // Quotient 4: clock Ebce
            Eb <= mul_out;
            state <= 9;
        end
        9: begin
            fq <= fd_out;
        end
    endcase
end


always @(negedge fdiv) begin
    fa_in = {fa, 5'b0};
    fb_in = {fb, 5'b0};
    #2;
    fq = {mul_out[115:60], or_out};
end

 
endmodule

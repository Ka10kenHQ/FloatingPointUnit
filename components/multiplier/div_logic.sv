// TODO: this needs correction
// problem is always block is not entered initially
module div_logic(
    input  [52:0]      fa,        
    input  [52:0]      fb,  
    input              db,
    input              fdiv,
    output reg [56:0]  fq
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

enum int unsigned { IDLE = 4'd0, NEWTON1 = 4'd1, NEWTON2 = 4'd2, NEWTON3 = 4'd3, NEWTON4 = 4'd4,
                   QUOT1 = 4'd5, QUOT2 = 4'd6, QUOT3 = 4'd7, QUOT4 = 4'd8, RESULT = 4'd9 } state, next_state;
reg init = 1;
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


always @(state or posedge init) begin
    $display("here");
    case(state)
        IDLE: begin 
            next_state <= NEWTON1;
            Dcnt <= db ? 2'b11 : 2'b10;
            x <= {2'b01, look_up, 48'b0};
        end
        NEWTON1: begin
            next_state <= NEWTON2;
            fa_in <= x;
            fb_in <= {fb, 5'b0};
            Dcnt <= Dcnt - 1;
        end
        NEWTON2: begin
            next_state <= NEWTON3;
            A <= ~mul_out[115:58];
        end
        NEWTON3: begin
            next_state <= NEWTON4;
            fa_in <= A;
            fb_in <= x;
        end
        NEWTON4: begin
            next_state <= (Dcnt > 0) ? IDLE : QUOT1;
            x <= mul_out[115:58];
        end
        QUOT1: begin
            next_state <= QUOT2;
            fa_in <= {fa, 5'b0};
            fb_in <= x;
        end
        QUOT2: begin
            next_state <= QUOT3;
            Da <= {fa, 5'b0};
            Db <= {fb, 5'b0};
        end
        QUOT3: begin
            next_state <= QUOT4;
            E <= {mul_out[115:90], mul_out[89:61] & {29{db}}};
            fa_in <= {mul_out[115:90], mul_out[89:61] & {29{db}}, 3'b0};
            fb_in <= {fb, 5'b0};
        end
        QUOT4: begin
            next_state <= RESULT;
            Eb <= mul_out;
        end
        RESULT: begin
            next_state <= RESULT;
            fq <= fd_out;
        end
        default: begin
            next_state <= IDLE;
        end
    endcase
    init = 0;
end

always_ff @(state) begin
    state <= next_state;
end

endmodule


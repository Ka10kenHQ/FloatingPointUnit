// Division logic using Newton-Raphson iteration for floating point division
module div_logic(
    input  [52:0]      fa,        
    input  [52:0]      fb,  
    input              db,
    input              fdiv,
    output reg [56:0]  fq,
    output reg         div_ready  // Add ready signal
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

localparam IDLE    = 4'd0;
localparam NEWTON1 = 4'd1;
localparam NEWTON2 = 4'd2;
localparam NEWTON3 = 4'd3;
localparam NEWTON4 = 4'd4;
localparam QUOT1   = 4'd5;
localparam QUOT2   = 4'd6;
localparam QUOT3   = 4'd7;
localparam QUOT4   = 4'd8;
localparam RESULT  = 4'd9;

reg [3:0] state, next_state;

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

// State machine - sequential logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;
        div_ready <= 1'b0;
        fq <= 57'b0;
    end else begin
        state <= next_state;
        
        case(state)
            IDLE: begin 
                div_ready <= 1'b0;
                if (start_div && fdiv) begin
                    Dcnt <= db ? 2'b11 : 2'b10;
                    x <= {2'b01, look_up, 48'b0};
                end
            end
            NEWTON1: begin
                fa_in <= x;
                fb_in <= {fb, 5'b0};
                Dcnt <= Dcnt - 1;
            end
            NEWTON2: begin
                A <= ~mul_out[115:58];
            end
            NEWTON3: begin
                fa_in <= A;
                fb_in <= x;
            end
            NEWTON4: begin
                x <= mul_out[115:58];
            end
            QUOT1: begin
                fa_in <= {fa, 5'b0};
                fb_in <= x;
            end
            QUOT2: begin
                Da <= {fa, 5'b0};
                Db <= {fb, 5'b0};
            end
            QUOT3: begin
                E <= {mul_out[115:90], mul_out[89:61] & {29{db}}};
                fa_in <= {mul_out[115:90], mul_out[89:61] & {29{db}}, 3'b0};
                fb_in <= {fb, 5'b0};
            end
            QUOT4: begin
                Eb <= mul_out;
            end
            RESULT: begin
                fq <= fd_out;
                div_ready <= 1'b1;
            end
        endcase
    end
end

// State machine - combinational logic
always @(*) begin
    case(state)
        IDLE: begin 
            if (start_div && fdiv)
                next_state = NEWTON1;
            else
                next_state = IDLE;
        end
        NEWTON1: next_state = NEWTON2;
        NEWTON2: next_state = NEWTON3;
        NEWTON3: next_state = NEWTON4;
        NEWTON4: begin
            if (Dcnt > 0)
                next_state = NEWTON1;  // Continue Newton iterations
            else
                next_state = QUOT1;    // Start quotient calculation
        end
        QUOT1: next_state = QUOT2;
        QUOT2: next_state = QUOT3;
        QUOT3: next_state = QUOT4;
        QUOT4: next_state = RESULT;
        RESULT: next_state = IDLE;  // Return to idle after result
        default: next_state = IDLE;
    endcase
end

endmodule


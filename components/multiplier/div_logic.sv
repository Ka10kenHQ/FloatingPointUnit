module div_logic(
    input              clk,
    input              rst_n, 
    input  [52:0]      fa,      
    input  [52:0]      fb,      
    input              db,      
    input              fdiv,     
    output [56:0]      fq
);

reg [57:0] opa, opb;


wire [7:0] look_up;
rom256X8 rm (
    .addr(opb[56:49]),
    .data(look_up)
);

wire [115:0] mul_out;
multree mlt (
    .a(opa),
    .b(opb),
    .out(mul_out)
);

parameter n = 60;
wire or_out;
ortree #(n) or_inst (
    .x(mul_out[59:0]),
    .or_out(or_out)
);

reg [3:0] state;
reg [1:0] Dcnt;
reg [57:0] x;
reg [57:0] A;
reg [57:0] Da, Db;
reg [54:0] E;
reg [115:0] Eb;
reg [56:0] fq_reg;


wire [56:0] fd_out;
select_fd fd_inst (
    .Da(Da),
    .Db(Db),
    .Eb(Eb[114:0]),
    .E(E),
    .db(db),
    .fd(fd_out)
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


always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
        fq_reg <= 57'b0;
        Dcnt <= 2'b0;
        x <= 58'b0;
        A <= 58'b0;
        Da <= 58'b0;
        Db <= 58'b0;
        E <= 55'b0;
        Eb <= 116'b0;
        opa <= 58'b0;
        opb <= 58'b0;
    end else begin
        case (state)
            IDLE:    state <= (fdiv) ? NEWTON1 : IDLE;
            NEWTON1: state <= NEWTON2;
            NEWTON2: state <= NEWTON3;
            NEWTON3: state <= NEWTON4;
            NEWTON4: state <= (Dcnt > 0) ? NEWTON1 : QUOT1;
            QUOT1:   state <= QUOT2;
            QUOT2:   state <= QUOT3;
            QUOT3:   state <= QUOT4;
            QUOT4:   state <= RESULT;
            RESULT:  state <= IDLE;
            default: state <= IDLE;
        endcase
        
        if (state == IDLE && fdiv) begin
            Dcnt <= db ? 2'b11 : 2'b10;
            x <= {2'b01, look_up, 48'b0};
        end 
        else if (state == NEWTON1) begin
            Dcnt <= Dcnt - 1;
            opa <= x;
            opb <= {fb, 5'b0};
        end
        else if (state == NEWTON2) begin
            A <= ~mul_out[115:58];
        end
        else if (state == NEWTON3) begin
            opa <= A;
            opb <= x;
        end
        else if (state == NEWTON4) begin
            x <= mul_out[115:58];
        end
        else if (state == QUOT1) begin
            opa <= {fa, 5'b0};
            opb <= x;
        end 
        else if (state == QUOT2) begin
            opa <= {fa, 5'b0};
            opb <= {fb, 5'b0};
            Da <= {fa, 5'b0};
            Db <= {fb, 5'b0};
        end
        else if (state == QUOT3) begin
            E <= {mul_out[115:90], mul_out[89:61] & {29{db}}};
            opa <= {mul_out[115:90], mul_out[89:61] & {29{db}}, 3'b0};
            opb <= {fb, 5'b0};
        end 
        else if (state == QUOT4) begin
            Eb <= mul_out;
        end
        else if (state == RESULT) begin
            fq_reg <= fd_out;
        end
        
    end
end

assign fq = fq_reg;

always @(posedge clk) begin
    if (fdiv) begin
        $display("Time %t: Division state=%d, Dcnt=%d, fdiv=%b, rst_n=%b", $time, state, Dcnt, fdiv, rst_n);
    end
    if (state == RESULT) begin
        $display("Division completed at time %t: fa=%b, fb=%b, fd_out=%b", $time, fa, fb, fd_out);
    end
end

endmodule

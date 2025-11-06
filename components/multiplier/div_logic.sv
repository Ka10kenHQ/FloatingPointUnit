module div_logic(
    input           clk,
    input           rst_n,
    input  [52:0]   fa,
    input  [52:0]   fb,
    input           db,
    input           fdiv,
    output logic [56:0] fq
);

logic  [57:0] fa_in, fb_in;
logic [116:0] mul_out;
wire [56:0] fd_out;

logic or_out;
logic [7:0] rom_data;

parameter n = 60;

logic [115:0] t,s1;
logic [115:0] c,s;
logic [3:0] curr_state, next_state;
logic [3:0] Dcnt;
logic [57:0] x, A, Da, Db;
logic [54:0] E;
logic [115:0] Eb;
logic [8:0] look_up;

logic faadoe, fbbdoe;
logic Eadoe, Aadoe;
logic xadoe, xbdoe;

logic cce, sce;
logic Dce, Ebce, Ece;
logic xce, Ace;
logic tlu;

rom256X8 rom_inst (.addr(fb[51:44]), .data(rom_data));

multree_div mlt (.a(fa_in), .b(fb_in), .t(t), .s(s1));

parameter m = 116;
add #(m) ad(
  .a(c),
  .b(s),
  .c_in(1'b0),
  .sum(mul_out)
);

ortree #(n) or_inst (.x(mul_out[59:0]), .or_out(or_out));

select_fd select_f (
    .Da(Da),
    .Db(Db),
    .Eb(Eb[114:0]), 
    .E(E),
    .db(db),
    .fd(fd_out)
);

localparam UNPACK = 4'd0;
localparam LOOKUP = 4'd1;
localparam NEWTON1 = 4'd2;
localparam NEWTON2 = 4'd3;
localparam NEWTON3 = 4'd4;
localparam NEWTON4 = 4'd5;
localparam QUOT1 = 4'd6;
localparam QUOT2 = 4'd7;
localparam QUOT3 = 4'd8;
localparam QUOT4 = 4'd9;
localparam SELECT_FD = 4'd10;
localparam ROUND1 = 4'd11;
localparam ROUND2 = 4'd12;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        curr_state <= UNPACK;
    else
        curr_state <= next_state;
end

always_comb begin
    next_state = curr_state;
    xce = 0; tlu = 0; Ace = 0; Dce = 0; Ece = 0; Ebce = 0; cce = 0; sce = 0;
    faadoe = 0; fbbdoe = 0; Eadoe = 0; Aadoe = 0; xadoe = 0; xbdoe = 0;

    case (curr_state)

        UNPACK: begin
            xce = 1; tlu = 1; fbbdoe = 1;
            next_state = LOOKUP;
        end

        LOOKUP: begin
            xadoe = 1; fbbdoe = 1;
            next_state = NEWTON1;
        end

        NEWTON1: begin
            Ace = 1;
            next_state = NEWTON2;
        end

        NEWTON2: begin 
            cce = 1; sce = 1;
            Aadoe = 1; xbdoe = 1;
            next_state = NEWTON3;
        end

        NEWTON3: begin
            xce = 1;
            next_state = NEWTON4;
        end

        NEWTON4: begin
            faadoe = 1; fbbdoe = 1;
            cce = 1; sce = 1;
            if (Dcnt == 3'd0)
                next_state = QUOT1;
            else
                next_state = NEWTON1;
        end

        QUOT1: begin
            faadoe = 1; fbbdoe = 1;
            Dce = 1; Ece = 1;
            next_state = QUOT2;
        end

        QUOT2: begin
            fbbdoe = 1;
            sce = 1; cce = 1;
            next_state = QUOT3;
        end

        QUOT3: begin
            Ebce = 1;
            next_state = QUOT4;
        end

        QUOT4: begin
            next_state = SELECT_FD;
        end

        SELECT_FD: next_state = ROUND1;

        ROUND1:    next_state = ROUND2;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        Dcnt <= 3'd0;
        x <= '0; A <= '0; Da <= '0; Db <= '0; E <= '0; Eb <= '0;
        fa_in <= '0; fb_in <= '0; fq <= '0; look_up <= '0;
        c <= '0; s <= '0;
    end else begin

        if (curr_state == LOOKUP) begin
            Dcnt <= db ? 3'd3 : 3'd2;
            look_up <= rom_data;
        end
        else if (curr_state == NEWTON1) begin
            Dcnt <= Dcnt - 1;
        end

        if (sce && cce) begin
            c <= t;
            s <= s1;
        end

        if (faadoe) fa_in <= {fa, 5'b0};
        if (fbbdoe) fb_in <= {fb, 5'b0};

        if (xadoe) fa_in <= x;
        if (xbdoe) fb_in <= x;

        if (Eadoe) fa_in <= E;
        if (Aadoe) fa_in <= A;
        
        if (xce) begin 
            if (tlu)
                x <= {2'b01, look_up, 48'b0};
            else 
                x <= mul_out[115:58]; 
        end
        
        if (Ace) A <= ~mul_out[115:58];
        
        if (Dce) begin
            Da <= {fa, 5'b0};
            Db <= {fb, 5'b0};
        end
        
        if (Ece) E <= {mul_out[115:90], (mul_out[89:61] & {29{db}}) , 3'b0};
            
        if (Ebce) Eb <= mul_out[115:0];
            
        if (curr_state == ROUND2) fq <= fd_out;
    end
end

endmodule

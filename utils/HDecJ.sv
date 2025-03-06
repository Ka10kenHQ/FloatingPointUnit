module HDecJ #(
    parameter N = 2,
    parameter npof2 = 2 ** $clog2(N)
)(
    input  [N-1:0] x, 
    output reg [2**N-1:0] y  
);
    wire [npof2-1:0] padded_x;
    assign padded_x = { {npof2 - N{1'b0}}, x };

    reg [npof2/2-1:0] x1;
    reg [npof2/2-1:0] x2;
    reg [2**(npof2/2)-1:0] U;
    reg [2**(npof2/2)-1:0] V;
    
    genvar i;
    generate
        if (npof2 > 1) begin : recursive_case
            HDecJ #(
                .N(npof2 / 2),
                .npof2(npof2 / 2)
            ) higher_decoder (
                .x(padded_x[npof2-1:npof2/2]),          
                .y(U)               
            );
            
            HDecJ #(
                .N(npof2 / 2),
                .npof2(npof2 / 2)
            ) lower_decoder (
                .x(padded_x[npof2/2-1:0]),          
                .y(V)               
            );
            for (i = 0; i < 2**npof2; i = i + 1) begin : gen_indices
                localparam IL = i % (2**(npof2/2));
                localparam IH = i / (2**(npof2/2));
                assign y[i] = (IH == 0) ? (U[0] | V[IL]) : (U[IH] | (U[IH-1] & V[IL]));
            end

        end
        else begin : base_case
            assign y[0] = padded_x[0];        
            assign y[1] = 0;     
        end
    endgenerate

endmodule



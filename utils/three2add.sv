module three2add #(parameter n = 11) (
    input [n-1:0] a,
    input [n-1:0] b,
    input [n-1:0] c,
    output reg [n:0] t,
    output reg [n:0] s
);
    integer i;
    reg [1:0] temp_sum;
    
    always @(*) begin
        t[0] = 0;

        for (i = 0; i < n; i = i + 1) begin
            temp_sum = a[i] + b[i] + c[i];

            s[i] = temp_sum[0];
            t[i+1] = temp_sum[1];
        end

        s[n] = 0;
    end
endmodule

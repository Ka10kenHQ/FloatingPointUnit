module ftadd #(parameter n = 12) (
    input [n:0] a,
    input [n:0] b,
    input [n:0] c,
    input [n:0] d,
    output reg [n+1:0] t,
    output reg [n+1:0] s
);
    integer i;
    reg [1:0] temp_sum1, temp_sum2;
    reg [n+1:0] carry, sum;

    always @(*) begin
        carry[0] = 0;

        for (i = 0; i < n+1; i = i + 1) begin
            temp_sum1 = a[i] + b[i] + c[i];

            sum[i] = temp_sum1[0];
            carry[i+1] = temp_sum1[1];
        end
        sum[n+1] = 0;

        t[0] = 0;
        for (i = 0; i < n+1; i = i + 1) begin
            temp_sum2 = sum[i] + carry[i] + d[i];

            s[i] = temp_sum2[0];
            t[i+1] = temp_sum2[1];
        end
        s[n+1] = 0;
    end
endmodule


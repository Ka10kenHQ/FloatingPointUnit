module three2add #(parameter n = 12) (
    input [n:0] a,
    input [n:0] b,
    input [n:0] c,
    input c_in,
    output reg [n+1:0] t,
    output reg [n+1:0] s
);
    integer i;
    reg carry;
    reg [n:0] temp_sum;
    
    always @(*) begin
        carry = c_in;
        t = 14'd0;
        s = 14'd0;

        for (i = 0; i < n+1; i = i + 1) begin
            temp_sum = a[i] + b[i] + c[i] + carry;

            s[i] = temp_sum[0];
            carry = temp_sum[1];
            t[i+1] = carry;
        end

        s[n+1] = carry;
    end
endmodule



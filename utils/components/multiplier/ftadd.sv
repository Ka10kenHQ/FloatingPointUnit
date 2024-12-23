module ftadd(
    input [12:0] a,
    input [12:0] b,
    input [12:0] c,
    input [12:0] d,
    input c_in,
    output reg [13:0] t,
    output reg [13:0] s
);
    integer i;
    reg carry;
    reg [12:0] temp_sum;
    
    always @(*) begin
        carry = c_in;
        t = 14'd0;
        s = 14'd0;

        for (i = 0; i < 13; i = i + 1) begin
            temp_sum = a[i] + b[i] + c[i] + d[i] + carry;

            s[i] = temp_sum[0];
            t[i+1] = carry;
        end

        s[13] = carry;
    end
endmodule


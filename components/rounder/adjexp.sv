module adjexp(
    input [10:0] e2,
    input db,
    input sigovf,
    input OVFen,

    output reg [10:0] e3,
    output reg OVF
);

reg [10:0] in;

// TODO: figure out 0^2 db^3 1^3 != 10 bits
reg [7:0] emax1alpha;


wire out;

andtree andt(
    .x(in),
    .and_out(out)
);

always @(*) begin
    emax1alpha = {2'b0, {3{db}}, 3'b111};
    if(db) begin
        in = e2;
    end
    else begin
        in = {3'b111, e2[7:0]};
    end

    OVF = sigovf & out;

    if( ~OVFen & sigovf & out) begin
        e3 = {2'b00, emax1alpha};
    end
    else begin
        e3 = e2;
    end

end


endmodule

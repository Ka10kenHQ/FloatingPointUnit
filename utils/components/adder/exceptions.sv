module exceptions (
    input e_inf,
    input h_1,
    input fz,
    input ez,
    output ZERO,
    output INF,
    output NAN,
    output SNAN
    );
    assign ZERO = fz & ez;
    assign INF = e_inf & fz;
    assign NAN = e_inf & h_1;
    assign SNAN = e_inf & ~(h_1 | fz);
endmodule

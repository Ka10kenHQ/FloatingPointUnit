use ieee754_test_suite::fp_decompose::decompose_f64;
mod common;

#[test]
fn test_div_edge_f64() {
    common::run_f64_test(
        "mul_div_output_results_64_div_edge.txt",
        "decomposed_f64_edge.txt",
        |a, b| a / b,
        decompose_f64,
        true, // is edge case
    );
}

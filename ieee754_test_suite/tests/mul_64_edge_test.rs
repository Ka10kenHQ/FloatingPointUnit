use ieee754_test_suite::fp_decompose::decompose_f64;
mod common;

#[test]
fn test_mul_edge_f64() {
    common::run_f64_test(
        "mul_div_output_results_64_edge.txt",
        "decomposed_f64_edge.txt",
        |a, b| a * b,
        decompose_f64,
        true,
    );
}

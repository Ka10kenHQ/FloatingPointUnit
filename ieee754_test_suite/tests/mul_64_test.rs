use ieee754_test_suite::fp_decompose::decompose_f64;
mod common;

#[test]
fn test_mul_f64() {
    common::run_f64_test(
        "mul_div_output_results_64.txt",
        "decomposed_f64.txt",
        |a, b| a * b,
        decompose_f64,
        false,
    );
}

#[test]
fn test_mul_f64_denormal() {
    common::run_f64_test(
        "mul_div_output_results_64_denormal.txt",
        "decomposed_f64_denormal.txt",
        |a, b| a * b,
        decompose_f64,
        false,
    );
}

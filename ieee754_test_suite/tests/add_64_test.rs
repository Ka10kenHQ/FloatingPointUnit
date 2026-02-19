use ieee754_test_suite::fp_decompose::decompose_f64;
mod common;

#[test]
fn test_add_f64() {
    common::run_f64_test(
        "add_sub_output_results.txt",
        "decomposed_f64.txt",
        |a, b| a + b,
        decompose_f64,
    );
}

#[test]
fn test_add_f64_denormal() {
    common::run_f64_test(
        "add_sub_output_results_denormal.txt",
        "decomposed_f64_denormal.txt",
        |a, b| a + b,
        decompose_f64,
    );
}

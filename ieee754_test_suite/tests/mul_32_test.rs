use ieee754_test_suite::fp_decompose::decompose_f32;
mod common;

#[test]
fn test_mul_f32() {
    common::run_f32_test(
        "mul_div_output_results_32.txt",
        "decomposed_f32.txt",
        |a, b| a * b,
        decompose_f32,
        false,
    );
}

#[test]
fn test_mul_f32_denormal() {
    common::run_f32_test(
        "mul_div_output_results_32_denormal.txt",
        "decomposed_f32_denormal.txt",
        |a, b| a * b,
        decompose_f32,
        false,
    );
}

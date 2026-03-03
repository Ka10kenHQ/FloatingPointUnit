use ieee754_test_suite::fp_decompose::decompose_f32;
mod common;

#[test]
fn test_div_f32() {
    common::run_f32_test_with_stats(
        "mul_div_output_results_32_div.txt",
        "mul_div_output_results_32_div_zero.txt",
        "mul_div_output_results_32_div_up.txt",
        "mul_div_output_results_32_div_down.txt",
        "decomposed_f32.txt",
        |a, b| a / b,
        decompose_f32,
    );
}

#[test]
fn test_div_denormal_f32() {
    common::run_f32_test_with_stats(
        "mul_div_output_results_32_div_denormal.txt",
        "mul_div_output_results_32_div_denormal_zero.txt",
        "mul_div_output_results_32_div_denormal_up.txt",
        "mul_div_output_results_32_div_denormal_down.txt",
        "decomposed_f32_denormal.txt",
        |a, b| a / b,
        decompose_f32,
    );
}

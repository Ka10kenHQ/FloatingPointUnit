use ieee754_test_suite::fp_decompose::decompose_f32;
mod common;

#[test]
fn test_sub_f32() {
    common::run_f32_test(
        "add_sub_output_results_32_sub.txt",
        "decomposed_f32.txt",
        |a, b| a - b,
        decompose_f32,
    );
}

#[test]
fn test_sub_f32_denormal() {
    common::run_f32_test(
        "add_sub_output_results_sub_32_denormal.txt",
        "decomposed_f32_denormal.txt",
        |a, b| a - b,
        decompose_f32,
    );
}

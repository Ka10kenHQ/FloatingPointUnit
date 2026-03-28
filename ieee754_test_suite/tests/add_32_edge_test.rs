use ieee754_test_suite::fp_decompose::decompose_f32;
mod common;

#[test]
fn test_add_edge_f32() {
    common::run_f32_test(
        "add_sub_output_results_32_edge.txt",
        "decomposed_f32_edge.txt",
        |a, b| a + b,
        decompose_f32,
        true,
    );
}

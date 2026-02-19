use std::fs::File;
use std::io::{BufRead, BufReader};
use std::path::PathBuf;

pub fn test_data_path(filename: &str) -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("../test")
        .join(filename)
}

#[allow(dead_code)]
pub fn run_f32_test(
    computed_file: &str,
    decomposed_file: &str,
    operation: impl Fn(f32, f32) -> f32,
    decomposer: impl Fn(f32) -> (u8, u8, u32),
) {
    let computed_path = test_data_path(computed_file);
    let decomposed_path = PathBuf::from(decomposed_file);
    let computed_file = File::open(&computed_path).expect(&format!(
        "Failed to open computed file: {:?}",
        computed_path
    ));
    let decomposed_file = File::open(&decomposed_path).expect(&format!(
        "Failed to open decomposed file: {:?}",
        decomposed_path
    ));
    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();
    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read computed line");
        let expected_line = expected_line.expect("Failed to read expected line");
        let parts: Vec<&str> = expected_line.split(';').collect();
        assert_eq!(parts.len(), 2, "Invalid format at line {}", i + 1);
        let a_bits = parts[0].trim().get(0..32).unwrap_or_default();
        let b_bits = parts[1].trim().get(0..32).unwrap_or_default();
        let a = f32::from_bits(u32::from_str_radix(a_bits, 2).expect("Invalid binary for a"));
        let b = f32::from_bits(u32::from_str_radix(b_bits, 2).expect("Invalid binary for b"));
        let result = operation(a, b);
        let (s_exp, e_exp, f_exp) = decomposer(result);
        let expected_output = format!(
            "{:0b}{:08b}{:023b}{:0b}{:08b}{:023b}",
            s_exp, e_exp, f_exp, s_exp, e_exp, f_exp
        );
        let parsed_computed = format!("{}{}", &computed_line[0..32], &computed_line[32..64]);
        assert_eq!(
            parsed_computed,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nExpected: {}\n inputs: a = {}, b = {}, result = {}",
            i + 1,
            parsed_computed,
            expected_output,
            a,
            b,
            result
        );
    }
}

#[allow(dead_code)]
pub fn run_f64_test(
    computed_file: &str,
    decomposed_file: &str,
    operation: impl Fn(f64, f64) -> f64,
    decomposer: impl Fn(f64) -> (u8, u16, u64),
) {
    let computed_path = test_data_path(computed_file);
    let decomposed_path = PathBuf::from(decomposed_file);
    let computed_file = File::open(&computed_path).expect(&format!(
        "Failed to open computed file: {:?}",
        computed_path
    ));
    let decomposed_file = File::open(&decomposed_path).expect(&format!(
        "Failed to open decomposed file: {:?}",
        decomposed_path
    ));
    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();
    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read computed line");
        let expected_line = expected_line.expect("Failed to read expected line");
        let parts: Vec<&str> = expected_line.split(';').collect();
        assert_eq!(parts.len(), 2, "Invalid format at line {}", i + 1);
        let a = f64::from_bits(u64::from_str_radix(parts[0], 2).expect("Invalid binary for a"));
        let b = f64::from_bits(u64::from_str_radix(parts[1], 2).expect("Invalid binary for b"));
        let result = operation(a, b);
        let (s_exp, e_exp, f_exp) = decomposer(result);
        let expected_output = format!("{:b}{:011b}{:052b}", s_exp, e_exp, f_exp);
        assert_eq!(
            computed_line,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nExpected: {}\n inputs: a = {}, b = {}, result = {}",
            i + 1,
            computed_line,
            expected_output,
            a,
            b,
            result
        );
    }
}

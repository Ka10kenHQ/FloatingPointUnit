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
    is_edge: bool,
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

        let expected_output = match is_edge {
            false => format!(
                "{:0b}{:08b}{:023b}{:0b}{:08b}{:023b}",
                s_exp, e_exp, f_exp, s_exp, e_exp, f_exp
            ),
            true => format!("{:08b}{:023b}{:08b}{:023b}", e_exp, f_exp, e_exp, f_exp),
        };

        let parsed_computed = match is_edge {
            false => format!("{}{}", &computed_line[0..32], &computed_line[32..64]),
            true => format!("{}{}", &computed_line[1..32], &computed_line[33..64]),
        };

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
    is_edge: bool,
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
        let expected_output = match is_edge {
            false => format!("{:b}{:011b}{:052b}", s_exp, e_exp, f_exp),
            true => format!("{:011b}{:052b}", e_exp, f_exp),
        };

        let parsed_computed = match is_edge {
            false => format!("{}", &computed_line),
            true => format!("{}", &computed_line[1..64]),
        };

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
pub fn run_f64_test_with_stats(
    computed_file_even: &str,
    computed_file_zero: &str,
    computed_file_up: &str,
    computed_file_down: &str,
    decomposed_file: &str,
    operation: impl Fn(f64, f64) -> f64,
    decomposer: impl Fn(f64) -> (u8, u16, u64),
) {
    let even = open_computed(computed_file_even);
    let zero = open_computed(computed_file_zero);
    let up = open_computed(computed_file_up);
    let down = open_computed(computed_file_down);
    let expected = open_expected(decomposed_file);

    let mut passed = 0usize;
    let mut failed = 0usize;

    for (i, (((e, z), u), (d, exp))) in even.zip(zero).zip(up).zip(down.zip(expected)).enumerate() {
        if run_multi_case(i, e, z, u, d, exp, &operation, &decomposer) {
            passed += 1;
        } else {
            failed += 1;
        }
    }

    println!("--------------------------------");
    println!("Total:  {}", passed + failed);
    println!("Passed: {}", passed);
    println!("Failed: {}", failed);
    println!("--------------------------------");

    if failed > 0 {
        panic!("{} test cases failed", failed);
    }
}

#[allow(dead_code)]
pub fn run_f32_test_with_stats(
    computed_even: &str,
    computed_zero: &str,
    computed_up: &str,
    computed_down: &str,
    decomposed_file: &str,
    operation: impl Fn(f32, f32) -> f32,
    decomposer: impl Fn(f32) -> (u8, u8, u32),
) {
    let even = open_computed(computed_even);
    let zero = open_computed(computed_zero);
    let up = open_computed(computed_up);
    let down = open_computed(computed_down);
    let expected = open_expected(decomposed_file);

    let mut passed = 0usize;
    let mut failed = 0usize;

    for (i, (((e, z), u), (d, exp))) in even.zip(zero).zip(up).zip(down.zip(expected)).enumerate() {
        if run_multi_case_f32(i, e, z, u, d, exp, &operation, &decomposer) {
            passed += 1;
        } else {
            failed += 1;
        }
    }

    println!("--------------------------------");
    println!("Total:  {}", passed + failed);
    println!("Passed: {}", passed);
    println!("Failed: {}", failed);
    println!("--------------------------------");

    if failed > 0 {
        panic!("{} test cases failed", failed);
    }
}

fn open_computed(file: &str) -> impl Iterator<Item = std::io::Result<String>> {
    let path = test_data_path(file);
    let file = File::open(&path).expect(&format!("Failed to open {:?}", path));
    BufReader::new(file).lines()
}

fn open_expected(file: &str) -> impl Iterator<Item = std::io::Result<String>> {
    let file = File::open(file).expect(&format!("Failed to open {:?}", file));
    BufReader::new(file).lines()
}

fn run_multi_case(
    i: usize,
    even: std::io::Result<String>,
    zero: std::io::Result<String>,
    up: std::io::Result<String>,
    down: std::io::Result<String>,
    expected_line: std::io::Result<String>,
    operation: &impl Fn(f64, f64) -> f64,
    decomposer: &impl Fn(f64) -> (u8, u16, u64),
) -> bool {
    let even = even.unwrap();
    let zero = zero.unwrap();
    let up = up.unwrap();
    let down = down.unwrap();
    let expected_line = expected_line.unwrap();

    let parts: Vec<&str> = expected_line.split(';').collect();
    if parts.len() != 2 {
        println!("Invalid format at line {}", i + 1);
        return false;
    }

    let a = f64::from_bits(u64::from_str_radix(parts[0], 2).unwrap());
    let b = f64::from_bits(u64::from_str_radix(parts[1], 2).unwrap());

    let result = operation(a, b);
    let (s, e, f) = decomposer(result);
    let expected_output = format!("{:b}{:011b}{:052b}", s, e, f);

    if even == expected_output
        || zero == expected_output
        || up == expected_output
        || down == expected_output
    {
        return true;
    }

    println!(
        "Mismatch at line {}\nExpected: {}\nEven: {}\nZero: {}\nUp: {}\nDown: {}\na={}, b={}, result={}",
        i + 1,
        expected_output,
        even,
        zero,
        up,
        down,
        a,
        b,
        result
    );

    false
}

fn run_multi_case_f32(
    i: usize,
    even: std::io::Result<String>,
    zero: std::io::Result<String>,
    up: std::io::Result<String>,
    down: std::io::Result<String>,
    expected_line: std::io::Result<String>,
    operation: &impl Fn(f32, f32) -> f32,
    decomposer: &impl Fn(f32) -> (u8, u8, u32),
) -> bool {
    let even = even.unwrap();
    let zero = zero.unwrap();
    let up = up.unwrap();
    let down = down.unwrap();
    let expected_line = expected_line.unwrap();

    let parts: Vec<&str> = expected_line.split(';').collect();
    if parts.len() != 2 {
        println!("Invalid format at line {}", i + 1);
        return false;
    }

    let a_bits = parts[0].trim().get(0..32).unwrap_or_default();
    let b_bits = parts[1].trim().get(0..32).unwrap_or_default();

    let a = f32::from_bits(u32::from_str_radix(a_bits, 2).unwrap());
    let b = f32::from_bits(u32::from_str_radix(b_bits, 2).unwrap());

    let result = operation(a, b);
    let (s, e, f) = decomposer(result);

    let expected_output = format!("{:0b}{:08b}{:023b}{:0b}{:08b}{:023b}", s, e, f, s, e, f);

    let even_parsed = format!("{}{}", &even[0..32], &even[32..64]);
    let zero_parsed = format!("{}{}", &zero[0..32], &zero[32..64]);
    let up_parsed = format!("{}{}", &up[0..32], &up[32..64]);
    let down_parsed = format!("{}{}", &down[0..32], &down[32..64]);

    if even_parsed == expected_output
        || zero_parsed == expected_output
        || up_parsed == expected_output
        || down_parsed == expected_output
    {
        return true;
    }

    println!(
        "Mismatch at line {}\nExpected: {}\nEven: {}\nZero: {}\nUp: {}\nDown: {}\na={}, b={}, result={}",
        i + 1,
        expected_output,
        even_parsed,
        zero_parsed,
        up_parsed,
        down_parsed,
        a,
        b,
        result
    );

    false
}

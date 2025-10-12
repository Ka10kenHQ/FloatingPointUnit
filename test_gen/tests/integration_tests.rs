use std::fs::File;
use std::io::{BufRead, BufReader};
use test_gen::fp_decompose::{decompose_f32, decompose_f64};

#[test]
fn test_add_f64() {
    let computed_file_path = "/home/achir/dev/FloatingPointUnit/test/add_sub_output_results.txt";
    let decomposed_file_path = "decomposed_f64.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));

    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
    ));

    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();

    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read line from expected file");
        let expected_line = expected_line.expect("Failed to read line from generated file");

        let parts: Vec<&str> = expected_line.split(';').collect();
        assert!(parts.len() == 2, "Invalid format at line {}", i + 1);

        let a = f64::from_bits(u64::from_str_radix(parts[0], 2).expect("Invalid binary for a"));
        let b = f64::from_bits(u64::from_str_radix(parts[1], 2).expect("Invalid binary for b"));

        let result: f64 = a + b;

        let (s_exp, e_exp, f_exp) = decompose_f64(result);
        let expected_output = format!("{:b}{:011b}{:052b}", s_exp, e_exp, f_exp);

        assert_eq!(
            computed_line,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nCorrect: {}\n inputs: a = {}, b = {}\n output={}",
            i + 1,
            computed_line,
            expected_output,
            a,
            b,
            result
        );
    }
}

#[test]
fn test_add_f64_denormal() {
    let computed_file_path =
        "/home/achir/dev/FloatingPointUnit/test/add_sub_output_results_denormal.txt";
    let decomposed_file_path = "decomposed_f64_denormal.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));
    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
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

        let result = a + b;

        let (s_exp, e_exp, f_exp) = decompose_f64(result);
        let expected_output = format!("{:b}{:011b}{:052b}", s_exp, e_exp, f_exp);

        assert_eq!(
            computed_line,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nExpected: {}\n inputs: a = {}, b = {}\n output={}",
            i + 1,
            computed_line,
            expected_output,
            a,
            b,
            result
        );
    }
}

#[test]
fn test_sub_f64() {
    let computed_file_path =
        "/home/achir/dev/FloatingPointUnit/test/add_sub_output_results_sub.txt";
    let decomposed_file_path = "decomposed_f64.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));

    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
    ));

    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();

    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read line from expected file");
        let expected_line = expected_line.expect("Failed to read line from generated file");

        let parts: Vec<&str> = expected_line.split(';').collect();
        assert!(parts.len() == 2, "Invalid format at line {}", i + 1);

        let a = f64::from_bits(u64::from_str_radix(parts[0], 2).expect("Invalid binary for a"));
        let b = f64::from_bits(u64::from_str_radix(parts[1], 2).expect("Invalid binary for b"));

        let result: f64 = a - b;

        let (s_exp, e_exp, f_exp) = decompose_f64(result);
        let expected_output = format!("{:b}{:011b}{:052b}", s_exp, e_exp, f_exp);

        assert_eq!(
            computed_line,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nCorrect: {}\n",
            i + 1,
            computed_line,
            expected_output,
        );
    }
}

#[test]
fn test_sub_f64_denormal() {
    let computed_file_path =
        "/home/achir/dev/FloatingPointUnit/test/add_sub_output_results_sub_denormal.txt";
    let decomposed_file_path = "decomposed_f64_denormal.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));
    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
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

        let result = a - b;

        let (s_exp, e_exp, f_exp) = decompose_f64(result);
        let expected_output = format!("{:b}{:011b}{:052b}", s_exp, e_exp, f_exp);

        assert_eq!(
            computed_line,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nExpected: {}\n inputs: a = {}, b = {}\n output={}",
            i + 1,
            computed_line,
            expected_output,
            a,
            b,
            result
        );
    }
}

#[test]
fn test_add_f32() {
    let computed_file_path = "/home/achir/dev/FloatingPointUnit/test/add_sub_output_results_32.txt";
    let decomposed_file_path = "decomposed_f32.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));

    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
    ));

    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();

    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read line from expected file");
        let expected_line = expected_line.expect("Failed to read line from generated file");

        let parts: Vec<&str> = expected_line.split(';').collect();
        assert!(parts.len() == 2, "Invalid format at line {}", i + 1);

        let a_first_32_bits = format!("{}", &parts[0][0..32]).to_string();
        let b_first_32_bits = format!("{}", &parts[1][0..32]).to_string();

        let a32 = u32::from_str_radix(&a_first_32_bits, 2).expect("Invalid binary for a");
        let b32 = u32::from_str_radix(&b_first_32_bits, 2).expect("Invalid binary for b");

        let result: f32 = f32::from_bits(a32) + f32::from_bits(b32);

        let (s_exp, e_exp, f_exp) = decompose_f32(result);

        let expected_output = format!(
            "{:0b}{:08b}{:023b}{:0b}{:08b}{:023b}",
            s_exp, e_exp, f_exp, s_exp, e_exp, f_exp
        );

        let parsed_computed = format!("{}{}", &computed_line[0..32], &computed_line[32..64]);

        assert_eq!(
            parsed_computed,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nCorrect: {}\n",
            i + 1,
            parsed_computed,
            expected_output,
        );
    }
}

#[test]
fn test_add_f32_denormal() {
    let computed_file_path =
        "/home/achir/dev/FloatingPointUnit/test/add_sub_output_results_32_denormal.txt";
    let decomposed_file_path = "decomposed_f32_denormal.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));

    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
    ));

    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();

    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read line from expected file");
        let expected_line = expected_line.expect("Failed to read line from generated file");

        let parts: Vec<&str> = expected_line.split(';').collect();
        assert!(parts.len() == 2, "Invalid format at line {}", i + 1);

        let a_bits = parts[0].trim().get(0..32).unwrap_or_default();
        let b_bits = parts[1].trim().get(0..32).unwrap_or_default();

        let a = f32::from_bits(u32::from_str_radix(a_bits, 2).expect("Invalid binary for a"));
        let b = f32::from_bits(u32::from_str_radix(b_bits, 2).expect("Invalid binary for b"));

        let result = a + b;

        let (s_exp, e_exp, f_exp) = decompose_f32(result);
        let expected_output = format!(
            "{:0b}{:08b}{:023b}{:0b}{:08b}{:023b}",
            s_exp, e_exp, f_exp, s_exp, e_exp, f_exp
        );

        let parsed_computed = format!("{}{}", &computed_line[0..32], &computed_line[32..64]);

        assert_eq!(
            parsed_computed,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nCorrect: {}\n inputs: a = {}, b = {}, result = {}",
            i + 1,
            parsed_computed,
            expected_output,
            a,
            b,
            result
        );
    }
}

#[test]
fn test_sub_f32() {
    let computed_file_path =
        "/home/achir/dev/FloatingPointUnit/test/add_sub_output_results_32_sub.txt";
    let decomposed_file_path = "decomposed_f32.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));

    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
    ));

    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();

    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read line from expected file");
        let expected_line = expected_line.expect("Failed to read line from generated file");

        let parts: Vec<&str> = expected_line.split(';').collect();
        assert!(parts.len() == 2, "Invalid format at line {}", i + 1);

        let a_first_32_bits = format!("{}", &parts[0][0..32]).to_string();
        let b_first_32_bits = format!("{}", &parts[1][0..32]).to_string();

        let a32 = u32::from_str_radix(&a_first_32_bits, 2).expect("Invalid binary for a");
        let b32 = u32::from_str_radix(&b_first_32_bits, 2).expect("Invalid binary for b");

        let result: f32 = f32::from_bits(a32) - f32::from_bits(b32);

        let (s_exp, e_exp, f_exp) = decompose_f32(result);

        let expected_output = format!(
            "{:0b}{:08b}{:023b}{:0b}{:08b}{:023b}",
            s_exp, e_exp, f_exp, s_exp, e_exp, f_exp
        );

        let parsed_computed = format!("{}{}", &computed_line[0..32], &computed_line[32..64]);

        assert_eq!(
            parsed_computed,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nCorrect: {}\n",
            i + 1,
            parsed_computed,
            expected_output,
        );
    }
}

#[test]
fn test_sub_f32_denormal() {
    let computed_file_path =
        "/home/achir/dev/FloatingPointUnit/test/add_sub_output_results_sub_32_denormal.txt";
    let decomposed_file_path = "decomposed_f32_denormal.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));

    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
    ));

    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();

    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read line from expected file");
        let expected_line = expected_line.expect("Failed to read line from generated file");

        let parts: Vec<&str> = expected_line.split(';').collect();
        assert!(parts.len() == 2, "Invalid format at line {}", i + 1);

        let a_bits = parts[0].trim().get(0..32).unwrap_or_default();
        let b_bits = parts[1].trim().get(0..32).unwrap_or_default();

        let a = f32::from_bits(u32::from_str_radix(a_bits, 2).expect("Invalid binary for a"));
        let b = f32::from_bits(u32::from_str_radix(b_bits, 2).expect("Invalid binary for b"));

        let result = a - b;

        let (s_exp, e_exp, f_exp) = decompose_f32(result);
        let expected_output = format!(
            "{:0b}{:08b}{:023b}{:0b}{:08b}{:023b}",
            s_exp, e_exp, f_exp, s_exp, e_exp, f_exp
        );

        let parsed_computed = format!("{}{}", &computed_line[0..32], &computed_line[32..64]);

        assert_eq!(
            parsed_computed,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nCorrect: {}\n inputs: a = {}, b = {}, result = {}",
            i + 1,
            parsed_computed,
            expected_output,
            a,
            b,
            result
        );
    }
}

#[test]
fn test_mul_f64() {
    let computed_file_path = "/home/achir/dev/FloatingPointUnit/test/mul_div_output_results_64.txt";
    let decomposed_file_path = "decomposed_f64.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));

    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
    ));

    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();

    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read line from expected file");
        let expected_line = expected_line.expect("Failed to read line from generated file");

        let parts: Vec<&str> = expected_line.split(';').collect();
        assert!(parts.len() == 2, "Invalid format at line {}", i + 1);

        let a = f64::from_bits(u64::from_str_radix(parts[0], 2).expect("Invalid binary for a"));
        let b = f64::from_bits(u64::from_str_radix(parts[1], 2).expect("Invalid binary for b"));

        let result: f64 = a * b;

        let (s_exp, e_exp, f_exp) = decompose_f64(result);
        let expected_output = format!("{:b}{:011b}{:052b}", s_exp, e_exp, f_exp);

        assert_eq!(
            computed_line,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nCorrect: {}\n inputs: a = {}, b = {}\n output={}",
            i + 1,
            computed_line,
            expected_output,
            a,
            b,
            result
        );
    }
}

#[test]
fn test_mul_f32() {
    let computed_file_path = "/home/achir/dev/FloatingPointUnit/test/mul_div_output_results_32.txt";
    let decomposed_file_path = "decomposed_f32.txt";

    let computed_file = File::open(computed_file_path).expect(&format!(
        "Failed to open expected results file: {}",
        computed_file_path
    ));

    let decomposed_file = File::open(decomposed_file_path).expect(&format!(
        "Failed to open generated results file: {}",
        decomposed_file_path
    ));

    let computed_reader = BufReader::new(computed_file).lines();
    let decomposed_reader = BufReader::new(decomposed_file).lines();

    for (i, (computed_line, expected_line)) in computed_reader.zip(decomposed_reader).enumerate() {
        let computed_line = computed_line.expect("Failed to read line from expected file");
        let expected_line = expected_line.expect("Failed to read line from generated file");

        let parts: Vec<&str> = expected_line.split(';').collect();
        assert!(parts.len() == 2, "Invalid format at line {}", i + 1);

        let a_first_32_bits = parts[0].trim().get(0..32).unwrap_or_default();
        let b_first_32_bits = parts[1].trim().get(0..32).unwrap_or_default();

        let a32 = u32::from_str_radix(&a_first_32_bits, 2).expect("Invalid binary for a");
        let b32 = u32::from_str_radix(&b_first_32_bits, 2).expect("Invalid binary for b");

        let result: f32 = f32::from_bits(a32) * f32::from_bits(b32);

        let (s_exp, e_exp, f_exp) = decompose_f32(result);

        let expected_output = format!(
            "{:0b}{:08b}{:023b}{:0b}{:08b}{:023b}",
            s_exp, e_exp, f_exp, s_exp, e_exp, f_exp
        );

        let parsed_computed = format!("{}{}", &computed_line[0..32], &computed_line[32..64]);

        assert_eq!(
            parsed_computed,
            expected_output,
            "Mismatch at line {}:\nComputed: {}\nCorrect: {}\n",
            i + 1,
            parsed_computed,
            expected_output,
        );
    }
}

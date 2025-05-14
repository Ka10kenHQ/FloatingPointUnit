use std::fs::File;
use std::io::{self, Write};

use ieee754::Ieee754;

fn decompose_f32(fp: f32) -> (u8, u8, u32) {
    let (sign, exp, f) = fp.decompose();
    let s = if sign { 1 } else { 0 };
    let e = (exp + 127) as u8;
    (s, e, f)
}

fn decompose_f64(fp: f64) -> (u8, u16, u64) {
    let (sign, exp, sig) = fp.decompose();

    let s = if sign { 1 } else { 0 };
    let e = (exp + 1023) as u16;
    let f = sig;
    (s, e, f)
}

fn normal_numbers() -> Vec<(f32, f64)> {
    vec![
        (69.0_f32, 69.0_f64),
        (3.14_f32, 3.14_f64),
        (1.0_f32, 1.0_f64),
        (2.718_f32, 2.718_f64),
        (1.5_f32, 1.5_f64),
        (12345.6789_f32, 12345.6789_f64),
        (1000000.0_f32, 1000000.0_f64),
        (42.0_f32, 42.0_f64),
        (123456.789_f32, 123456.789_f64),
        (987654321.0_f32, 987654321.0_f64),
        (1000000000.0_f32, 1000000000.0_f64),
        (1_000_000.0_f32, 1_000_000.0_f64),
        (100.01_f32, 100.01_f64),
        (123.45_f32, 123.45_f64),
        (54321.0_f32, 54321.0_f64),
        (2.0_f32, 2.0_f64),
        (1000000000.0_f32, 1000000000.0_f64),
        (1.123456_f32, 1.123456_f64),
        (111.0_f32, 111.0_f64),
        (987.0_f32, 987.0_f64),
        (3.1415926535_f32, 3.1415926535_f64),
        (1.414213562_f32, 1.414213562_f64),
        (2.2360679775_f32, 2.2360679775_f64),
        (10.0_f32, 10.0_f64),
        (5.0_f32, 5.0_f64),
        (7.89_f32, 7.89_f64),
        (4.56_f32, 4.56_f64),
        (9.99_f32, 9.99_f64),
        (11.11_f32, 11.11_f64),
        (1.0_f32, 1.0_f64),
        (1234567.0_f32, 1234567.0_f64),
        (222.0_f32, 222.0_f64),
        (123.0000001_f32, 123.0000001_f64),
        (9.81_f32, 9.81_f64),
        (144.0_f32, 144.0_f64),
        (0.001_f32, 0.001_f64),
        (9.876_f32, 9.876_f64),
        (1000.0_f32, 1000.0_f64),
        (250.0_f32, 250.0_f64),
        (500.0_f32, 500.0_f64),
        (50.0_f32, 50.0_f64),
        (7.0_f32, 7.0_f64),
        (3.5_f32, 3.5_f64),
        (15.0_f32, 15.0_f64),
        (99.0_f32, 99.0_f64),
        (22.0_f32, 22.0_f64),
        (1.75_f32, 1.75_f64),
        (12.0_f32, 12.0_f64),
        (30.0_f32, 30.0_f64),
        (11.0_f32, 11.0_f64),
        (77.0_f32, 77.0_f64),
        (9999.0_f32, 9999.0_f64),
        (105.0_f32, 105.0_f64),
        (11.5_f32, 11.5_f64),
        (6.25_f32, 6.25_f64),
        (1.6_f32, 1.6_f64),
        (1.25_f32, 1.25_f64),
        (5.5_f32, 5.5_f64),
        (7.5_f32, 7.5_f64),
        (99.99_f32, 99.99_f64),
        (1234.5_f32, 1234.5_f64),
        (333.3_f32, 333.3_f64),
        (4567.8_f32, 4567.8_f64),
        (8.9_f32, 8.9_f64),
    ]
}

fn zero() -> Vec<(f32, f64)> {
    vec![(0.0_f32, 0.0_f64)]
}

fn infinity() -> Vec<(f32, f64)> {
    vec![
        (f32::INFINITY, f64::INFINITY),
        (-f32::INFINITY, -f64::INFINITY),
    ]
}

fn denormal_numbers() -> Vec<(f32, f64)> {
    vec![
        (
            f32::from_bits(0x00000001),
            f64::from_bits(0x0000000000000001),
        ),
        (
            f32::from_bits(0x00000002),
            f64::from_bits(0x0000000000000002),
        ),
        (
            f32::from_bits(0x00000010),
            f64::from_bits(0x0000000000000010),
        ),
        (
            f32::from_bits(0x00000100),
            f64::from_bits(0x0000000000000100),
        ),
        (
            f32::from_bits(0x00001000),
            f64::from_bits(0x0000000000001000),
        ),
        (
            f32::from_bits(0x00010000),
            f64::from_bits(0x0000000000010000),
        ),
        (
            f32::from_bits(0x000FFFFF),
            f64::from_bits(0x000FFFFFFFFFFFFF),
        ),
        (
            f32::from_bits(0x007FFFFF),
            f64::from_bits(0x000FFFFFFFFFFFFF),
        ), // largest denormal
        (
            f32::from_bits(0x80000001),
            f64::from_bits(0x8000000000000001),
        ), // smallest negative denormal
        (
            f32::from_bits(0x807FFFFF),
            f64::from_bits(0x800FFFFFFFFFFFFF),
        ), // largest negative subnormals
    ]
}

fn min_max_values() -> Vec<(f32, f64)> {
    vec![
        (f32::MAX, f64::MAX),
        (-f32::MAX, -f64::MAX),
        (f32::MIN, f64::MIN),
        (-f32::MIN, -f64::MIN),
    ]
}

pub fn factorize() -> io::Result<()> {
    let mut test_cases = normal_numbers();
    test_cases.extend(zero());
    // let mut test_cases = denormal_numbers();

    let mut file_f32 = File::create("decomposed_f32.txt")?;
    let mut file_f64 = File::create("decomposed_f64.txt")?;

    for (fp32a, fp64a) in &test_cases {
        for (fp32b, fp64b) in &test_cases {
            let (s32a, e32a, f32a) = decompose_f32(*fp32a);
            let (s64a, e64a, f64a) = decompose_f64(*fp64a);

            let (s32b, e32b, f32b) = decompose_f32(*fp32b);
            let (s64b, e64b, f64b) = decompose_f64(*fp64b);

            writeln!(
                file_f32,
                "{:0b}{:08b}{:023b}{:0b}{:08b}{:023b};{:0b}{:08b}{:023b}{:0b}{:08b}{:023b}",
                s32a, e32a, f32a, s32a, e32a, f32a, s32b, e32b, f32b, s32b, e32b, f32b
            )?;

            writeln!(
                file_f64,
                "{:b}{:011b}{:052b};{:b}{:011b}{:052b}",
                s64a, e64a, f64a, s64b, e64b, f64b
            )?;
        }
    }

    println!("Decompositions written to 'decomposed_f32.txt' and 'decomposed_f64.txt'");

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add_f64() {
        use std::fs::File;
        use std::io::{BufRead, BufReader};

        let computed_file_path = "/home/achir/FloatingPointUnit/test/add_sub_output_results.txt";
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

        for (i, (computed_line, expected_line)) in
            computed_reader.zip(decomposed_reader).enumerate()
        {
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
    fn test_sub_f64() {
        use std::fs::File;
        use std::io::{BufRead, BufReader};

        let computed_file_path =
            "/home/achir/FloatingPointUnit/test/add_sub_output_results_sub.txt";
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

        for (i, (computed_line, expected_line)) in
            computed_reader.zip(decomposed_reader).enumerate()
        {
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
    fn test_add_f32() {
        use std::fs::File;
        use std::io::{BufRead, BufReader};

        let computed_file_path = "/home/achir/FloatingPointUnit/test/add_sub_output_results_32.txt";
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

        for (i, (computed_line, expected_line)) in
            computed_reader.zip(decomposed_reader).enumerate()
        {
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
            println!("s= {:0b}, e = {:08b}, f = {:023b}", s_exp, e_exp, f_exp);

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
    fn test_sub_f32() {
        use std::fs::File;
        use std::io::{BufRead, BufReader};

        let computed_file_path =
            "/home/achir/FloatingPointUnit/test/add_sub_output_results_32_sub.txt";
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

        for (i, (computed_line, expected_line)) in
            computed_reader.zip(decomposed_reader).enumerate()
        {
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
            println!("s= {:0b}, e = {:08b}, f = {:023b}", s_exp, e_exp, f_exp);

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
    fn test_mul_f64() {
        use std::fs::File;
        use std::io::{BufRead, BufReader};

        let computed_file_path = "/home/achir/FloatingPointUnit/test/mul_div_output_results_64.txt";
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

        for (i, (computed_line, expected_line)) in
            computed_reader.zip(decomposed_reader).enumerate()
        {
            let computed_line = computed_line.expect("Failed to read line from expected file");
            let expected_line = expected_line.expect("Failed to read line from generated file");

            let parts: Vec<&str> = expected_line.split(';').collect();
            assert!(parts.len() == 2, "Invalid format at line {}", i + 1);

            let a = f64::from_bits(u64::from_str_radix(parts[0], 2).expect("Invalid binary for a"));
            let b = f64::from_bits(u64::from_str_radix(parts[1], 2).expect("Invalid binary for b"));

            let result: f64 = a * b;

            let (s_exp, e_exp, f_exp) = decompose_f64(result);
            let expected_output = format!("{:b}{:011b}{:052b}", s_exp, e_exp, f_exp);
            println!("{}", expected_output);
            println!("{}", computed_line);

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
        use std::fs::File;
        use std::io::{BufRead, BufReader};

        let computed_file_path = "/home/achir/FloatingPointUnit/test/mul_div_output_results_32.txt";
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

        for (i, (computed_line, expected_line)) in
            computed_reader.zip(decomposed_reader).enumerate()
        {
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
}

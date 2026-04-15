use std::fs::File;
use std::io::{self, Write};

use crate::fp_decompose::{decompose_f32, decompose_f64};
use crate::test_data::{
    denormal_numbers, infinity, min_max_values, nan_values, normal_numbers, zero,
};

pub fn factorize_normal() -> io::Result<()> {
    let test_cases = normal_numbers();

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

pub fn factorize_denormal() -> io::Result<()> {
    let test_cases = denormal_numbers();

    let mut file_f32 = File::create("decomposed_f32_denormal.txt")?;
    let mut file_f64 = File::create("decomposed_f64_denormal.txt")?;

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

    println!(
        "Decompositions written to 'decomposed_f32_denormal.txt' and 'decomposed_f64_denormal.txt'"
    );

    Ok(())
}

pub fn factorize_edge_case() -> io::Result<()> {
    let mut test_cases = nan_values();
    test_cases.extend(zero());
    test_cases.extend(infinity());
    test_cases.extend(min_max_values());

    let mut file_f32 = File::create("decomposed_f32_edge.txt")?;
    let mut file_f64 = File::create("decomposed_f64_edge.txt")?;

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

    println!("Decompositions written to 'decomposed_f32_edge.txt' and 'decomposed_f64_edge.txt'");

    Ok(())
}

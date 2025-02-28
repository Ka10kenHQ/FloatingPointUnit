use std::fs::File;
use std::io::{self, Write};

fn decompose_f32(fp: f32) -> (u32, u8, u32) {
    let bits = f32::to_bits(fp);
    let s = (bits >> 31) & 1;
    let e = ((bits >> 23) & 0xFF) as u8;
    let f = bits & 0x7FFFFF;
    (s, e, f)
}

fn decompose_f64(fp: f64) -> (u64, u16, u64) {
    let bits = f64::to_bits(fp);
    let s = (bits >> 63) & 1;
    let e = ((bits >> 52) & 0x7FF) as u16;
    let f = bits & 0xFFFFFFFFFFFFF;
    (s, e, f)
}

fn normal_numbers() -> Vec<(f32, f64)> {
    vec![
        (69.0_f32, 69.0_f64),
        (3.14_f32, 3.14_f64),
        (1.0_f32, 1.0_f64),
        (0.0_f32, 0.0_f64),
        (-1.0_f32, -1.0_f64),
        (2.718_f32, 2.718_f64),
        (1.5_f32, 1.5_f64),
        (12345.6789_f32, 12345.6789_f64),
        (0.1234_f32, 0.1234_f64),
        (1000000.0_f32, 1000000.0_f64),
    ]
}

fn zero() -> Vec<(f32, f64)> {
    vec![(0.0_f32, 0.0_f64), (-0.0_f32, -0.0_f64)]
}

fn infinity() -> Vec<(f32, f64)> {
    vec![
        (f32::INFINITY, f64::INFINITY),
        (-f32::INFINITY, -f64::INFINITY),
    ]
}

fn denormal_numbers() -> Vec<(f32, f64)> {
    vec![
        // Smallest positive denormal number for f32 and f64
        (
            f32::from_bits(0x00000001),
            f64::from_bits(0x0000000000000001),
        ),
        // Smallest negative denormal number for f32 and f64
        (
            f32::from_bits(0x80000001),
            f64::from_bits(0x8000000000000001),
        ),
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

fn exponent_boundary_test() -> Vec<(f32, f64)> {
    vec![
        (2.0_f32.powi(128), 2.0_f64.powi(1024)),
        (2.0_f32.powi(-128), 2.0_f64.powi(-1023)),
    ]
}

pub fn factorize() -> io::Result<()> {
    let test_cases = [
        normal_numbers(),
        zero(),
        infinity(),
        denormal_numbers(),
        min_max_values(),
        exponent_boundary_test(),
    ]
    .concat();

    let mut file_f32 = File::create("decomposed_f32.txt")?;
    let mut file_f64 = File::create("decomposed_f64.txt")?;

    for (fp32, fp64) in test_cases {
        let (s32, e32, f32) = decompose_f32(fp32);
        let (s64, e64, f64) = decompose_f64(fp64);

        writeln!(
            file_f32,
            "f32: s = {:b}, e = {:08b}, f = {:023b}",
            s32, e32, f32
        )?;

        writeln!(
            file_f64,
            "f64: s = {:b}, e = {:011b}, f = {:052b}",
            s64, e64, f64
        )?;
    }

    println!("Decompositions written to 'decomposed_f32.txt' and 'decomposed_f64.txt'");

    Ok(())
}

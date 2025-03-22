use std::fs::File;
use std::io::{self, Write};

fn decompose_f32(fp: f32) -> (u32, u8, u32) {
    let bits = fp.to_bits();
    let s = (bits >> 31) & 1;
    let e = ((bits >> 23) & 0xFF) as u8;
    let f = bits & 0x7FFFFF;
    (s, e, f)
}

fn decompose_f64(fp: f64) -> (u64, u16, u64) {
    let bits = fp.to_bits();
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

fn write_decomposed_f32(file: &mut File, value: f32) -> io::Result<()> {
    let (s, e, f) = decompose_f32(value);
    writeln!(file, "s={:01b}, e={:08b}, f={:023b}", s, e, f)
}

fn write_decomposed_f64(file: &mut File, value: f64) -> io::Result<()> {
    let (s, e, f) = decompose_f64(value);
    writeln!(file, "s={:01b}, e={:011b}, f={:052b}", s, e, f)
}

fn write_decomposed_input_f32(file: &mut File, fpa32: f32, fpb32: f32) -> io::Result<()> {
    let (sa, ea, fa) = decompose_f32(fpa32);
    let (sb, eb, fb) = decompose_f32(fpb32);

    writeln!(
        file,
        "{:01b}{:08b}{:023b}{:01b}{:08b}{:023b};{:01b}{:08b}{:023b}{:01b}{:08b}{:023b}",
        sa, ea, fa, sa, ea, fa, sb, eb, fb, sb, eb, fb
    )
}

fn write_decomposed_input_f64(file: &mut File, fpa64: f64, fpb64: f64) -> io::Result<()> {
    let (sa, ea, fa) = decompose_f64(fpa64);
    let (sb, eb, fb) = decompose_f64(fpb64);

    writeln!(
        file,
        "{:01b}{:011b}{:053b};{:01b}{:011b}{:053b}",
        sa, ea, fa, sb, eb, fb
    )
}

pub fn factorize() -> io::Result<()> {
    let test_cases = normal_numbers();

    let mut file_f32 = File::create("decomposed_f32.txt")?;
    let mut file_f32_add = File::create("computed_f32_add.txt")?;
    let mut file_f32_sub = File::create("computed_f32_sub.txt")?;
    let mut file_f32_mul = File::create("computed_f32_mul.txt")?;
    let mut file_f32_div = File::create("computed_f32_div.txt")?;

    let mut file_f64 = File::create("decomposed_f64.txt")?;
    let mut file_f64_add = File::create("computed_f64_add.txt")?;
    let mut file_f64_sub = File::create("computed_f64_sub.txt")?;
    let mut file_f64_mul = File::create("computed_f64_mul.txt")?;
    let mut file_f64_div = File::create("computed_f64_div.txt")?;

    for &(fpa32, fpa64) in &test_cases {
        for &(fpb32, fpb64) in &test_cases {
            write_decomposed_input_f32(&mut file_f32, fpa32, fpb32)?;

            write_decomposed_input_f64(&mut file_f64, fpa64, fpb64)?;

            write_decomposed_f32(&mut file_f32_add, fpa32 + fpb32)?;
            write_decomposed_f32(&mut file_f32_sub, fpa32 - fpb32)?;
            write_decomposed_f32(&mut file_f32_mul, fpa32 * fpb32)?;
            if fpb32 != 0.0 {
                write_decomposed_f32(&mut file_f32_div, fpa32 / fpb32)?;
            }

            write_decomposed_f64(&mut file_f64_add, fpa64 + fpb64)?;
            write_decomposed_f64(&mut file_f64_sub, fpa64 - fpb64)?;
            write_decomposed_f64(&mut file_f64_mul, fpa64 * fpb64)?;

            if fpb64 != 0.0 {
                write_decomposed_f64(&mut file_f64_div, fpa64 / fpb64)?;
            }
        }
    }

    println!("Decompositions and operations written to output files.");

    Ok(())
}

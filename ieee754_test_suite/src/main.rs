use std::io;

use ieee754_test_suite::{
    // file_utils::{factorize_denormal, factorize_normal},
    fp_decompose::decompose_f64,
    // lookup::lookup_table,
};

fn main() -> io::Result<()> {
    // println!("Generating test files for floating point operations...");

    // Generate test files for normal floating point operations
    // factorize_normal()?;

    // Generate test files for denormal floating point operations
    // factorize_denormal()?;

    // println!("All test files generated successfully!");

    // let _ = lookup_table();

    something();

    Ok(())
}

fn something() {
    let a: f64 = 69.0_f64;
    let b: f64 = 12345.6789_f64;

    let (s, e, f) = decompose_f64(a / b);

    println!("{:0b}, {:11b}, {:052b}", s, e, f)
}

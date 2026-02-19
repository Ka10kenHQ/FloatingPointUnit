use std::io;

use ieee754_test_suite::{
    // file_utils::{factorize_denormal, factorize_normal},
    lookup::lookup_table,
};

fn main() -> io::Result<()> {
    println!("Generating test files for floating point operations...");

    // Generate test files for normal floating point operations
    // factorize_normal()?;

    // Generate test files for denormal floating point operations
    // factorize_denormal()?;

    println!("All test files generated successfully!");

    let _ = lookup_table();

    Ok(())
}

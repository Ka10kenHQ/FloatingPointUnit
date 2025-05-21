use std::io;

use test_gen::file_utils::{factorize_denormal, factorize_normal};

fn main() -> io::Result<()> {
    println!("Generating test files for floating point operations...");

    // Generate test files for normal floating point operations
    factorize_normal()?;

    // Generate test files for denormal floating point operations
    factorize_denormal()?;

    println!("All test files generated successfully!");

    Ok(())
}

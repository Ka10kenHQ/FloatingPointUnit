use std::io;

use test_gen::{
    file_utils::{factorize_denormal, factorize_normal},
    lookup::lookup_table,
};

fn main() -> io::Result<()> {
    println!("Generating test files for floating point operations...");

    factorize_normal()?;

    factorize_denormal()?;

    println!("All test files generated successfully!");

    lookup_table()?;

    Ok(())
}

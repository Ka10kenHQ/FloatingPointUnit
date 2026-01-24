use std::fs::File;
use std::io::{Result, Write};

pub fn lookup_table() -> Result<()> {
    let mut file = File::create("lookup_table.txt")?;

    for fb in 0..=255 {
        let sig = 1.0 + (fb as f64) / 256.0; // significant in [1,2)

        let recip = 1.0 / sig; // reciprocal in (0.5,1]

        let fixed = (recip * 256.0).round() as u8; // Q0.8 format

        writeln!(file, "{:08b}", fixed)?;
    }

    Ok(())
}

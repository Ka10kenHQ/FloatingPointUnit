use std::{fs::File, io::Result, io::Write};

pub fn lookup_table() -> Result<()> {
    let mut file = File::create("lookup_table.txt")?;
    for fb in 0..=255 {
        let approx = calc_x0(fb) * 65536.0;
        writeln!(file, "{:016b}", approx as u16)?;
    }
    Ok(())
}

fn calc_x0(fb: u8) -> f64 {
    let gamma = 8;
    let t = fb as f64;

    let fb_mid = 1.0 + (t + 0.5) * 2f64.powi(-gamma);
    let x_prime = 1.0 / fb_mid;

    let step = 2f64.powi(-(gamma as i32 - 1));
    let q = (x_prime / step).round();

    let x0 = q * step;
    x0
}

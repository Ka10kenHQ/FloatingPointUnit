use std::{fs::File, io::Result};
use std::io::Write;


pub fn lookup_table() -> Result<()> {

   let mut file = File::create("lookup_table.txt")?;

   for fb in 0..=255 {
      let approx = calc_x0(fb) * 65536.0;
      writeln!(file, "{:016b}", approx as u16)?;
   }

   Ok(())

}

fn calc_x0(fb : u8) -> f64 {
   let gamma = 8;

   let signif = (fb as f64)/ (256.0);
   // println!("{}", signif);
   let fb_pr = 1.0 + (2.0f64.powi(- gamma - 1)) +  signif  as f64;

   // println!("{:09b}", (fb_pr * 256.0) as u16);


   let x_p = 1.0 / fb_pr;

   // println!("{}", x_p);

   let rnd = 2.0f64.powi(- gamma - 1);

   // println!("{}", rnd);

   let q = x_p / rnd;

   let left = q * 2.0f64.powi(- gamma - 1) - x_p;
   let right = (q+1.0) * 2.0f64.powi(- gamma - 1) - x_p;
 
   let mut x0 = (q+1.0) * 2.0f64.powi(- gamma - 1); 
   
   if left < right {
      x0 = (q) * 2.0f64.powi(- gamma - 1);
   }
   // println!("{}", x0);

   x0
}



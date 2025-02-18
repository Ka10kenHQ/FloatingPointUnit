use std::{fs::File, io::Result};
use std::io::{self, Write};


pub fn lookup_table() -> Result<()> {

   let mut file = File::create("lookup_table.hex")?;


   for fb in 0..256 {
      let approx = (48/17) - (32/17) * fb;
      writeln!(file, "{:02X}", approx)?;
   }

   Ok(())

}


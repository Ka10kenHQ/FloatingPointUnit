use std::fs;
use std::path::Path;
use std::process::Command;

fn run_verilog_simulation(fp_a: u64, fp_b: u64, db: bool, normal: bool) -> String {
    let fa_input = format!("{:x}", fp_a);
    let fb_input = format!("{:x}", fp_b);
    let db_input = if db { "1" } else { "0" };
    let normal_input = if normal { "1" } else { "0" };

    let output = Command::new("target/unpackermaster_sim")
        .env("FA2", fa_input)
        .env("FB2", fb_input)
        .env("DB", db_input)
        .env("NORMAL", normal_input)
        .output()
        .expect("Failed to run Verilog simulation");

    if !output.status.success() {
        panic!("Verilog simulation failed");
    }

    String::from_utf8_lossy(&output.stdout).to_string()
}

fn compile_unpacker() {
    let sv_dir = "/home/achir/FloatingPointUnit/components/unpacker/";
    let output_file = "target/unpackermaster_sim";

    let sv_files: Vec<String> = fs::read_dir(sv_dir)
        .expect("Failed to read directory")
        .filter_map(|entry| {
            let entry = entry.ok()?;
            if entry.path().extension()? == "sv" {
                Some(entry.path().to_string_lossy().to_string())
            } else {
                None
            }
        })
        .collect();

    if sv_files.is_empty() {
        panic!("No Verilog files found in the unpacker directory");
    }

    let output_dir = Path::new("target");
    if !output_dir.exists() {
        std::fs::create_dir_all(output_dir).expect("Failed to create output directory");
    }

    let mut command = Command::new("iverilog");
    command.arg("-o").arg(output_file);

    for file in sv_files {
        command.arg(file);
    }

    let status = command.status().expect("Failed to compile SystemVerilog");

    if !status.success() {
        panic!("Unpackermaster compilation failed");
    }

    println!("cargo:rerun-if-changed={}", sv_dir);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_unpacker() {
        compile_unpacker();
        let result = run_verilog_simulation(0x3FF0000000000000, 0x4000000000000000, true, true);
        println!("Simulation Result: {}", result);

        // assert!(result.contains("expected_output"));
    }
}

use test_gen::{factorize, lookup};

fn main() {
    let factors_res = factorize::factorize();
    let lookup_res = lookup::lookup_table();

    match lookup_res {
        Ok(()) => println!("lookup generate completed"),
        Err(_) => println!("Error generating lookup"),
    }

    match factors_res {
        Ok(()) => println!("factorized numbers generate completed"),
        Err(_) => println!("Error generating factorization"),
    }
}

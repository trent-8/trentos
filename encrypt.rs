use std::env;
use std::fs::File;
use std::io::{self, Read, Write};

fn read_file_bytes(file_path: &str) -> Vec<u8> {
    let mut file = File::open(file_path).expect("failed to open a file");
    let mut buffer = Vec::new();
    file.read_to_end(&mut buffer).expect("failed to read a file");
    buffer
}

fn write_to_file(file_path: &str, data: &[u8]) {
    let mut file = File::create(file_path).expect("failed to create file");
    file.write_all(data).expect("failed to write data to file");
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        eprintln!("Usage: {} <input file> <output file>", args[0]);
        return;
    }
    println!("Please enter the encryption key:");
    let mut key = String::new();
    io::stdin().read_line(&mut key).expect("failed to read the encryption key");
    let key = key.as_bytes();
    let mut data = read_file_bytes(&args[1]);
    for i in 0..data.len() {
        data[i] ^= key[i % key.len()];
    }
    write_to_file(&args[2], &data);
}
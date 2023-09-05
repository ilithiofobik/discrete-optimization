pub fn keys(i: u32, k: u32) -> Vec<u32> {
    (0..k)
    .map(move |j| 2u32.pow(j) ^ i) // xor przez 000...1...000
    .collect()
}
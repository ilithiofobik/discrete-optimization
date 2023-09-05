use std::collections::HashMap;
use crate::utils::*;
const UTWO: u32 = 2;

pub struct Hypercube {
    pub k: u32,
    pub n: usize,
    pub f: Vec<HashMap<u32, u32>>,
    pub c: Vec<HashMap<u32, u32>>,
}

impl Hypercube {
    pub fn new(k: u32) -> Self {
        let n = UTWO.pow(k) as usize;
        let mut f = Vec::new();
        let mut c = Vec::new();

        for i in 0..n {
            let keys = keys(i as u32, k);

            let fi: HashMap<u32, u32> = 
                keys
                .iter()
                .map(|&key| (key, 0))
                .collect();

            let ci: HashMap<u32, u32> =
                keys 
                .iter() 
                .map(|&key| {
                    let cost =
                        if key > (i as u32) {
                            let mut l = std::cmp::max(key.count_ones(), k - key.count_ones());
                            l = std::cmp::max(l, i.count_ones());
                            l = std::cmp::max(l, k - i.count_ones());
                            fastrand::u32(1..=UTWO.pow(l))
                        } else {
                            0
                        };

                    (key, cost)
                })
                .collect();

            f.push(fi);
            c.push(ci);
        }

        Self { k, n, f, c }
    }
}

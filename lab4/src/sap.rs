use std::collections::HashMap;

use crate::hypercube::Hypercube;
use crate::utils::*;

fn admissible_arc(hc: &Hypercube, i: u32, d: &[u32]) -> Option<u32> {
    let k = hc.k;
    let two: u32 = 2;

    (0..k)
    .map(|e| two.pow(e) ^ i)
    .filter(|&j| d[i as usize] == d[j as usize] + 1)
    .find(|&j| (hc.c[i as usize])[&j] > (hc.f[i as usize])[&j])
}

pub fn shortest_augmenting_path(hc: &mut Hypercube) -> (u32, u32) {
    let n = hc.n;
    let k = hc.k as usize;
    let t = (n as u32) - 1;
    let mut pre = vec![std::u32::MAX; n];
    let two: u32 = 2;
    let mut num_paths = 0;

    // zerowanie f
    for i in 0..n {
        hc.f[i] =
            keys(i as u32, k as u32)
            .iter()
            .map(|&key| (key, 0))
            .collect::<HashMap<u32, u32>>();
    }

    // uzyskiwanie d -> liczba zer w zapisie bitowym
    let mut d =
        (0..n)
        .map(|i| (k as u32) - i.count_ones())
        .collect::<Vec<u32>>();

    let mut i = 0;

    while d[0] < (n as u32) {
        let x = admissible_arc(hc, i, &d);
        match x {
            Some(j) => {
                pre[j as usize] = i;
                i = j;
                if i == t {
                    num_paths += 1;
                    let mut delta = std::u32::MAX;
                    let mut x = t;
                    while x != 0 {
                        delta = std::cmp::min(
                            delta,
                            (hc.c[pre[x as usize] as usize])[&x]
                                - (hc.f[pre[x as usize] as usize])[&x],
                        );
                        x = pre[x as usize];
                    }
                    x = t;
                    while x != 0 {
                        delta = std::cmp::min(
                            delta,
                            (hc.c[pre[x as usize] as usize])[&x]
                                - (hc.f[pre[x as usize] as usize])[&x],
                        );
                        let new_val = (hc.f[pre[x as usize] as usize])[&x] + delta;
                        hc.f[pre[x as usize] as usize].insert(x, new_val);
                        x = pre[x as usize];
                    }
                    i = 0;
                }
            }

            None => {
                let keys = keys(i, k as u32);

                d[i as usize] =
                    keys
                    .into_iter()
                    .filter(|&key| d[i as usize] == d[key as usize] + 1)
                    .filter(|&key| (hc.c[i as usize])[&key] > (hc.f[i as usize])[&key])
                    .min()
                    .unwrap_or(std::u32::MAX);

                if i != 0 {
                    i = pre[i as usize];
                }
            }
        }
    }

    let sum: u32 =
        (0..k)
        .map(|i| two.pow(i as u32))
        .map(|v| (hc.f[0])[&v])
        .sum();

    (sum, num_paths)
}
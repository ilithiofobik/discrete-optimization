use std::collections::{VecDeque, HashMap};
use crate::hypercube::Hypercube;
use crate::utils::*;

fn find_path(hc: &Hypercube) -> Option<Vec<u32>> {
    let k = hc.k;
    let n = hc.n;
    let t = n - 1;
    let mut stack = VecDeque::new();
    let mut pre = vec![std::u32::MAX; n];
    let mut visited = vec![false; n];
    stack.push_back(0);
    visited[0] = true;

    while !stack.is_empty() && pre[t] == std::u32::MAX {
        let mut u = n;
        if let Some(x) = stack.pop_front() { u = x.to_owned() }
        for i in 0..k {
            let v = (2i32.pow(i) ^ (u as i32)) as u32;
            if !visited[v as usize] && (hc.c[u])[&v] > (hc.f[u])[&v] {
                visited[v as usize] = true;
                stack.push_back(v as usize);
                pre[v as usize] = u as u32;
            }
        }
    }

    if pre[t] == std::u32::MAX {
        return None
    }

    let mut path = vec![t as u32];
    let mut x = t;
    while x != 0 {
        path.push(pre[x]);
        x = pre[x] as usize;
    }
    Some(path)
}

pub fn edmonds_karp(hc: &mut Hypercube) -> (u32, u32) {
    let n = hc.n;
    let k = hc.k as usize;
    let two: u32 = 2;
    let mut num_paths = 0;

    for i in 0..n {
        hc.f[i] =
            keys(i as u32, k as u32)
            .iter()
            .map(|&key| (key, 0))
            .collect::<HashMap<u32, u32>>();
    }

    while let Some(path) = find_path(hc) {
        num_paths += 1;

        let min_cap =
            (0..k)
            .map(|i| {
                let u = path[i + 1] as usize;
                let v = path[i];
                (hc.c[u])[&v] - (hc.f[u])[&v]
            })
            .min()
            .unwrap_or(std::u32::MAX);

        for i in 0..k {
            let u = path[i + 1] as usize;
            let v = path[i];
            let new_val = (hc.f[u])[&v] + min_cap;
            hc.f[u].insert(v, new_val);
        }
    }

    let sum: u32 =
        (0..k)
        .map(|i| two.pow(i as u32))
        .map(|v| (hc.f[0])[&v])
        .sum();

    (sum, num_paths)
}


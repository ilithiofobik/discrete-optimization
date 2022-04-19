use rand::Rng;
use std::collections::{HashMap, VecDeque};
use std::fs::OpenOptions;
use std::io::Write;

pub struct Hypercube {
    pub k: u32,
    pub n: usize,
    pub f: Vec<HashMap<u32, u32>>,
    pub c: Vec<HashMap<u32, u32>>,
}

impl Hypercube {
    pub fn new(k: u32) -> Self {
        let two: u32 = 2;
        let n = two.pow(k as u32) as usize;
        let mut f = Vec::new();
        let mut c = Vec::new();

        for i in 0..n {
            let mut fi = HashMap::new();
            let mut ci = HashMap::new();
            for j in 0..k {
                let key = two.pow(j as u32) ^ (i as u32); // xor przez 000...1...000
                fi.insert(key, 0);
                if key > (i as u32) {
                    let mut l = std::cmp::max(key.count_ones(), k - key.count_ones());
                    l = std::cmp::max(l, i.count_ones());
                    l = std::cmp::max(l, k - i.count_ones());
                    let cost = rand::thread_rng().gen_range(1..=two.pow(l));
                    ci.insert(key, cost);
                } else {
                    ci.insert(key, 0);
                }
            }
            f.push(fi);
            c.push(ci);
        }

        Self { k, n, f, c }
    }
}

fn find_path(hypercube: &mut Hypercube) -> Option<Vec<u32>> {
    let k = hypercube.k;
    let n = hypercube.n;
    let t = n - 1;
    let two: i32 = 2;
    let mut stack = VecDeque::new();
    let mut pre = Vec::new();
    let mut visited = Vec::new();
    stack.push_back(0);
    for _ in 0..n {
        pre.push(std::u32::MAX);
        visited.push(false);
    }
    visited[0] = true;

    while !stack.is_empty() && pre[t] == std::u32::MAX {
        assert!(!stack.is_empty());
        let first = stack.pop_front();
        let mut u = n;
        match first {
            Some(x) => u = x.to_owned(),
            None => (),
        }
        for i in 0..k {
            let v = (two.pow(i) ^ (u as i32)) as u32;
            if !visited[v as usize] && (hypercube.c[u])[&v] > (hypercube.f[u])[&v] {
                visited[v as usize] = true;
                stack.push_back(v as usize);
                pre[v as usize] = u as u32;
            }
        }
    }

    if pre[t] == std::u32::MAX {
        return None;
    }
    let mut path = vec![t as u32];
    let mut x = t;
    while x != 0 {
        path.push(pre[x]);
        x = pre[x] as usize;
    }
    Some(path)
}

pub fn edmonds_karp(hypercube: &mut Hypercube) -> (u32, u32) {
    let n = hypercube.n;
    let k = hypercube.k as usize;
    let two: u32 = 2;
    let mut num_paths = 0;

    for i in 0..n {
        for j in 0..k {
            let key = two.pow(j as u32) ^ (i as u32); // xor przez 000...1...000
            hypercube.f[i].insert(key, 0);
        }
    }

    while let Some(path) = find_path(hypercube) {
        num_paths += 1;
        let mut min_cap = std::u32::MAX;
        for i in 0..k {
            let u = path[i + 1] as usize;
            let v = path[i];
            min_cap = std::cmp::min(min_cap, (hypercube.c[u])[&v] - (hypercube.f[u])[&v]);
        }
        for i in 0..k {
            let u = path[i + 1] as usize;
            let v = path[i];
            let new_val = (hypercube.f[u])[&v] + min_cap;
            hypercube.f[u].insert(v, new_val);
        }
    }

    let mut sum = 0;
    for i in 0..k {
        let v = two.pow(i as u32);
        sum += (hypercube.f[0])[&v];
    }
    (sum, num_paths)
}

fn admissible_arc(hypercube: &mut Hypercube, i: u32, d: &[u32]) -> Option<u32> {
    let k = hypercube.k;
    let two: u32 = 2;

    for e in 0..k {
        let j = two.pow(e) ^ i;
        if d[i as usize] == d[j as usize] + 1
            && (hypercube.c[i as usize])[&j] > (hypercube.f[i as usize])[&j]
        {
            return Some(j);
        }
    }

    None
}

pub fn shortest_augmenting_path(hypercube: &mut Hypercube) -> (u32, u32) {
    let n = hypercube.n;
    let k = hypercube.k as usize;
    let t = (n as u32) - 1;
    let mut pre = vec![std::u32::MAX; n];
    let two: u32 = 2;
    let mut num_paths = 0;

    // zerowanie f
    for i in 0..n {
        for j in 0..k {
            let key = two.pow(j as u32) ^ (i as u32); // xor przez 000...1...000
            hypercube.f[i].insert(key, 0);
        }
    }

    // uzyskiwanie d -> liczba zer w zapisie bitowym
    let mut d = Vec::new();
    for i in 0..n {
        d.push((k as u32) - i.count_ones());
    }

    let mut i = 0;

    while d[0] < (n as u32) {
        let x = admissible_arc(hypercube, i, &d);
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
                            (hypercube.c[pre[x as usize] as usize])[&x]
                                - (hypercube.f[pre[x as usize] as usize])[&x],
                        );
                        x = pre[x as usize];
                    }
                    x = t;
                    while x != 0 {
                        delta = std::cmp::min(
                            delta,
                            (hypercube.c[pre[x as usize] as usize])[&x]
                                - (hypercube.f[pre[x as usize] as usize])[&x],
                        );
                        let new_val = (hypercube.f[pre[x as usize] as usize])[&x] + delta;
                        hypercube.f[pre[x as usize] as usize].insert(x, new_val);
                        x = pre[x as usize];
                    }
                    i = 0;
                }
            }
            None => {
                let mut min_d = std::u32::MAX;
                for j in 0..k {
                    let key = two.pow(j as u32) ^ (i as u32); // xor przez 000...1...000
                    if d[i as usize] == d[key as usize] + 1
                        && (hypercube.c[i as usize])[&key] > (hypercube.f[i as usize])[&key]
                    {
                        min_d = std::cmp::min(min_d, d[key as usize] + 1);
                    }
                }
                d[i as usize] = min_d;
                if i != 0 {
                    i = pre[i as usize];
                }
            }
        }
    }

    let mut sum = 0;
    for i in 0..k {
        let v = two.pow(i as u32);
        sum += (hypercube.f[0])[&v];
    }
    (sum, num_paths)
}

pub fn generate_model(hypercube: &Hypercube, filename: &str) -> std::io::Result<()> {
    let mut file = OpenOptions::new()
        .write(true)
        .create(true)
        .append(true)
        .open(filename)?;

    let n = hypercube.n;
    let k = hypercube.k;

    writeln!(file, "import LinearAlgebra")?;
    writeln!(file, "using JuMP")?;
    writeln!(file, "using GLPK\n")?;

    writeln!(file, "function model()\n")?;

    writeln!(file, "    model = Model(GLPK.Optimizer)\n")?;

    writeln!(file, "    # x[i, j] - flow from node i to node j")?;
    writeln!(file, "    # Warning: In this model nodes are from 1 to 2^k")?;
    writeln!(file, "    @variable(model, x[1:{}, 1:{}], Int)\n", n, n)?;

    writeln!(file, "    # Capacities of given arcs")?;

    writeln!(
        file,
        "   @constraint(model, [i = 0:{}, j = 0:{}; count_ones(i ⊻ j) != 1], x[i+1, j+1] == 0)",
        n - 1,
        n - 1
    )?;
    writeln!(
        file,
        "   @constraint(model, [i = 0:{}, j = 0:{}; i>j && count_ones(i ⊻ j) == 1], x[i+1, j+1] == 0)",
        n - 1,
        n - 1
    )?;
    let two: u32 = 2;
    for i in 0..n {
        for j in 0..k {
            let v = (i as u32) ^ two.pow(j);
            if v > (i as u32) {
                writeln!(
                    file,
                    "   @constraint(model, x[{}, {}] <= {})",
                    i + 1,
                    v + 1,
                    (hypercube.c[i])[&v]
                )?;
            }
        }
    }

    writeln!(file)?;
    writeln!(file, "    # Flow must be balanced")?;
    writeln!(
        file,
        "   @constraint(model, [i = 2:{}], sum(x[i, :]) == sum(x[:, i]))",
        n - 1
    )?;
    writeln!(
        file,
        "    @constraint(model, sum(x[1, :])  == sum(x[:, {}]))",
        n
    )?;

    writeln!(file, "    # Trying to maximize the flow")?;
    writeln!(file, "    @objective(model, Max, sum(x[1, :]))\n")?;

    writeln!(file, "    optimize!(model)")?;
    writeln!(file, "    println(Int64(objective_value(model)))")?;
    writeln!(file, "end\n")?;
    writeln!(file, "println(@elapsed model())")?;

    Ok(())
}

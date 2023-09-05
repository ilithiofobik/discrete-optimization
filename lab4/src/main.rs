use colored::*;
use std::env;
use lab4::hypercube;
use lab4::edmonds_karp;
use lab4::sap;
use lab4::julia;
use std::time::Instant;

fn main() {
    let args: Vec<String> = env::args().collect();
    let mut k: u32 = 1;
    let mut print = false;
    let mut gen_glpk = false;
    let mut model_name = "";

    for i in 0..args.len() {
        if args[i] == "--size" {
            k = args[i + 1].parse::<u32>().unwrap();
        }
        if args[i] == "--printFlow" {
            print = true;
        }
        if args[i] == "--glpk" {
            gen_glpk = true;
            model_name = &args[i + 1];
        }
    }

    let mut cube = hypercube::Hypercube::new(k);
    if gen_glpk {
        let model = julia::generate_model(&cube, model_name);
        match model {
            Ok(_) => (),
            Err(e) => eprintln!("{}", e),
        }
    }

    // testy do Karpa
    let start = Instant::now();
    let (max_flow, num_paths) = edmonds_karp::edmonds_karp(&mut cube);
    let duration = start.elapsed();

    println!("Edmonds-Karp Max flow: {}", max_flow);
    //println!("{}", max_flow);
    if print {
        let two: u32 = 2;
        for i in 0..cube.n {
            for j in 0..k {
                let key = two.pow(j) ^ (i as u32);
                if key > (i as u32) {
                    println!("Edmonds-Karp x[{}][{}]={}", i, key, (cube.f[i])[&key]);
                }
            }
        }
    }

    let time = format!("Edmonds-Karp Elapsed time: {} s", duration.as_secs_f64());
    //let time = format!("{}", duration.as_secs_f64());
    eprintln!("{}", time.red());
    let paths = format!("Edmonds-Karp Number of analysed paths: {}", num_paths);
    //let paths = format!("{}", num_paths);
    eprintln!("{}", paths.red());

    // testy do shortest augmenting path
    let start = Instant::now();
    let (max_flow, num_paths) = sap::shortest_augmenting_path(&mut cube);
    let duration = start.elapsed();

    println!("Shortest Augmenting Path Max flow: {}", max_flow);
    //println!("{}", max_flow);
    if print {
        let two: u32 = 2;
        for i in 0..cube.n {
            for j in 0..k {
                let key = two.pow(j) ^ (i as u32);
                if key > (i as u32) {
                    println!(
                        "Shortest Augmenting Path x[{}][{}]={}",
                        i,
                        key,
                        (cube.f[i])[&key]
                    );
                }
            }
        }
    }

    let time = format!(
        "Shortest Augmenting Path Elapsed time: {} s",
        duration.as_secs_f64()
    );
    //let time = format!("{}", duration.as_secs_f64());
    eprintln!("{}", time.red());
    let paths = format!(
        "Shortest Augmenting Path Number of analysed paths: {}",
        num_paths
    );
    //let paths = format!("{}", num_paths);
    eprintln!("{}", paths.red());
}

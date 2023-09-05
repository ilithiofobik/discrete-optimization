use std::fs::OpenOptions;
use std::io::Write;
use crate::hypercube::Hypercube;

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

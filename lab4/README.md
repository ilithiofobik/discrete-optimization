## Table of contents
* [Author](#author)
* [Files](#files)
* [Running programs](#running)

## Author: 
Wojciech Sęk

## Files:
The code was divided into two files:
* `main.rs` - runs the experiment for hupercube of given size and prints the results by both Edmonds-Karp algorithm and Shortest Augmenting Path algorithm.
* `hypercube.rs` - contains the structure used for hypercube, functions used by the algorithms and the algorithms themselves.
## Running:
* To compile all the files please do use the following command\
`cargo build --release`\
It will result in a optimized verstion of code written in the Rust language.
* To run the main program use this command\
`target\release\lab4`
* You may want to use the following flags:
    * `--size k` - the hypercube's dimension will be set to `k`. By default it is set to 1. 
    * `--glpk filename` - it will generate an LP model in Julia language resembling the generated one. Please do use filename like `*.jl`.
    * `--printFlow` - this flag allows you to print the whole flow found by given algorithms.
* The program will always print the maximal flow found by both algorithms and the time of running and visited paths.
* To run the generated model in `Julia` please do use command\
`julia filename`
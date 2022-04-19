import LinearAlgebra
using JuMP
using GLPK

n, m = [parse(Int, x) for x in split(readline())]

c = zeros(n, n)
t = zeros(n, n)

for _ in 1:m
    ix, jx, cx, tx = [parse(Int, x) for x in split(readline())]
    c[ix, jx] = cx
    t[ix, jx] = tx
end

i0, j0 = [parse(Int, x) for x in split(readline())]
T = parse(Int, readline())

model = Model(GLPK.Optimizer)

# x - matrix representing which arcs are used in the path
# x[i, j] = 1 iff there is the arc from i to j is in the path
# x[i ,j] = 0 otherwise
@variable(model, x[1:n, 1:n], Bin)

# nonexisting arcs cannot be used
@constraint(model, [i = 1:n, j = 1:n; c[i, j] == 0], x[i, j] == 0)

# for every node different from starting and ending ones the sum of arcs
# entering the node should be equal to the sum of arcs leaving the node
@constraint(model, [i = 1:n; i != i0 && i != j0], sum(x[i, :]) == sum(x[:, i]))

# for the starting node the sum of arcs entering the node 
# should be equal to the sum of arcs leaving the node + 1
@constraint(model, sum(x[i0, :]) - sum(x[:, i0]) == 1)

# for the ending node the sum of arcs entering the node 
# should be equal to the sum of arcs leaving the node - 1
@constraint(model, sum(x[j0, :]) - sum(x[:, j0]) == -1)

# the total time of the path should be less or equal to T
@constraint(model, LinearAlgebra.dot(t, x) <= T)

@objective(model, Min, LinearAlgebra.dot(c, x))

println(model)
optimize!(model)
@show termination_status(model)
@show objective_value(model)
@show value.(x)
import LinearAlgebra
using JuMP
using GLPK

function model()

    model = Model(GLPK.Optimizer)

    # x[i, j] - flow from node i to node j
    # Warning: In this model nodes are from 1 to 2^k
    @variable(model, x[1:4, 1:4], Int)

    # Capacities of given arcs
   @constraint(model, [i = 0:3, j = 0:3; count_ones(i ⊻ j) != 1], x[i+1, j+1] == 0)
   @constraint(model, [i = 0:3, j = 0:3; i>j && count_ones(i ⊻ j) == 1], x[i+1, j+1] == 0)
   @constraint(model, x[1, 2] <= 2)
   @constraint(model, x[1, 3] <= 4)
   @constraint(model, x[2, 4] <= 2)
   @constraint(model, x[3, 4] <= 3)

    # Flow must be balanced
   @constraint(model, [i = 2:3], sum(x[i, :]) == sum(x[:, i]))
    @constraint(model, sum(x[1, :])  == sum(x[:, 4]))
    # Trying to maximize the flow
    @objective(model, Max, sum(x[1, :]))

    optimize!(model)
    println(Int64(objective_value(model)))
end

println(@elapsed model())

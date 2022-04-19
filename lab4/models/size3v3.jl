import LinearAlgebra
using JuMP
using GLPK

function model()

    model = Model(GLPK.Optimizer)

    # x[i, j] - flow from node i to node j
    # Warning: In this model nodes are from 1 to 2^k
    @variable(model, x[1:8, 1:8], Int)

    # Capacities of given arcs
   @constraint(model, [i = 0:7, j = 0:7; count_ones(i ⊻ j) != 1], x[i+1, j+1] == 0)
   @constraint(model, [i = 0:7, j = 0:7; i>j && count_ones(i ⊻ j) == 1], x[i+1, j+1] == 0)
   @constraint(model, x[1, 2] <= 2)
   @constraint(model, x[1, 3] <= 5)
   @constraint(model, x[1, 5] <= 7)
   @constraint(model, x[2, 4] <= 1)
   @constraint(model, x[2, 6] <= 2)
   @constraint(model, x[3, 4] <= 2)
   @constraint(model, x[3, 7] <= 3)
   @constraint(model, x[4, 8] <= 5)
   @constraint(model, x[5, 6] <= 1)
   @constraint(model, x[5, 7] <= 3)
   @constraint(model, x[6, 8] <= 6)
   @constraint(model, x[7, 8] <= 4)

    # Flow must be balanced
   @constraint(model, [i = 2:7], sum(x[i, :]) == sum(x[:, i]))
    @constraint(model, sum(x[1, :])  == sum(x[:, 8]))
    # Trying to maximize the flow
    @objective(model, Max, sum(x[1, :]))

    optimize!(model)
    println(Int64(objective_value(model)))
end

println(@elapsed model())

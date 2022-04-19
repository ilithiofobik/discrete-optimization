import LinearAlgebra
using JuMP
using GLPK

function model()

    model = Model(GLPK.Optimizer)

    # x[i, j] - flow from node i to node j
    # Warning: In this model nodes are from 1 to 2^k
    @variable(model, x[1:16, 1:16], Int)

    # Capacities of given arcs
   @constraint(model, [i = 0:15, j = 0:15; count_ones(i ⊻ j) != 1], x[i+1, j+1] == 0)
   @constraint(model, [i = 0:15, j = 0:15; i>j && count_ones(i ⊻ j) == 1], x[i+1, j+1] == 0)
   @constraint(model, x[1, 2] <= 12)
   @constraint(model, x[1, 3] <= 1)
   @constraint(model, x[1, 5] <= 4)
   @constraint(model, x[1, 9] <= 3)
   @constraint(model, x[2, 4] <= 5)
   @constraint(model, x[2, 6] <= 8)
   @constraint(model, x[2, 10] <= 8)
   @constraint(model, x[3, 4] <= 2)
   @constraint(model, x[3, 7] <= 7)
   @constraint(model, x[3, 11] <= 6)
   @constraint(model, x[4, 8] <= 6)
   @constraint(model, x[4, 12] <= 2)
   @constraint(model, x[5, 6] <= 1)
   @constraint(model, x[5, 7] <= 7)
   @constraint(model, x[5, 13] <= 1)
   @constraint(model, x[6, 8] <= 8)
   @constraint(model, x[6, 14] <= 7)
   @constraint(model, x[7, 8] <= 8)
   @constraint(model, x[7, 15] <= 3)
   @constraint(model, x[8, 16] <= 7)
   @constraint(model, x[9, 10] <= 7)
   @constraint(model, x[9, 11] <= 6)
   @constraint(model, x[9, 13] <= 8)
   @constraint(model, x[10, 12] <= 4)
   @constraint(model, x[10, 14] <= 5)
   @constraint(model, x[11, 12] <= 1)
   @constraint(model, x[11, 15] <= 1)
   @constraint(model, x[12, 16] <= 16)
   @constraint(model, x[13, 14] <= 3)
   @constraint(model, x[13, 15] <= 4)
   @constraint(model, x[14, 16] <= 16)
   @constraint(model, x[15, 16] <= 1)

    # Flow must be balanced
   @constraint(model, [i = 2:15], sum(x[i, :]) == sum(x[:, i]))
    @constraint(model, sum(x[1, :])  == sum(x[:, 16]))
    # Trying to maximize the flow
    @objective(model, Max, sum(x[1, :]))

    optimize!(model)
    println(Int64(objective_value(model)))
end

println(@elapsed model())

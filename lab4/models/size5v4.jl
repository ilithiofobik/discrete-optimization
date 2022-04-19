import LinearAlgebra
using JuMP
using GLPK

function model()

    model = Model(GLPK.Optimizer)

    # x[i, j] - flow from node i to node j
    # Warning: In this model nodes are from 1 to 2^k
    @variable(model, x[1:32, 1:32], Int)

    # Capacities of given arcs
   @constraint(model, [i = 0:31, j = 0:31; count_ones(i ⊻ j) != 1], x[i+1, j+1] == 0)
   @constraint(model, [i = 0:31, j = 0:31; i>j && count_ones(i ⊻ j) == 1], x[i+1, j+1] == 0)
   @constraint(model, x[1, 2] <= 10)
   @constraint(model, x[1, 3] <= 9)
   @constraint(model, x[1, 5] <= 20)
   @constraint(model, x[1, 9] <= 15)
   @constraint(model, x[1, 17] <= 18)
   @constraint(model, x[2, 4] <= 3)
   @constraint(model, x[2, 6] <= 11)
   @constraint(model, x[2, 10] <= 3)
   @constraint(model, x[2, 18] <= 2)
   @constraint(model, x[3, 4] <= 15)
   @constraint(model, x[3, 7] <= 11)
   @constraint(model, x[3, 11] <= 4)
   @constraint(model, x[3, 19] <= 5)
   @constraint(model, x[4, 8] <= 5)
   @constraint(model, x[4, 12] <= 5)
   @constraint(model, x[4, 20] <= 7)
   @constraint(model, x[5, 6] <= 16)
   @constraint(model, x[5, 7] <= 10)
   @constraint(model, x[5, 13] <= 7)
   @constraint(model, x[5, 21] <= 13)
   @constraint(model, x[6, 8] <= 8)
   @constraint(model, x[6, 14] <= 6)
   @constraint(model, x[6, 22] <= 2)
   @constraint(model, x[7, 8] <= 5)
   @constraint(model, x[7, 15] <= 3)
   @constraint(model, x[7, 23] <= 1)
   @constraint(model, x[8, 16] <= 11)
   @constraint(model, x[8, 24] <= 9)
   @constraint(model, x[9, 10] <= 14)
   @constraint(model, x[9, 11] <= 10)
   @constraint(model, x[9, 13] <= 1)
   @constraint(model, x[9, 25] <= 4)
   @constraint(model, x[10, 12] <= 6)
   @constraint(model, x[10, 14] <= 2)
   @constraint(model, x[10, 26] <= 6)
   @constraint(model, x[11, 12] <= 8)
   @constraint(model, x[11, 15] <= 7)
   @constraint(model, x[11, 27] <= 6)
   @constraint(model, x[12, 16] <= 1)
   @constraint(model, x[12, 28] <= 15)
   @constraint(model, x[13, 14] <= 1)
   @constraint(model, x[13, 15] <= 1)
   @constraint(model, x[13, 29] <= 5)
   @constraint(model, x[14, 16] <= 4)
   @constraint(model, x[14, 30] <= 9)
   @constraint(model, x[15, 16] <= 7)
   @constraint(model, x[15, 31] <= 16)
   @constraint(model, x[16, 32] <= 27)
   @constraint(model, x[17, 18] <= 4)
   @constraint(model, x[17, 19] <= 7)
   @constraint(model, x[17, 21] <= 3)
   @constraint(model, x[17, 25] <= 5)
   @constraint(model, x[18, 20] <= 3)
   @constraint(model, x[18, 22] <= 5)
   @constraint(model, x[18, 26] <= 5)
   @constraint(model, x[19, 20] <= 4)
   @constraint(model, x[19, 23] <= 8)
   @constraint(model, x[19, 27] <= 4)
   @constraint(model, x[20, 24] <= 6)
   @constraint(model, x[20, 28] <= 3)
   @constraint(model, x[21, 22] <= 4)
   @constraint(model, x[21, 23] <= 4)
   @constraint(model, x[21, 29] <= 2)
   @constraint(model, x[22, 24] <= 12)
   @constraint(model, x[22, 30] <= 4)
   @constraint(model, x[23, 24] <= 7)
   @constraint(model, x[23, 31] <= 13)
   @constraint(model, x[24, 32] <= 4)
   @constraint(model, x[25, 26] <= 6)
   @constraint(model, x[25, 27] <= 6)
   @constraint(model, x[25, 29] <= 7)
   @constraint(model, x[26, 28] <= 9)
   @constraint(model, x[26, 30] <= 3)
   @constraint(model, x[27, 28] <= 13)
   @constraint(model, x[27, 31] <= 16)
   @constraint(model, x[28, 32] <= 24)
   @constraint(model, x[29, 30] <= 4)
   @constraint(model, x[29, 31] <= 11)
   @constraint(model, x[30, 32] <= 7)
   @constraint(model, x[31, 32] <= 26)

    # Flow must be balanced
   @constraint(model, [i = 2:31], sum(x[i, :]) == sum(x[:, i]))
    @constraint(model, sum(x[1, :])  == sum(x[:, 32]))
    # Trying to maximize the flow
    @objective(model, Max, sum(x[1, :]))

    optimize!(model)
    println(Int64(objective_value(model)))
end

println(@elapsed model())

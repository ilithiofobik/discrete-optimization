import LinearAlgebra
using JuMP
using GLPK

function model()

    model = Model(GLPK.Optimizer)

    # x[i, j] - flow from node i to node j
    # Warning: In this model nodes are from 1 to 2^k
    @variable(model, x[1:64, 1:64], Int)

    # Capacities of given arcs
   @constraint(model, [i = 0:63, j = 0:63; count_ones(i ⊻ j) != 1], x[i+1, j+1] == 0)
   @constraint(model, [i = 0:63, j = 0:63; i>j && count_ones(i ⊻ j) == 1], x[i+1, j+1] == 0)
   @constraint(model, x[1, 2] <= 33)
   @constraint(model, x[1, 3] <= 53)
   @constraint(model, x[1, 5] <= 19)
   @constraint(model, x[1, 9] <= 5)
   @constraint(model, x[1, 17] <= 3)
   @constraint(model, x[1, 33] <= 42)
   @constraint(model, x[2, 4] <= 31)
   @constraint(model, x[2, 6] <= 12)
   @constraint(model, x[2, 10] <= 4)
   @constraint(model, x[2, 18] <= 7)
   @constraint(model, x[2, 34] <= 20)
   @constraint(model, x[3, 4] <= 11)
   @constraint(model, x[3, 7] <= 11)
   @constraint(model, x[3, 11] <= 21)
   @constraint(model, x[3, 19] <= 31)
   @constraint(model, x[3, 35] <= 20)
   @constraint(model, x[4, 8] <= 9)
   @constraint(model, x[4, 12] <= 12)
   @constraint(model, x[4, 20] <= 5)
   @constraint(model, x[4, 36] <= 16)
   @constraint(model, x[5, 6] <= 31)
   @constraint(model, x[5, 7] <= 5)
   @constraint(model, x[5, 13] <= 4)
   @constraint(model, x[5, 21] <= 32)
   @constraint(model, x[5, 37] <= 17)
   @constraint(model, x[6, 8] <= 16)
   @constraint(model, x[6, 14] <= 11)
   @constraint(model, x[6, 22] <= 4)
   @constraint(model, x[6, 38] <= 16)
   @constraint(model, x[7, 8] <= 7)
   @constraint(model, x[7, 15] <= 4)
   @constraint(model, x[7, 23] <= 7)
   @constraint(model, x[7, 39] <= 6)
   @constraint(model, x[8, 16] <= 3)
   @constraint(model, x[8, 24] <= 13)
   @constraint(model, x[8, 40] <= 3)
   @constraint(model, x[9, 10] <= 18)
   @constraint(model, x[9, 11] <= 26)
   @constraint(model, x[9, 13] <= 18)
   @constraint(model, x[9, 25] <= 19)
   @constraint(model, x[9, 41] <= 9)
   @constraint(model, x[10, 12] <= 5)
   @constraint(model, x[10, 14] <= 13)
   @constraint(model, x[10, 26] <= 12)
   @constraint(model, x[10, 42] <= 11)
   @constraint(model, x[11, 12] <= 13)
   @constraint(model, x[11, 15] <= 3)
   @constraint(model, x[11, 27] <= 10)
   @constraint(model, x[11, 43] <= 7)
   @constraint(model, x[12, 16] <= 5)
   @constraint(model, x[12, 28] <= 13)
   @constraint(model, x[12, 44] <= 5)
   @constraint(model, x[13, 14] <= 9)
   @constraint(model, x[13, 15] <= 2)
   @constraint(model, x[13, 29] <= 12)
   @constraint(model, x[13, 45] <= 13)
   @constraint(model, x[14, 16] <= 8)
   @constraint(model, x[14, 30] <= 4)
   @constraint(model, x[14, 46] <= 11)
   @constraint(model, x[15, 16] <= 9)
   @constraint(model, x[15, 31] <= 10)
   @constraint(model, x[15, 47] <= 4)
   @constraint(model, x[16, 32] <= 3)
   @constraint(model, x[16, 48] <= 29)
   @constraint(model, x[17, 18] <= 16)
   @constraint(model, x[17, 19] <= 9)
   @constraint(model, x[17, 21] <= 14)
   @constraint(model, x[17, 25] <= 5)
   @constraint(model, x[17, 49] <= 14)
   @constraint(model, x[18, 20] <= 16)
   @constraint(model, x[18, 22] <= 1)
   @constraint(model, x[18, 26] <= 7)
   @constraint(model, x[18, 50] <= 8)
   @constraint(model, x[19, 20] <= 5)
   @constraint(model, x[19, 23] <= 7)
   @constraint(model, x[19, 27] <= 4)
   @constraint(model, x[19, 51] <= 10)
   @constraint(model, x[20, 24] <= 2)
   @constraint(model, x[20, 28] <= 7)
   @constraint(model, x[20, 52] <= 5)
   @constraint(model, x[21, 22] <= 4)
   @constraint(model, x[21, 23] <= 6)
   @constraint(model, x[21, 29] <= 9)
   @constraint(model, x[21, 53] <= 8)
   @constraint(model, x[22, 24] <= 6)
   @constraint(model, x[22, 30] <= 3)
   @constraint(model, x[22, 54] <= 16)
   @constraint(model, x[23, 24] <= 14)
   @constraint(model, x[23, 31] <= 1)
   @constraint(model, x[23, 55] <= 8)
   @constraint(model, x[24, 32] <= 30)
   @constraint(model, x[24, 56] <= 11)
   @constraint(model, x[25, 26] <= 3)
   @constraint(model, x[25, 27] <= 4)
   @constraint(model, x[25, 29] <= 16)
   @constraint(model, x[25, 57] <= 7)
   @constraint(model, x[26, 28] <= 9)
   @constraint(model, x[26, 30] <= 8)
   @constraint(model, x[26, 58] <= 15)
   @constraint(model, x[27, 28] <= 3)
   @constraint(model, x[27, 31] <= 7)
   @constraint(model, x[27, 59] <= 16)
   @constraint(model, x[28, 32] <= 9)
   @constraint(model, x[28, 60] <= 6)
   @constraint(model, x[29, 30] <= 9)
   @constraint(model, x[29, 31] <= 7)
   @constraint(model, x[29, 61] <= 5)
   @constraint(model, x[30, 32] <= 1)
   @constraint(model, x[30, 62] <= 28)
   @constraint(model, x[31, 32] <= 27)
   @constraint(model, x[31, 63] <= 20)
   @constraint(model, x[32, 64] <= 50)
   @constraint(model, x[33, 34] <= 11)
   @constraint(model, x[33, 35] <= 17)
   @constraint(model, x[33, 37] <= 16)
   @constraint(model, x[33, 41] <= 12)
   @constraint(model, x[33, 49] <= 24)
   @constraint(model, x[34, 36] <= 4)
   @constraint(model, x[34, 38] <= 4)
   @constraint(model, x[34, 42] <= 14)
   @constraint(model, x[34, 50] <= 3)
   @constraint(model, x[35, 36] <= 10)
   @constraint(model, x[35, 39] <= 5)
   @constraint(model, x[35, 43] <= 4)
   @constraint(model, x[35, 51] <= 9)
   @constraint(model, x[36, 40] <= 15)
   @constraint(model, x[36, 44] <= 2)
   @constraint(model, x[36, 52] <= 9)
   @constraint(model, x[37, 38] <= 1)
   @constraint(model, x[37, 39] <= 1)
   @constraint(model, x[37, 45] <= 7)
   @constraint(model, x[37, 53] <= 9)
   @constraint(model, x[38, 40] <= 11)
   @constraint(model, x[38, 46] <= 13)
   @constraint(model, x[38, 54] <= 6)
   @constraint(model, x[39, 40] <= 8)
   @constraint(model, x[39, 47] <= 6)
   @constraint(model, x[39, 55] <= 14)
   @constraint(model, x[40, 48] <= 19)
   @constraint(model, x[40, 56] <= 20)
   @constraint(model, x[41, 42] <= 6)
   @constraint(model, x[41, 43] <= 7)
   @constraint(model, x[41, 45] <= 13)
   @constraint(model, x[41, 57] <= 13)
   @constraint(model, x[42, 44] <= 15)
   @constraint(model, x[42, 46] <= 14)
   @constraint(model, x[42, 58] <= 1)
   @constraint(model, x[43, 44] <= 1)
   @constraint(model, x[43, 47] <= 7)
   @constraint(model, x[43, 59] <= 10)
   @constraint(model, x[44, 48] <= 12)
   @constraint(model, x[44, 60] <= 24)
   @constraint(model, x[45, 46] <= 4)
   @constraint(model, x[45, 47] <= 4)
   @constraint(model, x[45, 61] <= 13)
   @constraint(model, x[46, 48] <= 8)
   @constraint(model, x[46, 62] <= 7)
   @constraint(model, x[47, 48] <= 27)
   @constraint(model, x[47, 63] <= 3)
   @constraint(model, x[48, 64] <= 55)
   @constraint(model, x[49, 50] <= 3)
   @constraint(model, x[49, 51] <= 5)
   @constraint(model, x[49, 53] <= 5)
   @constraint(model, x[49, 57] <= 3)
   @constraint(model, x[50, 52] <= 1)
   @constraint(model, x[50, 54] <= 4)
   @constraint(model, x[50, 58] <= 13)
   @constraint(model, x[51, 52] <= 13)
   @constraint(model, x[51, 55] <= 6)
   @constraint(model, x[51, 59] <= 1)
   @constraint(model, x[52, 56] <= 12)
   @constraint(model, x[52, 60] <= 21)
   @constraint(model, x[53, 54] <= 3)
   @constraint(model, x[53, 55] <= 4)
   @constraint(model, x[53, 61] <= 10)
   @constraint(model, x[54, 56] <= 22)
   @constraint(model, x[54, 62] <= 27)
   @constraint(model, x[55, 56] <= 3)
   @constraint(model, x[55, 63] <= 7)
   @constraint(model, x[56, 64] <= 43)
   @constraint(model, x[57, 58] <= 15)
   @constraint(model, x[57, 59] <= 1)
   @constraint(model, x[57, 61] <= 3)
   @constraint(model, x[58, 60] <= 21)
   @constraint(model, x[58, 62] <= 25)
   @constraint(model, x[59, 60] <= 10)
   @constraint(model, x[59, 63] <= 7)
   @constraint(model, x[60, 64] <= 50)
   @constraint(model, x[61, 62] <= 2)
   @constraint(model, x[61, 63] <= 12)
   @constraint(model, x[62, 64] <= 17)
   @constraint(model, x[63, 64] <= 24)

    # Flow must be balanced
   @constraint(model, [i = 2:63], sum(x[i, :]) == sum(x[:, i]))
    @constraint(model, sum(x[1, :])  == sum(x[:, 64]))
    # Trying to maximize the flow
    @objective(model, Max, sum(x[1, :]))

    optimize!(model)
    println(Int64(objective_value(model)))
end

println(@elapsed model())
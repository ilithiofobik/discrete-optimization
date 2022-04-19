import LinearAlgebra
using JuMP
using GLPK

function model()

    model = Model(GLPK.Optimizer)

    # x[i, j] - flow from node i to node j
    # Warning: In this model nodes are from 1 to 2^k
    @variable(model, x[1:128, 1:128], Int)

    # Capacities of given arcs
   @constraint(model, [i = 0:127, j = 0:127; count_ones(i ⊻ j) != 1], x[i+1, j+1] == 0)
   @constraint(model, [i = 0:127, j = 0:127; i>j && count_ones(i ⊻ j) == 1], x[i+1, j+1] == 0)
   @constraint(model, x[1, 2] <= 2)
   @constraint(model, x[1, 3] <= 71)
   @constraint(model, x[1, 5] <= 28)
   @constraint(model, x[1, 9] <= 113)
   @constraint(model, x[1, 17] <= 43)
   @constraint(model, x[1, 33] <= 62)
   @constraint(model, x[1, 65] <= 62)
   @constraint(model, x[2, 4] <= 61)
   @constraint(model, x[2, 6] <= 24)
   @constraint(model, x[2, 10] <= 18)
   @constraint(model, x[2, 18] <= 26)
   @constraint(model, x[2, 34] <= 32)
   @constraint(model, x[2, 66] <= 49)
   @constraint(model, x[3, 4] <= 56)
   @constraint(model, x[3, 7] <= 55)
   @constraint(model, x[3, 11] <= 1)
   @constraint(model, x[3, 19] <= 43)
   @constraint(model, x[3, 35] <= 12)
   @constraint(model, x[3, 67] <= 56)
   @constraint(model, x[4, 8] <= 22)
   @constraint(model, x[4, 12] <= 10)
   @constraint(model, x[4, 20] <= 18)
   @constraint(model, x[4, 36] <= 7)
   @constraint(model, x[4, 68] <= 29)
   @constraint(model, x[5, 6] <= 11)
   @constraint(model, x[5, 7] <= 43)
   @constraint(model, x[5, 13] <= 16)
   @constraint(model, x[5, 21] <= 57)
   @constraint(model, x[5, 37] <= 27)
   @constraint(model, x[5, 69] <= 17)
   @constraint(model, x[6, 8] <= 25)
   @constraint(model, x[6, 14] <= 20)
   @constraint(model, x[6, 22] <= 2)
   @constraint(model, x[6, 38] <= 17)
   @constraint(model, x[6, 70] <= 16)
   @constraint(model, x[7, 8] <= 3)
   @constraint(model, x[7, 15] <= 10)
   @constraint(model, x[7, 23] <= 7)
   @constraint(model, x[7, 39] <= 19)
   @constraint(model, x[7, 71] <= 7)
   @constraint(model, x[8, 16] <= 11)
   @constraint(model, x[8, 24] <= 15)
   @constraint(model, x[8, 40] <= 4)
   @constraint(model, x[8, 72] <= 6)
   @constraint(model, x[9, 10] <= 27)
   @constraint(model, x[9, 11] <= 59)
   @constraint(model, x[9, 13] <= 32)
   @constraint(model, x[9, 25] <= 55)
   @constraint(model, x[9, 41] <= 45)
   @constraint(model, x[9, 73] <= 9)
   @constraint(model, x[10, 12] <= 24)
   @constraint(model, x[10, 14] <= 5)
   @constraint(model, x[10, 26] <= 8)
   @constraint(model, x[10, 42] <= 18)
   @constraint(model, x[10, 74] <= 1)
   @constraint(model, x[11, 12] <= 3)
   @constraint(model, x[11, 15] <= 2)
   @constraint(model, x[11, 27] <= 3)
   @constraint(model, x[11, 43] <= 31)
   @constraint(model, x[11, 75] <= 19)
   @constraint(model, x[12, 16] <= 16)
   @constraint(model, x[12, 28] <= 8)
   @constraint(model, x[12, 44] <= 10)
   @constraint(model, x[12, 76] <= 1)
   @constraint(model, x[13, 14] <= 26)
   @constraint(model, x[13, 15] <= 21)
   @constraint(model, x[13, 29] <= 10)
   @constraint(model, x[13, 45] <= 18)
   @constraint(model, x[13, 77] <= 10)
   @constraint(model, x[14, 16] <= 15)
   @constraint(model, x[14, 30] <= 4)
   @constraint(model, x[14, 46] <= 11)
   @constraint(model, x[14, 78] <= 4)
   @constraint(model, x[15, 16] <= 2)
   @constraint(model, x[15, 31] <= 12)
   @constraint(model, x[15, 47] <= 16)
   @constraint(model, x[15, 79] <= 6)
   @constraint(model, x[16, 32] <= 31)
   @constraint(model, x[16, 48] <= 30)
   @constraint(model, x[16, 80] <= 31)
   @constraint(model, x[17, 18] <= 64)
   @constraint(model, x[17, 19] <= 14)
   @constraint(model, x[17, 21] <= 3)
   @constraint(model, x[17, 25] <= 49)
   @constraint(model, x[17, 49] <= 11)
   @constraint(model, x[17, 81] <= 43)
   @constraint(model, x[18, 20] <= 7)
   @constraint(model, x[18, 22] <= 7)
   @constraint(model, x[18, 26] <= 13)
   @constraint(model, x[18, 50] <= 30)
   @constraint(model, x[18, 82] <= 29)
   @constraint(model, x[19, 20] <= 9)
   @constraint(model, x[19, 23] <= 16)
   @constraint(model, x[19, 27] <= 20)
   @constraint(model, x[19, 51] <= 30)
   @constraint(model, x[19, 83] <= 14)
   @constraint(model, x[20, 24] <= 11)
   @constraint(model, x[20, 28] <= 1)
   @constraint(model, x[20, 52] <= 2)
   @constraint(model, x[20, 84] <= 13)
   @constraint(model, x[21, 22] <= 17)
   @constraint(model, x[21, 23] <= 19)
   @constraint(model, x[21, 29] <= 21)
   @constraint(model, x[21, 53] <= 1)
   @constraint(model, x[21, 85] <= 22)
   @constraint(model, x[22, 24] <= 10)
   @constraint(model, x[22, 30] <= 14)
   @constraint(model, x[22, 54] <= 3)
   @constraint(model, x[22, 86] <= 16)
   @constraint(model, x[23, 24] <= 8)
   @constraint(model, x[23, 31] <= 15)
   @constraint(model, x[23, 55] <= 15)
   @constraint(model, x[23, 87] <= 10)
   @constraint(model, x[24, 32] <= 29)
   @constraint(model, x[24, 56] <= 13)
   @constraint(model, x[24, 88] <= 20)
   @constraint(model, x[25, 26] <= 17)
   @constraint(model, x[25, 27] <= 2)
   @constraint(model, x[25, 29] <= 4)
   @constraint(model, x[25, 57] <= 21)
   @constraint(model, x[25, 89] <= 7)
   @constraint(model, x[26, 28] <= 12)
   @constraint(model, x[26, 30] <= 14)
   @constraint(model, x[26, 58] <= 11)
   @constraint(model, x[26, 90] <= 11)
   @constraint(model, x[27, 28] <= 4)
   @constraint(model, x[27, 31] <= 1)
   @constraint(model, x[27, 59] <= 11)
   @constraint(model, x[27, 91] <= 8)
   @constraint(model, x[28, 32] <= 28)
   @constraint(model, x[28, 60] <= 24)
   @constraint(model, x[28, 92] <= 1)
   @constraint(model, x[29, 30] <= 4)
   @constraint(model, x[29, 31] <= 7)
   @constraint(model, x[29, 61] <= 12)
   @constraint(model, x[29, 93] <= 4)
   @constraint(model, x[30, 32] <= 22)
   @constraint(model, x[30, 62] <= 27)
   @constraint(model, x[30, 94] <= 32)
   @constraint(model, x[31, 32] <= 5)
   @constraint(model, x[31, 63] <= 9)
   @constraint(model, x[31, 95] <= 7)
   @constraint(model, x[32, 64] <= 61)
   @constraint(model, x[32, 96] <= 8)
   @constraint(model, x[33, 34] <= 51)
   @constraint(model, x[33, 35] <= 57)
   @constraint(model, x[33, 37] <= 8)
   @constraint(model, x[33, 41] <= 59)
   @constraint(model, x[33, 49] <= 29)
   @constraint(model, x[33, 97] <= 53)
   @constraint(model, x[34, 36] <= 21)
   @constraint(model, x[34, 38] <= 21)
   @constraint(model, x[34, 42] <= 14)
   @constraint(model, x[34, 50] <= 31)
   @constraint(model, x[34, 98] <= 20)
   @constraint(model, x[35, 36] <= 32)
   @constraint(model, x[35, 39] <= 31)
   @constraint(model, x[35, 43] <= 24)
   @constraint(model, x[35, 51] <= 8)
   @constraint(model, x[35, 99] <= 8)
   @constraint(model, x[36, 40] <= 14)
   @constraint(model, x[36, 44] <= 8)
   @constraint(model, x[36, 52] <= 5)
   @constraint(model, x[36, 100] <= 4)
   @constraint(model, x[37, 38] <= 32)
   @constraint(model, x[37, 39] <= 21)
   @constraint(model, x[37, 45] <= 3)
   @constraint(model, x[37, 53] <= 24)
   @constraint(model, x[37, 101] <= 22)
   @constraint(model, x[38, 40] <= 16)
   @constraint(model, x[38, 46] <= 4)
   @constraint(model, x[38, 54] <= 9)
   @constraint(model, x[38, 102] <= 8)
   @constraint(model, x[39, 40] <= 2)
   @constraint(model, x[39, 47] <= 9)
   @constraint(model, x[39, 55] <= 2)
   @constraint(model, x[39, 103] <= 3)
   @constraint(model, x[40, 48] <= 14)
   @constraint(model, x[40, 56] <= 18)
   @constraint(model, x[40, 104] <= 11)
   @constraint(model, x[41, 42] <= 12)
   @constraint(model, x[41, 43] <= 1)
   @constraint(model, x[41, 45] <= 10)
   @constraint(model, x[41, 57] <= 15)
   @constraint(model, x[41, 105] <= 31)
   @constraint(model, x[42, 44] <= 14)
   @constraint(model, x[42, 46] <= 1)
   @constraint(model, x[42, 58] <= 9)
   @constraint(model, x[42, 106] <= 16)
   @constraint(model, x[43, 44] <= 15)
   @constraint(model, x[43, 47] <= 15)
   @constraint(model, x[43, 59] <= 1)
   @constraint(model, x[43, 107] <= 3)
   @constraint(model, x[44, 48] <= 18)
   @constraint(model, x[44, 60] <= 8)
   @constraint(model, x[44, 108] <= 25)
   @constraint(model, x[45, 46] <= 15)
   @constraint(model, x[45, 47] <= 1)
   @constraint(model, x[45, 61] <= 1)
   @constraint(model, x[45, 109] <= 10)
   @constraint(model, x[46, 48] <= 26)
   @constraint(model, x[46, 62] <= 31)
   @constraint(model, x[46, 110] <= 5)
   @constraint(model, x[47, 48] <= 27)
   @constraint(model, x[47, 63] <= 14)
   @constraint(model, x[47, 111] <= 2)
   @constraint(model, x[48, 64] <= 42)
   @constraint(model, x[48, 112] <= 55)
   @constraint(model, x[49, 50] <= 7)
   @constraint(model, x[49, 51] <= 30)
   @constraint(model, x[49, 53] <= 2)
   @constraint(model, x[49, 57] <= 30)
   @constraint(model, x[49, 113] <= 27)
   @constraint(model, x[50, 52] <= 13)
   @constraint(model, x[50, 54] <= 13)
   @constraint(model, x[50, 58] <= 2)
   @constraint(model, x[50, 114] <= 13)
   @constraint(model, x[51, 52] <= 12)
   @constraint(model, x[51, 55] <= 10)
   @constraint(model, x[51, 59] <= 16)
   @constraint(model, x[51, 115] <= 15)
   @constraint(model, x[52, 56] <= 24)
   @constraint(model, x[52, 60] <= 1)
   @constraint(model, x[52, 116] <= 8)
   @constraint(model, x[53, 54] <= 4)
   @constraint(model, x[53, 55] <= 13)
   @constraint(model, x[53, 61] <= 12)
   @constraint(model, x[53, 117] <= 3)
   @constraint(model, x[54, 56] <= 21)
   @constraint(model, x[54, 62] <= 24)
   @constraint(model, x[54, 118] <= 16)
   @constraint(model, x[55, 56] <= 29)
   @constraint(model, x[55, 63] <= 10)
   @constraint(model, x[55, 119] <= 11)
   @constraint(model, x[56, 64] <= 53)
   @constraint(model, x[56, 120] <= 63)
   @constraint(model, x[57, 58] <= 1)
   @constraint(model, x[57, 59] <= 1)
   @constraint(model, x[57, 61] <= 4)
   @constraint(model, x[57, 121] <= 9)
   @constraint(model, x[58, 60] <= 32)
   @constraint(model, x[58, 62] <= 20)
   @constraint(model, x[58, 122] <= 23)
   @constraint(model, x[59, 60] <= 11)
   @constraint(model, x[59, 63] <= 9)
   @constraint(model, x[59, 123] <= 30)
   @constraint(model, x[60, 64] <= 54)
   @constraint(model, x[60, 124] <= 3)
   @constraint(model, x[61, 62] <= 5)
   @constraint(model, x[61, 63] <= 15)
   @constraint(model, x[61, 125] <= 25)
   @constraint(model, x[62, 64] <= 29)
   @constraint(model, x[62, 126] <= 50)
   @constraint(model, x[63, 64] <= 26)
   @constraint(model, x[63, 127] <= 6)
   @constraint(model, x[64, 128] <= 8)
   @constraint(model, x[65, 66] <= 9)
   @constraint(model, x[65, 67] <= 4)
   @constraint(model, x[65, 69] <= 64)
   @constraint(model, x[65, 73] <= 47)
   @constraint(model, x[65, 81] <= 24)
   @constraint(model, x[65, 97] <= 40)
   @constraint(model, x[66, 68] <= 28)
   @constraint(model, x[66, 70] <= 9)
   @constraint(model, x[66, 74] <= 24)
   @constraint(model, x[66, 82] <= 10)
   @constraint(model, x[66, 98] <= 9)
   @constraint(model, x[67, 68] <= 8)
   @constraint(model, x[67, 71] <= 29)
   @constraint(model, x[67, 75] <= 15)
   @constraint(model, x[67, 83] <= 14)
   @constraint(model, x[67, 99] <= 28)
   @constraint(model, x[68, 72] <= 16)
   @constraint(model, x[68, 76] <= 8)
   @constraint(model, x[68, 84] <= 9)
   @constraint(model, x[68, 100] <= 13)
   @constraint(model, x[69, 70] <= 5)
   @constraint(model, x[69, 71] <= 28)
   @constraint(model, x[69, 77] <= 30)
   @constraint(model, x[69, 85] <= 14)
   @constraint(model, x[69, 101] <= 19)
   @constraint(model, x[70, 72] <= 5)
   @constraint(model, x[70, 78] <= 1)
   @constraint(model, x[70, 86] <= 7)
   @constraint(model, x[70, 102] <= 13)
   @constraint(model, x[71, 72] <= 4)
   @constraint(model, x[71, 79] <= 7)
   @constraint(model, x[71, 87] <= 11)
   @constraint(model, x[71, 103] <= 9)
   @constraint(model, x[72, 80] <= 2)
   @constraint(model, x[72, 88] <= 4)
   @constraint(model, x[72, 104] <= 30)
   @constraint(model, x[73, 74] <= 11)
   @constraint(model, x[73, 75] <= 20)
   @constraint(model, x[73, 77] <= 25)
   @constraint(model, x[73, 89] <= 19)
   @constraint(model, x[73, 105] <= 29)
   @constraint(model, x[74, 76] <= 12)
   @constraint(model, x[74, 78] <= 11)
   @constraint(model, x[74, 90] <= 2)
   @constraint(model, x[74, 106] <= 11)
   @constraint(model, x[75, 76] <= 1)
   @constraint(model, x[75, 79] <= 16)
   @constraint(model, x[75, 91] <= 8)
   @constraint(model, x[75, 107] <= 9)
   @constraint(model, x[76, 80] <= 30)
   @constraint(model, x[76, 92] <= 9)
   @constraint(model, x[76, 108] <= 11)
   @constraint(model, x[77, 78] <= 15)
   @constraint(model, x[77, 79] <= 8)
   @constraint(model, x[77, 93] <= 2)
   @constraint(model, x[77, 109] <= 5)
   @constraint(model, x[78, 80] <= 14)
   @constraint(model, x[78, 94] <= 9)
   @constraint(model, x[78, 110] <= 29)
   @constraint(model, x[79, 80] <= 2)
   @constraint(model, x[79, 95] <= 30)
   @constraint(model, x[79, 111] <= 20)
   @constraint(model, x[80, 96] <= 27)
   @constraint(model, x[80, 112] <= 1)
   @constraint(model, x[81, 82] <= 12)
   @constraint(model, x[81, 83] <= 17)
   @constraint(model, x[81, 85] <= 16)
   @constraint(model, x[81, 89] <= 4)
   @constraint(model, x[81, 113] <= 5)
   @constraint(model, x[82, 84] <= 10)
   @constraint(model, x[82, 86] <= 4)
   @constraint(model, x[82, 90] <= 12)
   @constraint(model, x[82, 114] <= 5)
   @constraint(model, x[83, 84] <= 10)
   @constraint(model, x[83, 87] <= 15)
   @constraint(model, x[83, 91] <= 6)
   @constraint(model, x[83, 115] <= 4)
   @constraint(model, x[84, 88] <= 1)
   @constraint(model, x[84, 92] <= 32)
   @constraint(model, x[84, 116] <= 10)
   @constraint(model, x[85, 86] <= 3)
   @constraint(model, x[85, 87] <= 7)
   @constraint(model, x[85, 93] <= 7)
   @constraint(model, x[85, 117] <= 10)
   @constraint(model, x[86, 88] <= 17)
   @constraint(model, x[86, 94] <= 19)
   @constraint(model, x[86, 118] <= 1)
   @constraint(model, x[87, 88] <= 30)
   @constraint(model, x[87, 95] <= 5)
   @constraint(model, x[87, 119] <= 9)
   @constraint(model, x[88, 96] <= 37)
   @constraint(model, x[88, 120] <= 7)
   @constraint(model, x[89, 90] <= 13)
   @constraint(model, x[89, 91] <= 16)
   @constraint(model, x[89, 93] <= 8)
   @constraint(model, x[89, 121] <= 14)
   @constraint(model, x[90, 92] <= 10)
   @constraint(model, x[90, 94] <= 10)
   @constraint(model, x[90, 122] <= 20)
   @constraint(model, x[91, 92] <= 4)
   @constraint(model, x[91, 95] <= 29)
   @constraint(model, x[91, 123] <= 3)
   @constraint(model, x[92, 96] <= 14)
   @constraint(model, x[92, 124] <= 9)
   @constraint(model, x[93, 94] <= 29)
   @constraint(model, x[93, 95] <= 8)
   @constraint(model, x[93, 125] <= 30)
   @constraint(model, x[94, 96] <= 54)
   @constraint(model, x[94, 126] <= 54)
   @constraint(model, x[95, 96] <= 30)
   @constraint(model, x[95, 127] <= 36)
   @constraint(model, x[96, 128] <= 96)
   @constraint(model, x[97, 98] <= 27)
   @constraint(model, x[97, 99] <= 32)
   @constraint(model, x[97, 101] <= 15)
   @constraint(model, x[97, 105] <= 21)
   @constraint(model, x[97, 113] <= 22)
   @constraint(model, x[98, 100] <= 6)
   @constraint(model, x[98, 102] <= 4)
   @constraint(model, x[98, 106] <= 12)
   @constraint(model, x[98, 114] <= 11)
   @constraint(model, x[99, 100] <= 5)
   @constraint(model, x[99, 103] <= 8)
   @constraint(model, x[99, 107] <= 14)
   @constraint(model, x[99, 115] <= 15)
   @constraint(model, x[100, 104] <= 12)
   @constraint(model, x[100, 108] <= 16)
   @constraint(model, x[100, 116] <= 5)
   @constraint(model, x[101, 102] <= 15)
   @constraint(model, x[101, 103] <= 1)
   @constraint(model, x[101, 109] <= 3)
   @constraint(model, x[101, 117] <= 3)
   @constraint(model, x[102, 104] <= 29)
   @constraint(model, x[102, 110] <= 16)
   @constraint(model, x[102, 118] <= 14)
   @constraint(model, x[103, 104] <= 14)
   @constraint(model, x[103, 111] <= 19)
   @constraint(model, x[103, 119] <= 13)
   @constraint(model, x[104, 112] <= 36)
   @constraint(model, x[104, 120] <= 38)
   @constraint(model, x[105, 106] <= 6)
   @constraint(model, x[105, 107] <= 13)
   @constraint(model, x[105, 109] <= 9)
   @constraint(model, x[105, 121] <= 14)
   @constraint(model, x[106, 108] <= 16)
   @constraint(model, x[106, 110] <= 7)
   @constraint(model, x[106, 122] <= 22)
   @constraint(model, x[107, 108] <= 25)
   @constraint(model, x[107, 111] <= 13)
   @constraint(model, x[107, 123] <= 18)
   @constraint(model, x[108, 112] <= 14)
   @constraint(model, x[108, 124] <= 13)
   @constraint(model, x[109, 110] <= 4)
   @constraint(model, x[109, 111] <= 12)
   @constraint(model, x[109, 125] <= 6)
   @constraint(model, x[110, 112] <= 18)
   @constraint(model, x[110, 126] <= 48)
   @constraint(model, x[111, 112] <= 20)
   @constraint(model, x[111, 127] <= 21)
   @constraint(model, x[112, 128] <= 114)
   @constraint(model, x[113, 114] <= 11)
   @constraint(model, x[113, 115] <= 12)
   @constraint(model, x[113, 117] <= 7)
   @constraint(model, x[113, 121] <= 2)
   @constraint(model, x[114, 116] <= 19)
   @constraint(model, x[114, 118] <= 24)
   @constraint(model, x[114, 122] <= 29)
   @constraint(model, x[115, 116] <= 31)
   @constraint(model, x[115, 119] <= 31)
   @constraint(model, x[115, 123] <= 17)
   @constraint(model, x[116, 120] <= 26)
   @constraint(model, x[116, 124] <= 12)
   @constraint(model, x[117, 118] <= 8)
   @constraint(model, x[117, 119] <= 11)
   @constraint(model, x[117, 125] <= 12)
   @constraint(model, x[118, 120] <= 8)
   @constraint(model, x[118, 126] <= 35)
   @constraint(model, x[119, 120] <= 42)
   @constraint(model, x[119, 127] <= 28)
   @constraint(model, x[120, 128] <= 73)
   @constraint(model, x[121, 122] <= 30)
   @constraint(model, x[121, 123] <= 29)
   @constraint(model, x[121, 125] <= 3)
   @constraint(model, x[122, 124] <= 53)
   @constraint(model, x[122, 126] <= 12)
   @constraint(model, x[123, 124] <= 27)
   @constraint(model, x[123, 127] <= 38)
   @constraint(model, x[124, 128] <= 71)
   @constraint(model, x[125, 126] <= 23)
   @constraint(model, x[125, 127] <= 10)
   @constraint(model, x[126, 128] <= 1)
   @constraint(model, x[127, 128] <= 124)

    # Flow must be balanced
   @constraint(model, [i = 2:127], sum(x[i, :]) == sum(x[:, i]))
    @constraint(model, sum(x[1, :])  == sum(x[:, 128]))
    # Trying to maximize the flow
    @objective(model, Max, sum(x[1, :]))

    optimize!(model)
    println(Int64(objective_value(model)))
end

println(@elapsed model())
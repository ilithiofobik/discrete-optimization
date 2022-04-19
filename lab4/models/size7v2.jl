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
   @constraint(model, x[1, 2] <= 89)
   @constraint(model, x[1, 3] <= 14)
   @constraint(model, x[1, 5] <= 72)
   @constraint(model, x[1, 9] <= 126)
   @constraint(model, x[1, 17] <= 108)
   @constraint(model, x[1, 33] <= 57)
   @constraint(model, x[1, 65] <= 44)
   @constraint(model, x[2, 4] <= 48)
   @constraint(model, x[2, 6] <= 9)
   @constraint(model, x[2, 10] <= 55)
   @constraint(model, x[2, 18] <= 27)
   @constraint(model, x[2, 34] <= 22)
   @constraint(model, x[2, 66] <= 55)
   @constraint(model, x[3, 4] <= 33)
   @constraint(model, x[3, 7] <= 17)
   @constraint(model, x[3, 11] <= 13)
   @constraint(model, x[3, 19] <= 15)
   @constraint(model, x[3, 35] <= 55)
   @constraint(model, x[3, 67] <= 57)
   @constraint(model, x[4, 8] <= 27)
   @constraint(model, x[4, 12] <= 32)
   @constraint(model, x[4, 20] <= 27)
   @constraint(model, x[4, 36] <= 22)
   @constraint(model, x[4, 68] <= 19)
   @constraint(model, x[5, 6] <= 21)
   @constraint(model, x[5, 7] <= 17)
   @constraint(model, x[5, 13] <= 29)
   @constraint(model, x[5, 21] <= 27)
   @constraint(model, x[5, 37] <= 58)
   @constraint(model, x[5, 69] <= 20)
   @constraint(model, x[6, 8] <= 17)
   @constraint(model, x[6, 14] <= 3)
   @constraint(model, x[6, 22] <= 22)
   @constraint(model, x[6, 38] <= 18)
   @constraint(model, x[6, 70] <= 6)
   @constraint(model, x[7, 8] <= 25)
   @constraint(model, x[7, 15] <= 27)
   @constraint(model, x[7, 23] <= 10)
   @constraint(model, x[7, 39] <= 29)
   @constraint(model, x[7, 71] <= 15)
   @constraint(model, x[8, 16] <= 3)
   @constraint(model, x[8, 24] <= 8)
   @constraint(model, x[8, 40] <= 4)
   @constraint(model, x[8, 72] <= 6)
   @constraint(model, x[9, 10] <= 51)
   @constraint(model, x[9, 11] <= 39)
   @constraint(model, x[9, 13] <= 33)
   @constraint(model, x[9, 25] <= 11)
   @constraint(model, x[9, 41] <= 61)
   @constraint(model, x[9, 73] <= 13)
   @constraint(model, x[10, 12] <= 16)
   @constraint(model, x[10, 14] <= 12)
   @constraint(model, x[10, 26] <= 12)
   @constraint(model, x[10, 42] <= 7)
   @constraint(model, x[10, 74] <= 28)
   @constraint(model, x[11, 12] <= 19)
   @constraint(model, x[11, 15] <= 9)
   @constraint(model, x[11, 27] <= 2)
   @constraint(model, x[11, 43] <= 32)
   @constraint(model, x[11, 75] <= 29)
   @constraint(model, x[12, 16] <= 1)
   @constraint(model, x[12, 28] <= 10)
   @constraint(model, x[12, 44] <= 10)
   @constraint(model, x[12, 76] <= 10)
   @constraint(model, x[13, 14] <= 17)
   @constraint(model, x[13, 15] <= 8)
   @constraint(model, x[13, 29] <= 19)
   @constraint(model, x[13, 45] <= 12)
   @constraint(model, x[13, 77] <= 31)
   @constraint(model, x[14, 16] <= 9)
   @constraint(model, x[14, 30] <= 11)
   @constraint(model, x[14, 46] <= 2)
   @constraint(model, x[14, 78] <= 6)
   @constraint(model, x[15, 16] <= 4)
   @constraint(model, x[15, 31] <= 11)
   @constraint(model, x[15, 47] <= 10)
   @constraint(model, x[15, 79] <= 9)
   @constraint(model, x[16, 32] <= 7)
   @constraint(model, x[16, 48] <= 2)
   @constraint(model, x[16, 80] <= 12)
   @constraint(model, x[17, 18] <= 34)
   @constraint(model, x[17, 19] <= 8)
   @constraint(model, x[17, 21] <= 39)
   @constraint(model, x[17, 25] <= 56)
   @constraint(model, x[17, 49] <= 45)
   @constraint(model, x[17, 81] <= 9)
   @constraint(model, x[18, 20] <= 6)
   @constraint(model, x[18, 22] <= 25)
   @constraint(model, x[18, 26] <= 19)
   @constraint(model, x[18, 50] <= 26)
   @constraint(model, x[18, 82] <= 15)
   @constraint(model, x[19, 20] <= 29)
   @constraint(model, x[19, 23] <= 25)
   @constraint(model, x[19, 27] <= 19)
   @constraint(model, x[19, 51] <= 12)
   @constraint(model, x[19, 83] <= 24)
   @constraint(model, x[20, 24] <= 12)
   @constraint(model, x[20, 28] <= 9)
   @constraint(model, x[20, 52] <= 1)
   @constraint(model, x[20, 84] <= 16)
   @constraint(model, x[21, 22] <= 1)
   @constraint(model, x[21, 23] <= 20)
   @constraint(model, x[21, 29] <= 32)
   @constraint(model, x[21, 53] <= 19)
   @constraint(model, x[21, 85] <= 13)
   @constraint(model, x[22, 24] <= 10)
   @constraint(model, x[22, 30] <= 3)
   @constraint(model, x[22, 54] <= 12)
   @constraint(model, x[22, 86] <= 3)
   @constraint(model, x[23, 24] <= 1)
   @constraint(model, x[23, 31] <= 15)
   @constraint(model, x[23, 55] <= 3)
   @constraint(model, x[23, 87] <= 15)
   @constraint(model, x[24, 32] <= 8)
   @constraint(model, x[24, 56] <= 8)
   @constraint(model, x[24, 88] <= 26)
   @constraint(model, x[25, 26] <= 19)
   @constraint(model, x[25, 27] <= 17)
   @constraint(model, x[25, 29] <= 29)
   @constraint(model, x[25, 57] <= 5)
   @constraint(model, x[25, 89] <= 13)
   @constraint(model, x[26, 28] <= 12)
   @constraint(model, x[26, 30] <= 11)
   @constraint(model, x[26, 58] <= 2)
   @constraint(model, x[26, 90] <= 11)
   @constraint(model, x[27, 28] <= 9)
   @constraint(model, x[27, 31] <= 1)
   @constraint(model, x[27, 59] <= 7)
   @constraint(model, x[27, 91] <= 3)
   @constraint(model, x[28, 32] <= 28)
   @constraint(model, x[28, 60] <= 27)
   @constraint(model, x[28, 92] <= 20)
   @constraint(model, x[29, 30] <= 11)
   @constraint(model, x[29, 31] <= 4)
   @constraint(model, x[29, 61] <= 11)
   @constraint(model, x[29, 93] <= 7)
   @constraint(model, x[30, 32] <= 5)
   @constraint(model, x[30, 62] <= 12)
   @constraint(model, x[30, 94] <= 18)
   @constraint(model, x[31, 32] <= 7)
   @constraint(model, x[31, 63] <= 20)
   @constraint(model, x[31, 95] <= 11)
   @constraint(model, x[32, 64] <= 3)
   @constraint(model, x[32, 96] <= 32)
   @constraint(model, x[33, 34] <= 63)
   @constraint(model, x[33, 35] <= 59)
   @constraint(model, x[33, 37] <= 47)
   @constraint(model, x[33, 41] <= 1)
   @constraint(model, x[33, 49] <= 64)
   @constraint(model, x[33, 97] <= 21)
   @constraint(model, x[34, 36] <= 21)
   @constraint(model, x[34, 38] <= 16)
   @constraint(model, x[34, 42] <= 17)
   @constraint(model, x[34, 50] <= 14)
   @constraint(model, x[34, 98] <= 29)
   @constraint(model, x[35, 36] <= 20)
   @constraint(model, x[35, 39] <= 7)
   @constraint(model, x[35, 43] <= 13)
   @constraint(model, x[35, 51] <= 21)
   @constraint(model, x[35, 99] <= 15)
   @constraint(model, x[36, 40] <= 13)
   @constraint(model, x[36, 44] <= 4)
   @constraint(model, x[36, 52] <= 8)
   @constraint(model, x[36, 100] <= 11)
   @constraint(model, x[37, 38] <= 11)
   @constraint(model, x[37, 39] <= 20)
   @constraint(model, x[37, 45] <= 13)
   @constraint(model, x[37, 53] <= 6)
   @constraint(model, x[37, 101] <= 9)
   @constraint(model, x[38, 40] <= 7)
   @constraint(model, x[38, 46] <= 7)
   @constraint(model, x[38, 54] <= 7)
   @constraint(model, x[38, 102] <= 8)
   @constraint(model, x[39, 40] <= 8)
   @constraint(model, x[39, 47] <= 5)
   @constraint(model, x[39, 55] <= 10)
   @constraint(model, x[39, 103] <= 9)
   @constraint(model, x[40, 48] <= 11)
   @constraint(model, x[40, 56] <= 3)
   @constraint(model, x[40, 104] <= 19)
   @constraint(model, x[41, 42] <= 7)
   @constraint(model, x[41, 43] <= 30)
   @constraint(model, x[41, 45] <= 22)
   @constraint(model, x[41, 57] <= 7)
   @constraint(model, x[41, 105] <= 26)
   @constraint(model, x[42, 44] <= 14)
   @constraint(model, x[42, 46] <= 2)
   @constraint(model, x[42, 58] <= 1)
   @constraint(model, x[42, 106] <= 8)
   @constraint(model, x[43, 44] <= 6)
   @constraint(model, x[43, 47] <= 9)
   @constraint(model, x[43, 59] <= 4)
   @constraint(model, x[43, 107] <= 7)
   @constraint(model, x[44, 48] <= 24)
   @constraint(model, x[44, 60] <= 29)
   @constraint(model, x[44, 108] <= 30)
   @constraint(model, x[45, 46] <= 11)
   @constraint(model, x[45, 47] <= 13)
   @constraint(model, x[45, 61] <= 3)
   @constraint(model, x[45, 109] <= 3)
   @constraint(model, x[46, 48] <= 8)
   @constraint(model, x[46, 62] <= 24)
   @constraint(model, x[46, 110] <= 18)
   @constraint(model, x[47, 48] <= 20)
   @constraint(model, x[47, 63] <= 32)
   @constraint(model, x[47, 111] <= 19)
   @constraint(model, x[48, 64] <= 50)
   @constraint(model, x[48, 112] <= 5)
   @constraint(model, x[49, 50] <= 32)
   @constraint(model, x[49, 51] <= 1)
   @constraint(model, x[49, 53] <= 32)
   @constraint(model, x[49, 57] <= 16)
   @constraint(model, x[49, 113] <= 24)
   @constraint(model, x[50, 52] <= 8)
   @constraint(model, x[50, 54] <= 14)
   @constraint(model, x[50, 58] <= 3)
   @constraint(model, x[50, 114] <= 14)
   @constraint(model, x[51, 52] <= 15)
   @constraint(model, x[51, 55] <= 8)
   @constraint(model, x[51, 59] <= 6)
   @constraint(model, x[51, 115] <= 8)
   @constraint(model, x[52, 56] <= 24)
   @constraint(model, x[52, 60] <= 9)
   @constraint(model, x[52, 116] <= 23)
   @constraint(model, x[53, 54] <= 2)
   @constraint(model, x[53, 55] <= 7)
   @constraint(model, x[53, 61] <= 9)
   @constraint(model, x[53, 117] <= 8)
   @constraint(model, x[54, 56] <= 15)
   @constraint(model, x[54, 62] <= 12)
   @constraint(model, x[54, 118] <= 16)
   @constraint(model, x[55, 56] <= 10)
   @constraint(model, x[55, 63] <= 15)
   @constraint(model, x[55, 119] <= 29)
   @constraint(model, x[56, 64] <= 7)
   @constraint(model, x[56, 120] <= 18)
   @constraint(model, x[57, 58] <= 14)
   @constraint(model, x[57, 59] <= 13)
   @constraint(model, x[57, 61] <= 7)
   @constraint(model, x[57, 121] <= 1)
   @constraint(model, x[58, 60] <= 10)
   @constraint(model, x[58, 62] <= 20)
   @constraint(model, x[58, 122] <= 11)
   @constraint(model, x[59, 60] <= 16)
   @constraint(model, x[59, 63] <= 4)
   @constraint(model, x[59, 123] <= 13)
   @constraint(model, x[60, 64] <= 38)
   @constraint(model, x[60, 124] <= 3)
   @constraint(model, x[61, 62] <= 28)
   @constraint(model, x[61, 63] <= 26)
   @constraint(model, x[61, 125] <= 24)
   @constraint(model, x[62, 64] <= 12)
   @constraint(model, x[62, 126] <= 34)
   @constraint(model, x[63, 64] <= 38)
   @constraint(model, x[63, 127] <= 2)
   @constraint(model, x[64, 128] <= 95)
   @constraint(model, x[65, 66] <= 9)
   @constraint(model, x[65, 67] <= 46)
   @constraint(model, x[65, 69] <= 36)
   @constraint(model, x[65, 73] <= 61)
   @constraint(model, x[65, 81] <= 33)
   @constraint(model, x[65, 97] <= 3)
   @constraint(model, x[66, 68] <= 23)
   @constraint(model, x[66, 70] <= 22)
   @constraint(model, x[66, 74] <= 4)
   @constraint(model, x[66, 82] <= 4)
   @constraint(model, x[66, 98] <= 14)
   @constraint(model, x[67, 68] <= 3)
   @constraint(model, x[67, 71] <= 15)
   @constraint(model, x[67, 75] <= 1)
   @constraint(model, x[67, 83] <= 24)
   @constraint(model, x[67, 99] <= 26)
   @constraint(model, x[68, 72] <= 8)
   @constraint(model, x[68, 76] <= 11)
   @constraint(model, x[68, 84] <= 14)
   @constraint(model, x[68, 100] <= 4)
   @constraint(model, x[69, 70] <= 20)
   @constraint(model, x[69, 71] <= 7)
   @constraint(model, x[69, 77] <= 21)
   @constraint(model, x[69, 85] <= 4)
   @constraint(model, x[69, 101] <= 6)
   @constraint(model, x[70, 72] <= 4)
   @constraint(model, x[70, 78] <= 16)
   @constraint(model, x[70, 86] <= 9)
   @constraint(model, x[70, 102] <= 1)
   @constraint(model, x[71, 72] <= 7)
   @constraint(model, x[71, 79] <= 4)
   @constraint(model, x[71, 87] <= 2)
   @constraint(model, x[71, 103] <= 1)
   @constraint(model, x[72, 80] <= 15)
   @constraint(model, x[72, 88] <= 21)
   @constraint(model, x[72, 104] <= 21)
   @constraint(model, x[73, 74] <= 5)
   @constraint(model, x[73, 75] <= 15)
   @constraint(model, x[73, 77] <= 13)
   @constraint(model, x[73, 89] <= 26)
   @constraint(model, x[73, 105] <= 24)
   @constraint(model, x[74, 76] <= 9)
   @constraint(model, x[74, 78] <= 1)
   @constraint(model, x[74, 90] <= 16)
   @constraint(model, x[74, 106] <= 9)
   @constraint(model, x[75, 76] <= 4)
   @constraint(model, x[75, 79] <= 15)
   @constraint(model, x[75, 91] <= 16)
   @constraint(model, x[75, 107] <= 16)
   @constraint(model, x[76, 80] <= 13)
   @constraint(model, x[76, 92] <= 9)
   @constraint(model, x[76, 108] <= 23)
   @constraint(model, x[77, 78] <= 11)
   @constraint(model, x[77, 79] <= 15)
   @constraint(model, x[77, 93] <= 2)
   @constraint(model, x[77, 109] <= 2)
   @constraint(model, x[78, 80] <= 21)
   @constraint(model, x[78, 94] <= 22)
   @constraint(model, x[78, 110] <= 20)
   @constraint(model, x[79, 80] <= 1)
   @constraint(model, x[79, 95] <= 6)
   @constraint(model, x[79, 111] <= 23)
   @constraint(model, x[80, 96] <= 10)
   @constraint(model, x[80, 112] <= 17)
   @constraint(model, x[81, 82] <= 19)
   @constraint(model, x[81, 83] <= 11)
   @constraint(model, x[81, 85] <= 25)
   @constraint(model, x[81, 89] <= 32)
   @constraint(model, x[81, 113] <= 8)
   @constraint(model, x[82, 84] <= 13)
   @constraint(model, x[82, 86] <= 2)
   @constraint(model, x[82, 90] <= 4)
   @constraint(model, x[82, 114] <= 5)
   @constraint(model, x[83, 84] <= 2)
   @constraint(model, x[83, 87] <= 7)
   @constraint(model, x[83, 91] <= 15)
   @constraint(model, x[83, 115] <= 11)
   @constraint(model, x[84, 88] <= 11)
   @constraint(model, x[84, 92] <= 26)
   @constraint(model, x[84, 116] <= 16)
   @constraint(model, x[85, 86] <= 16)
   @constraint(model, x[85, 87] <= 13)
   @constraint(model, x[85, 93] <= 3)
   @constraint(model, x[85, 117] <= 15)
   @constraint(model, x[86, 88] <= 25)
   @constraint(model, x[86, 94] <= 4)
   @constraint(model, x[86, 118] <= 20)
   @constraint(model, x[87, 88] <= 4)
   @constraint(model, x[87, 95] <= 7)
   @constraint(model, x[87, 119] <= 17)
   @constraint(model, x[88, 96] <= 5)
   @constraint(model, x[88, 120] <= 47)
   @constraint(model, x[89, 90] <= 8)
   @constraint(model, x[89, 91] <= 8)
   @constraint(model, x[89, 93] <= 8)
   @constraint(model, x[89, 121] <= 10)
   @constraint(model, x[90, 92] <= 22)
   @constraint(model, x[90, 94] <= 12)
   @constraint(model, x[90, 122] <= 6)
   @constraint(model, x[91, 92] <= 13)
   @constraint(model, x[91, 95] <= 16)
   @constraint(model, x[91, 123] <= 5)
   @constraint(model, x[92, 96] <= 47)
   @constraint(model, x[92, 124] <= 51)
   @constraint(model, x[93, 94] <= 10)
   @constraint(model, x[93, 95] <= 20)
   @constraint(model, x[93, 125] <= 6)
   @constraint(model, x[94, 96] <= 32)
   @constraint(model, x[94, 126] <= 25)
   @constraint(model, x[95, 96] <= 44)
   @constraint(model, x[95, 127] <= 35)
   @constraint(model, x[96, 128] <= 88)
   @constraint(model, x[97, 98] <= 3)
   @constraint(model, x[97, 99] <= 10)
   @constraint(model, x[97, 101] <= 22)
   @constraint(model, x[97, 105] <= 18)
   @constraint(model, x[97, 113] <= 26)
   @constraint(model, x[98, 100] <= 4)
   @constraint(model, x[98, 102] <= 6)
   @constraint(model, x[98, 106] <= 10)
   @constraint(model, x[98, 114] <= 6)
   @constraint(model, x[99, 100] <= 13)
   @constraint(model, x[99, 103] <= 8)
   @constraint(model, x[99, 107] <= 10)
   @constraint(model, x[99, 115] <= 14)
   @constraint(model, x[100, 104] <= 14)
   @constraint(model, x[100, 108] <= 17)
   @constraint(model, x[100, 116] <= 31)
   @constraint(model, x[101, 102] <= 2)
   @constraint(model, x[101, 103] <= 16)
   @constraint(model, x[101, 109] <= 8)
   @constraint(model, x[101, 117] <= 14)
   @constraint(model, x[102, 104] <= 30)
   @constraint(model, x[102, 110] <= 15)
   @constraint(model, x[102, 118] <= 29)
   @constraint(model, x[103, 104] <= 13)
   @constraint(model, x[103, 111] <= 6)
   @constraint(model, x[103, 119] <= 31)
   @constraint(model, x[104, 112] <= 23)
   @constraint(model, x[104, 120] <= 12)
   @constraint(model, x[105, 106] <= 6)
   @constraint(model, x[105, 107] <= 7)
   @constraint(model, x[105, 109] <= 7)
   @constraint(model, x[105, 121] <= 7)
   @constraint(model, x[106, 108] <= 14)
   @constraint(model, x[106, 110] <= 26)
   @constraint(model, x[106, 122] <= 10)
   @constraint(model, x[107, 108] <= 14)
   @constraint(model, x[107, 111] <= 3)
   @constraint(model, x[107, 123] <= 14)
   @constraint(model, x[108, 112] <= 25)
   @constraint(model, x[108, 124] <= 34)
   @constraint(model, x[109, 110] <= 11)
   @constraint(model, x[109, 111] <= 16)
   @constraint(model, x[109, 125] <= 18)
   @constraint(model, x[110, 112] <= 25)
   @constraint(model, x[110, 126] <= 21)
   @constraint(model, x[111, 112] <= 30)
   @constraint(model, x[111, 127] <= 2)
   @constraint(model, x[112, 128] <= 120)
   @constraint(model, x[113, 114] <= 15)
   @constraint(model, x[113, 115] <= 3)
   @constraint(model, x[113, 117] <= 4)
   @constraint(model, x[113, 121] <= 14)
   @constraint(model, x[114, 116] <= 20)
   @constraint(model, x[114, 118] <= 19)
   @constraint(model, x[114, 122] <= 11)
   @constraint(model, x[115, 116] <= 11)
   @constraint(model, x[115, 119] <= 12)
   @constraint(model, x[115, 123] <= 2)
   @constraint(model, x[116, 120] <= 39)
   @constraint(model, x[116, 124] <= 6)
   @constraint(model, x[117, 118] <= 29)
   @constraint(model, x[117, 119] <= 31)
   @constraint(model, x[117, 125] <= 7)
   @constraint(model, x[118, 120] <= 45)
   @constraint(model, x[118, 126] <= 28)
   @constraint(model, x[119, 120] <= 8)
   @constraint(model, x[119, 127] <= 19)
   @constraint(model, x[120, 128] <= 3)
   @constraint(model, x[121, 122] <= 13)
   @constraint(model, x[121, 123] <= 32)
   @constraint(model, x[121, 125] <= 17)
   @constraint(model, x[122, 124] <= 55)
   @constraint(model, x[122, 126] <= 46)
   @constraint(model, x[123, 124] <= 5)
   @constraint(model, x[123, 127] <= 9)
   @constraint(model, x[124, 128] <= 61)
   @constraint(model, x[125, 126] <= 61)
   @constraint(model, x[125, 127] <= 58)
   @constraint(model, x[126, 128] <= 77)
   @constraint(model, x[127, 128] <= 58)

    # Flow must be balanced
   @constraint(model, [i = 2:127], sum(x[i, :]) == sum(x[:, i]))
    @constraint(model, sum(x[1, :])  == sum(x[:, 128]))
    # Trying to maximize the flow
    @objective(model, Max, sum(x[1, :]))

    optimize!(model)
    println(Int64(objective_value(model)))
end

println(@elapsed model())

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
   @constraint(model, x[1, 2] <= 107)
   @constraint(model, x[1, 3] <= 35)
   @constraint(model, x[1, 5] <= 80)
   @constraint(model, x[1, 9] <= 2)
   @constraint(model, x[1, 17] <= 101)
   @constraint(model, x[1, 33] <= 65)
   @constraint(model, x[1, 65] <= 96)
   @constraint(model, x[2, 4] <= 24)
   @constraint(model, x[2, 6] <= 31)
   @constraint(model, x[2, 10] <= 54)
   @constraint(model, x[2, 18] <= 52)
   @constraint(model, x[2, 34] <= 61)
   @constraint(model, x[2, 66] <= 27)
   @constraint(model, x[3, 4] <= 30)
   @constraint(model, x[3, 7] <= 52)
   @constraint(model, x[3, 11] <= 27)
   @constraint(model, x[3, 19] <= 2)
   @constraint(model, x[3, 35] <= 30)
   @constraint(model, x[3, 67] <= 22)
   @constraint(model, x[4, 8] <= 9)
   @constraint(model, x[4, 12] <= 21)
   @constraint(model, x[4, 20] <= 29)
   @constraint(model, x[4, 36] <= 15)
   @constraint(model, x[4, 68] <= 25)
   @constraint(model, x[5, 6] <= 14)
   @constraint(model, x[5, 7] <= 8)
   @constraint(model, x[5, 13] <= 30)
   @constraint(model, x[5, 21] <= 11)
   @constraint(model, x[5, 37] <= 30)
   @constraint(model, x[5, 69] <= 38)
   @constraint(model, x[6, 8] <= 13)
   @constraint(model, x[6, 14] <= 22)
   @constraint(model, x[6, 22] <= 12)
   @constraint(model, x[6, 38] <= 22)
   @constraint(model, x[6, 70] <= 1)
   @constraint(model, x[7, 8] <= 11)
   @constraint(model, x[7, 15] <= 28)
   @constraint(model, x[7, 23] <= 30)
   @constraint(model, x[7, 39] <= 15)
   @constraint(model, x[7, 71] <= 6)
   @constraint(model, x[8, 16] <= 12)
   @constraint(model, x[8, 24] <= 13)
   @constraint(model, x[8, 40] <= 9)
   @constraint(model, x[8, 72] <= 10)
   @constraint(model, x[9, 10] <= 42)
   @constraint(model, x[9, 11] <= 15)
   @constraint(model, x[9, 13] <= 3)
   @constraint(model, x[9, 25] <= 9)
   @constraint(model, x[9, 41] <= 43)
   @constraint(model, x[9, 73] <= 43)
   @constraint(model, x[10, 12] <= 4)
   @constraint(model, x[10, 14] <= 31)
   @constraint(model, x[10, 26] <= 3)
   @constraint(model, x[10, 42] <= 15)
   @constraint(model, x[10, 74] <= 1)
   @constraint(model, x[11, 12] <= 3)
   @constraint(model, x[11, 15] <= 21)
   @constraint(model, x[11, 27] <= 28)
   @constraint(model, x[11, 43] <= 16)
   @constraint(model, x[11, 75] <= 4)
   @constraint(model, x[12, 16] <= 5)
   @constraint(model, x[12, 28] <= 9)
   @constraint(model, x[12, 44] <= 13)
   @constraint(model, x[12, 76] <= 2)
   @constraint(model, x[13, 14] <= 25)
   @constraint(model, x[13, 15] <= 12)
   @constraint(model, x[13, 29] <= 30)
   @constraint(model, x[13, 45] <= 21)
   @constraint(model, x[13, 77] <= 24)
   @constraint(model, x[14, 16] <= 10)
   @constraint(model, x[14, 30] <= 4)
   @constraint(model, x[14, 46] <= 3)
   @constraint(model, x[14, 78] <= 16)
   @constraint(model, x[15, 16] <= 2)
   @constraint(model, x[15, 31] <= 8)
   @constraint(model, x[15, 47] <= 8)
   @constraint(model, x[15, 79] <= 7)
   @constraint(model, x[16, 32] <= 19)
   @constraint(model, x[16, 48] <= 8)
   @constraint(model, x[16, 80] <= 9)
   @constraint(model, x[17, 18] <= 31)
   @constraint(model, x[17, 19] <= 53)
   @constraint(model, x[17, 21] <= 61)
   @constraint(model, x[17, 25] <= 20)
   @constraint(model, x[17, 49] <= 46)
   @constraint(model, x[17, 81] <= 47)
   @constraint(model, x[18, 20] <= 3)
   @constraint(model, x[18, 22] <= 5)
   @constraint(model, x[18, 26] <= 16)
   @constraint(model, x[18, 50] <= 16)
   @constraint(model, x[18, 82] <= 26)
   @constraint(model, x[19, 20] <= 22)
   @constraint(model, x[19, 23] <= 14)
   @constraint(model, x[19, 27] <= 30)
   @constraint(model, x[19, 51] <= 15)
   @constraint(model, x[19, 83] <= 3)
   @constraint(model, x[20, 24] <= 6)
   @constraint(model, x[20, 28] <= 2)
   @constraint(model, x[20, 52] <= 11)
   @constraint(model, x[20, 84] <= 1)
   @constraint(model, x[21, 22] <= 17)
   @constraint(model, x[21, 23] <= 19)
   @constraint(model, x[21, 29] <= 31)
   @constraint(model, x[21, 53] <= 21)
   @constraint(model, x[21, 85] <= 1)
   @constraint(model, x[22, 24] <= 6)
   @constraint(model, x[22, 30] <= 5)
   @constraint(model, x[22, 54] <= 13)
   @constraint(model, x[22, 86] <= 2)
   @constraint(model, x[23, 24] <= 8)
   @constraint(model, x[23, 31] <= 10)
   @constraint(model, x[23, 55] <= 15)
   @constraint(model, x[23, 87] <= 4)
   @constraint(model, x[24, 32] <= 6)
   @constraint(model, x[24, 56] <= 21)
   @constraint(model, x[24, 88] <= 24)
   @constraint(model, x[25, 26] <= 2)
   @constraint(model, x[25, 27] <= 14)
   @constraint(model, x[25, 29] <= 16)
   @constraint(model, x[25, 57] <= 3)
   @constraint(model, x[25, 89] <= 20)
   @constraint(model, x[26, 28] <= 15)
   @constraint(model, x[26, 30] <= 7)
   @constraint(model, x[26, 58] <= 8)
   @constraint(model, x[26, 90] <= 14)
   @constraint(model, x[27, 28] <= 6)
   @constraint(model, x[27, 31] <= 5)
   @constraint(model, x[27, 59] <= 1)
   @constraint(model, x[27, 91] <= 12)
   @constraint(model, x[28, 32] <= 3)
   @constraint(model, x[28, 60] <= 30)
   @constraint(model, x[28, 92] <= 11)
   @constraint(model, x[29, 30] <= 10)
   @constraint(model, x[29, 31] <= 5)
   @constraint(model, x[29, 61] <= 9)
   @constraint(model, x[29, 93] <= 7)
   @constraint(model, x[30, 32] <= 10)
   @constraint(model, x[30, 62] <= 1)
   @constraint(model, x[30, 94] <= 8)
   @constraint(model, x[31, 32] <= 8)
   @constraint(model, x[31, 63] <= 20)
   @constraint(model, x[31, 95] <= 26)
   @constraint(model, x[32, 64] <= 21)
   @constraint(model, x[32, 96] <= 62)
   @constraint(model, x[33, 34] <= 23)
   @constraint(model, x[33, 35] <= 55)
   @constraint(model, x[33, 37] <= 2)
   @constraint(model, x[33, 41] <= 1)
   @constraint(model, x[33, 49] <= 33)
   @constraint(model, x[33, 97] <= 40)
   @constraint(model, x[34, 36] <= 13)
   @constraint(model, x[34, 38] <= 27)
   @constraint(model, x[34, 42] <= 15)
   @constraint(model, x[34, 50] <= 23)
   @constraint(model, x[34, 98] <= 21)
   @constraint(model, x[35, 36] <= 5)
   @constraint(model, x[35, 39] <= 22)
   @constraint(model, x[35, 43] <= 16)
   @constraint(model, x[35, 51] <= 30)
   @constraint(model, x[35, 99] <= 23)
   @constraint(model, x[36, 40] <= 16)
   @constraint(model, x[36, 44] <= 3)
   @constraint(model, x[36, 52] <= 8)
   @constraint(model, x[36, 100] <= 3)
   @constraint(model, x[37, 38] <= 13)
   @constraint(model, x[37, 39] <= 19)
   @constraint(model, x[37, 45] <= 17)
   @constraint(model, x[37, 53] <= 27)
   @constraint(model, x[37, 101] <= 18)
   @constraint(model, x[38, 40] <= 1)
   @constraint(model, x[38, 46] <= 6)
   @constraint(model, x[38, 54] <= 7)
   @constraint(model, x[38, 102] <= 4)
   @constraint(model, x[39, 40] <= 6)
   @constraint(model, x[39, 47] <= 8)
   @constraint(model, x[39, 55] <= 16)
   @constraint(model, x[39, 103] <= 3)
   @constraint(model, x[40, 48] <= 30)
   @constraint(model, x[40, 56] <= 18)
   @constraint(model, x[40, 104] <= 23)
   @constraint(model, x[41, 42] <= 9)
   @constraint(model, x[41, 43] <= 18)
   @constraint(model, x[41, 45] <= 9)
   @constraint(model, x[41, 57] <= 7)
   @constraint(model, x[41, 105] <= 12)
   @constraint(model, x[42, 44] <= 4)
   @constraint(model, x[42, 46] <= 11)
   @constraint(model, x[42, 58] <= 3)
   @constraint(model, x[42, 106] <= 1)
   @constraint(model, x[43, 44] <= 7)
   @constraint(model, x[43, 47] <= 10)
   @constraint(model, x[43, 59] <= 1)
   @constraint(model, x[43, 107] <= 6)
   @constraint(model, x[44, 48] <= 22)
   @constraint(model, x[44, 60] <= 13)
   @constraint(model, x[44, 108] <= 7)
   @constraint(model, x[45, 46] <= 4)
   @constraint(model, x[45, 47] <= 6)
   @constraint(model, x[45, 61] <= 10)
   @constraint(model, x[45, 109] <= 4)
   @constraint(model, x[46, 48] <= 2)
   @constraint(model, x[46, 62] <= 11)
   @constraint(model, x[46, 110] <= 22)
   @constraint(model, x[47, 48] <= 30)
   @constraint(model, x[47, 63] <= 10)
   @constraint(model, x[47, 111] <= 27)
   @constraint(model, x[48, 64] <= 37)
   @constraint(model, x[48, 112] <= 33)
   @constraint(model, x[49, 50] <= 8)
   @constraint(model, x[49, 51] <= 17)
   @constraint(model, x[49, 53] <= 16)
   @constraint(model, x[49, 57] <= 15)
   @constraint(model, x[49, 113] <= 19)
   @constraint(model, x[50, 52] <= 12)
   @constraint(model, x[50, 54] <= 12)
   @constraint(model, x[50, 58] <= 1)
   @constraint(model, x[50, 114] <= 15)
   @constraint(model, x[51, 52] <= 3)
   @constraint(model, x[51, 55] <= 11)
   @constraint(model, x[51, 59] <= 15)
   @constraint(model, x[51, 115] <= 8)
   @constraint(model, x[52, 56] <= 13)
   @constraint(model, x[52, 60] <= 28)
   @constraint(model, x[52, 116] <= 15)
   @constraint(model, x[53, 54] <= 15)
   @constraint(model, x[53, 55] <= 11)
   @constraint(model, x[53, 61] <= 7)
   @constraint(model, x[53, 117] <= 12)
   @constraint(model, x[54, 56] <= 22)
   @constraint(model, x[54, 62] <= 2)
   @constraint(model, x[54, 118] <= 21)
   @constraint(model, x[55, 56] <= 27)
   @constraint(model, x[55, 63] <= 17)
   @constraint(model, x[55, 119] <= 21)
   @constraint(model, x[56, 64] <= 22)
   @constraint(model, x[56, 120] <= 18)
   @constraint(model, x[57, 58] <= 7)
   @constraint(model, x[57, 59] <= 2)
   @constraint(model, x[57, 61] <= 11)
   @constraint(model, x[57, 121] <= 8)
   @constraint(model, x[58, 60] <= 19)
   @constraint(model, x[58, 62] <= 4)
   @constraint(model, x[58, 122] <= 5)
   @constraint(model, x[59, 60] <= 8)
   @constraint(model, x[59, 63] <= 26)
   @constraint(model, x[59, 123] <= 14)
   @constraint(model, x[60, 64] <= 59)
   @constraint(model, x[60, 124] <= 62)
   @constraint(model, x[61, 62] <= 13)
   @constraint(model, x[61, 63] <= 15)
   @constraint(model, x[61, 125] <= 11)
   @constraint(model, x[62, 64] <= 45)
   @constraint(model, x[62, 126] <= 42)
   @constraint(model, x[63, 64] <= 16)
   @constraint(model, x[63, 127] <= 49)
   @constraint(model, x[64, 128] <= 116)
   @constraint(model, x[65, 66] <= 50)
   @constraint(model, x[65, 67] <= 45)
   @constraint(model, x[65, 69] <= 58)
   @constraint(model, x[65, 73] <= 49)
   @constraint(model, x[65, 81] <= 4)
   @constraint(model, x[65, 97] <= 35)
   @constraint(model, x[66, 68] <= 28)
   @constraint(model, x[66, 70] <= 14)
   @constraint(model, x[66, 74] <= 2)
   @constraint(model, x[66, 82] <= 17)
   @constraint(model, x[66, 98] <= 5)
   @constraint(model, x[67, 68] <= 31)
   @constraint(model, x[67, 71] <= 22)
   @constraint(model, x[67, 75] <= 13)
   @constraint(model, x[67, 83] <= 1)
   @constraint(model, x[67, 99] <= 27)
   @constraint(model, x[68, 72] <= 5)
   @constraint(model, x[68, 76] <= 13)
   @constraint(model, x[68, 84] <= 7)
   @constraint(model, x[68, 100] <= 1)
   @constraint(model, x[69, 70] <= 19)
   @constraint(model, x[69, 71] <= 23)
   @constraint(model, x[69, 77] <= 21)
   @constraint(model, x[69, 85] <= 7)
   @constraint(model, x[69, 101] <= 11)
   @constraint(model, x[70, 72] <= 11)
   @constraint(model, x[70, 78] <= 3)
   @constraint(model, x[70, 86] <= 12)
   @constraint(model, x[70, 102] <= 7)
   @constraint(model, x[71, 72] <= 8)
   @constraint(model, x[71, 79] <= 9)
   @constraint(model, x[71, 87] <= 12)
   @constraint(model, x[71, 103] <= 3)
   @constraint(model, x[72, 80] <= 4)
   @constraint(model, x[72, 88] <= 5)
   @constraint(model, x[72, 104] <= 8)
   @constraint(model, x[73, 74] <= 21)
   @constraint(model, x[73, 75] <= 28)
   @constraint(model, x[73, 77] <= 19)
   @constraint(model, x[73, 89] <= 20)
   @constraint(model, x[73, 105] <= 28)
   @constraint(model, x[74, 76] <= 16)
   @constraint(model, x[74, 78] <= 10)
   @constraint(model, x[74, 90] <= 12)
   @constraint(model, x[74, 106] <= 14)
   @constraint(model, x[75, 76] <= 4)
   @constraint(model, x[75, 79] <= 11)
   @constraint(model, x[75, 91] <= 6)
   @constraint(model, x[75, 107] <= 6)
   @constraint(model, x[76, 80] <= 23)
   @constraint(model, x[76, 92] <= 19)
   @constraint(model, x[76, 108] <= 19)
   @constraint(model, x[77, 78] <= 7)
   @constraint(model, x[77, 79] <= 7)
   @constraint(model, x[77, 93] <= 15)
   @constraint(model, x[77, 109] <= 8)
   @constraint(model, x[78, 80] <= 10)
   @constraint(model, x[78, 94] <= 2)
   @constraint(model, x[78, 110] <= 22)
   @constraint(model, x[79, 80] <= 11)
   @constraint(model, x[79, 95] <= 15)
   @constraint(model, x[79, 111] <= 20)
   @constraint(model, x[80, 96] <= 49)
   @constraint(model, x[80, 112] <= 58)
   @constraint(model, x[81, 82] <= 15)
   @constraint(model, x[81, 83] <= 22)
   @constraint(model, x[81, 85] <= 27)
   @constraint(model, x[81, 89] <= 29)
   @constraint(model, x[81, 113] <= 4)
   @constraint(model, x[82, 84] <= 11)
   @constraint(model, x[82, 86] <= 1)
   @constraint(model, x[82, 90] <= 2)
   @constraint(model, x[82, 114] <= 5)
   @constraint(model, x[83, 84] <= 4)
   @constraint(model, x[83, 87] <= 2)
   @constraint(model, x[83, 91] <= 6)
   @constraint(model, x[83, 115] <= 10)
   @constraint(model, x[84, 88] <= 22)
   @constraint(model, x[84, 92] <= 29)
   @constraint(model, x[84, 116] <= 31)
   @constraint(model, x[85, 86] <= 7)
   @constraint(model, x[85, 87] <= 8)
   @constraint(model, x[85, 93] <= 5)
   @constraint(model, x[85, 117] <= 13)
   @constraint(model, x[86, 88] <= 4)
   @constraint(model, x[86, 94] <= 13)
   @constraint(model, x[86, 118] <= 1)
   @constraint(model, x[87, 88] <= 13)
   @constraint(model, x[87, 95] <= 21)
   @constraint(model, x[87, 119] <= 7)
   @constraint(model, x[88, 96] <= 43)
   @constraint(model, x[88, 120] <= 23)
   @constraint(model, x[89, 90] <= 16)
   @constraint(model, x[89, 91] <= 4)
   @constraint(model, x[89, 93] <= 1)
   @constraint(model, x[89, 121] <= 4)
   @constraint(model, x[90, 92] <= 6)
   @constraint(model, x[90, 94] <= 17)
   @constraint(model, x[90, 122] <= 22)
   @constraint(model, x[91, 92] <= 32)
   @constraint(model, x[91, 95] <= 7)
   @constraint(model, x[91, 123] <= 22)
   @constraint(model, x[92, 96] <= 24)
   @constraint(model, x[92, 124] <= 24)
   @constraint(model, x[93, 94] <= 2)
   @constraint(model, x[93, 95] <= 32)
   @constraint(model, x[93, 125] <= 13)
   @constraint(model, x[94, 96] <= 18)
   @constraint(model, x[94, 126] <= 38)
   @constraint(model, x[95, 96] <= 22)
   @constraint(model, x[95, 127] <= 60)
   @constraint(model, x[96, 128] <= 83)
   @constraint(model, x[97, 98] <= 29)
   @constraint(model, x[97, 99] <= 32)
   @constraint(model, x[97, 101] <= 31)
   @constraint(model, x[97, 105] <= 3)
   @constraint(model, x[97, 113] <= 5)
   @constraint(model, x[98, 100] <= 11)
   @constraint(model, x[98, 102] <= 11)
   @constraint(model, x[98, 106] <= 15)
   @constraint(model, x[98, 114] <= 15)
   @constraint(model, x[99, 100] <= 5)
   @constraint(model, x[99, 103] <= 13)
   @constraint(model, x[99, 107] <= 1)
   @constraint(model, x[99, 115] <= 15)
   @constraint(model, x[100, 104] <= 8)
   @constraint(model, x[100, 108] <= 29)
   @constraint(model, x[100, 116] <= 6)
   @constraint(model, x[101, 102] <= 4)
   @constraint(model, x[101, 103] <= 15)
   @constraint(model, x[101, 109] <= 13)
   @constraint(model, x[101, 117] <= 1)
   @constraint(model, x[102, 104] <= 32)
   @constraint(model, x[102, 110] <= 31)
   @constraint(model, x[102, 118] <= 31)
   @constraint(model, x[103, 104] <= 17)
   @constraint(model, x[103, 111] <= 29)
   @constraint(model, x[103, 119] <= 8)
   @constraint(model, x[104, 112] <= 32)
   @constraint(model, x[104, 120] <= 57)
   @constraint(model, x[105, 106] <= 8)
   @constraint(model, x[105, 107] <= 16)
   @constraint(model, x[105, 109] <= 8)
   @constraint(model, x[105, 121] <= 1)
   @constraint(model, x[106, 108] <= 28)
   @constraint(model, x[106, 110] <= 23)
   @constraint(model, x[106, 122] <= 16)
   @constraint(model, x[107, 108] <= 25)
   @constraint(model, x[107, 111] <= 30)
   @constraint(model, x[107, 123] <= 31)
   @constraint(model, x[108, 112] <= 55)
   @constraint(model, x[108, 124] <= 39)
   @constraint(model, x[109, 110] <= 7)
   @constraint(model, x[109, 111] <= 16)
   @constraint(model, x[109, 125] <= 32)
   @constraint(model, x[110, 112] <= 30)
   @constraint(model, x[110, 126] <= 26)
   @constraint(model, x[111, 112] <= 55)
   @constraint(model, x[111, 127] <= 33)
   @constraint(model, x[112, 128] <= 101)
   @constraint(model, x[113, 114] <= 10)
   @constraint(model, x[113, 115] <= 9)
   @constraint(model, x[113, 117] <= 14)
   @constraint(model, x[113, 121] <= 2)
   @constraint(model, x[114, 116] <= 23)
   @constraint(model, x[114, 118] <= 14)
   @constraint(model, x[114, 122] <= 14)
   @constraint(model, x[115, 116] <= 8)
   @constraint(model, x[115, 119] <= 27)
   @constraint(model, x[115, 123] <= 21)
   @constraint(model, x[116, 120] <= 13)
   @constraint(model, x[116, 124] <= 57)
   @constraint(model, x[117, 118] <= 30)
   @constraint(model, x[117, 119] <= 30)
   @constraint(model, x[117, 125] <= 14)
   @constraint(model, x[118, 120] <= 19)
   @constraint(model, x[118, 126] <= 8)
   @constraint(model, x[119, 120] <= 13)
   @constraint(model, x[119, 127] <= 17)
   @constraint(model, x[120, 128] <= 47)
   @constraint(model, x[121, 122] <= 8)
   @constraint(model, x[121, 123] <= 26)
   @constraint(model, x[121, 125] <= 24)
   @constraint(model, x[122, 124] <= 21)
   @constraint(model, x[122, 126] <= 35)
   @constraint(model, x[123, 124] <= 37)
   @constraint(model, x[123, 127] <= 20)
   @constraint(model, x[124, 128] <= 98)
   @constraint(model, x[125, 126] <= 11)
   @constraint(model, x[125, 127] <= 47)
   @constraint(model, x[126, 128] <= 5)
   @constraint(model, x[127, 128] <= 108)

    # Flow must be balanced
   @constraint(model, [i = 2:127], sum(x[i, :]) == sum(x[:, i]))
    @constraint(model, sum(x[1, :])  == sum(x[:, 128]))
    # Trying to maximize the flow
    @objective(model, Max, sum(x[1, :]))

    optimize!(model)
    println(Int64(objective_value(model)))
end

println(@elapsed model())
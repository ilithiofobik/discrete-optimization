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
   @constraint(model, x[1, 2] <= 97)
   @constraint(model, x[1, 3] <= 33)
   @constraint(model, x[1, 5] <= 69)
   @constraint(model, x[1, 9] <= 66)
   @constraint(model, x[1, 17] <= 79)
   @constraint(model, x[1, 33] <= 88)
   @constraint(model, x[1, 65] <= 96)
   @constraint(model, x[2, 4] <= 32)
   @constraint(model, x[2, 6] <= 14)
   @constraint(model, x[2, 10] <= 49)
   @constraint(model, x[2, 18] <= 59)
   @constraint(model, x[2, 34] <= 11)
   @constraint(model, x[2, 66] <= 32)
   @constraint(model, x[3, 4] <= 9)
   @constraint(model, x[3, 7] <= 45)
   @constraint(model, x[3, 11] <= 17)
   @constraint(model, x[3, 19] <= 19)
   @constraint(model, x[3, 35] <= 62)
   @constraint(model, x[3, 67] <= 20)
   @constraint(model, x[4, 8] <= 19)
   @constraint(model, x[4, 12] <= 27)
   @constraint(model, x[4, 20] <= 29)
   @constraint(model, x[4, 36] <= 15)
   @constraint(model, x[4, 68] <= 21)
   @constraint(model, x[5, 6] <= 25)
   @constraint(model, x[5, 7] <= 31)
   @constraint(model, x[5, 13] <= 52)
   @constraint(model, x[5, 21] <= 18)
   @constraint(model, x[5, 37] <= 3)
   @constraint(model, x[5, 69] <= 15)
   @constraint(model, x[6, 8] <= 3)
   @constraint(model, x[6, 14] <= 29)
   @constraint(model, x[6, 22] <= 6)
   @constraint(model, x[6, 38] <= 1)
   @constraint(model, x[6, 70] <= 14)
   @constraint(model, x[7, 8] <= 17)
   @constraint(model, x[7, 15] <= 24)
   @constraint(model, x[7, 23] <= 21)
   @constraint(model, x[7, 39] <= 3)
   @constraint(model, x[7, 71] <= 15)
   @constraint(model, x[8, 16] <= 11)
   @constraint(model, x[8, 24] <= 14)
   @constraint(model, x[8, 40] <= 10)
   @constraint(model, x[8, 72] <= 11)
   @constraint(model, x[9, 10] <= 47)
   @constraint(model, x[9, 11] <= 45)
   @constraint(model, x[9, 13] <= 27)
   @constraint(model, x[9, 25] <= 7)
   @constraint(model, x[9, 41] <= 54)
   @constraint(model, x[9, 73] <= 16)
   @constraint(model, x[10, 12] <= 14)
   @constraint(model, x[10, 14] <= 27)
   @constraint(model, x[10, 26] <= 14)
   @constraint(model, x[10, 42] <= 18)
   @constraint(model, x[10, 74] <= 20)
   @constraint(model, x[11, 12] <= 1)
   @constraint(model, x[11, 15] <= 3)
   @constraint(model, x[11, 27] <= 6)
   @constraint(model, x[11, 43] <= 31)
   @constraint(model, x[11, 75] <= 6)
   @constraint(model, x[12, 16] <= 6)
   @constraint(model, x[12, 28] <= 10)
   @constraint(model, x[12, 44] <= 2)
   @constraint(model, x[12, 76] <= 3)
   @constraint(model, x[13, 14] <= 25)
   @constraint(model, x[13, 15] <= 6)
   @constraint(model, x[13, 29] <= 18)
   @constraint(model, x[13, 45] <= 12)
   @constraint(model, x[13, 77] <= 29)
   @constraint(model, x[14, 16] <= 4)
   @constraint(model, x[14, 30] <= 1)
   @constraint(model, x[14, 46] <= 9)
   @constraint(model, x[14, 78] <= 8)
   @constraint(model, x[15, 16] <= 3)
   @constraint(model, x[15, 31] <= 5)
   @constraint(model, x[15, 47] <= 5)
   @constraint(model, x[15, 79] <= 11)
   @constraint(model, x[16, 32] <= 29)
   @constraint(model, x[16, 48] <= 30)
   @constraint(model, x[16, 80] <= 30)
   @constraint(model, x[17, 18] <= 13)
   @constraint(model, x[17, 19] <= 35)
   @constraint(model, x[17, 21] <= 34)
   @constraint(model, x[17, 25] <= 33)
   @constraint(model, x[17, 49] <= 44)
   @constraint(model, x[17, 81] <= 17)
   @constraint(model, x[18, 20] <= 21)
   @constraint(model, x[18, 22] <= 15)
   @constraint(model, x[18, 26] <= 29)
   @constraint(model, x[18, 50] <= 18)
   @constraint(model, x[18, 82] <= 30)
   @constraint(model, x[19, 20] <= 22)
   @constraint(model, x[19, 23] <= 7)
   @constraint(model, x[19, 27] <= 3)
   @constraint(model, x[19, 51] <= 16)
   @constraint(model, x[19, 83] <= 3)
   @constraint(model, x[20, 24] <= 10)
   @constraint(model, x[20, 28] <= 4)
   @constraint(model, x[20, 52] <= 14)
   @constraint(model, x[20, 84] <= 16)
   @constraint(model, x[21, 22] <= 17)
   @constraint(model, x[21, 23] <= 18)
   @constraint(model, x[21, 29] <= 29)
   @constraint(model, x[21, 53] <= 15)
   @constraint(model, x[21, 85] <= 27)
   @constraint(model, x[22, 24] <= 6)
   @constraint(model, x[22, 30] <= 9)
   @constraint(model, x[22, 54] <= 14)
   @constraint(model, x[22, 86] <= 13)
   @constraint(model, x[23, 24] <= 7)
   @constraint(model, x[23, 31] <= 16)
   @constraint(model, x[23, 55] <= 8)
   @constraint(model, x[23, 87] <= 10)
   @constraint(model, x[24, 32] <= 14)
   @constraint(model, x[24, 56] <= 2)
   @constraint(model, x[24, 88] <= 5)
   @constraint(model, x[25, 26] <= 11)
   @constraint(model, x[25, 27] <= 11)
   @constraint(model, x[25, 29] <= 14)
   @constraint(model, x[25, 57] <= 23)
   @constraint(model, x[25, 89] <= 30)
   @constraint(model, x[26, 28] <= 5)
   @constraint(model, x[26, 30] <= 5)
   @constraint(model, x[26, 58] <= 12)
   @constraint(model, x[26, 90] <= 13)
   @constraint(model, x[27, 28] <= 1)
   @constraint(model, x[27, 31] <= 10)
   @constraint(model, x[27, 59] <= 10)
   @constraint(model, x[27, 91] <= 5)
   @constraint(model, x[28, 32] <= 24)
   @constraint(model, x[28, 60] <= 9)
   @constraint(model, x[28, 92] <= 1)
   @constraint(model, x[29, 30] <= 7)
   @constraint(model, x[29, 31] <= 6)
   @constraint(model, x[29, 61] <= 1)
   @constraint(model, x[29, 93] <= 11)
   @constraint(model, x[30, 32] <= 11)
   @constraint(model, x[30, 62] <= 4)
   @constraint(model, x[30, 94] <= 21)
   @constraint(model, x[31, 32] <= 32)
   @constraint(model, x[31, 63] <= 4)
   @constraint(model, x[31, 95] <= 28)
   @constraint(model, x[32, 64] <= 4)
   @constraint(model, x[32, 96] <= 18)
   @constraint(model, x[33, 34] <= 53)
   @constraint(model, x[33, 35] <= 22)
   @constraint(model, x[33, 37] <= 35)
   @constraint(model, x[33, 41] <= 7)
   @constraint(model, x[33, 49] <= 28)
   @constraint(model, x[33, 97] <= 35)
   @constraint(model, x[34, 36] <= 11)
   @constraint(model, x[34, 38] <= 21)
   @constraint(model, x[34, 42] <= 12)
   @constraint(model, x[34, 50] <= 32)
   @constraint(model, x[34, 98] <= 8)
   @constraint(model, x[35, 36] <= 12)
   @constraint(model, x[35, 39] <= 20)
   @constraint(model, x[35, 43] <= 8)
   @constraint(model, x[35, 51] <= 7)
   @constraint(model, x[35, 99] <= 1)
   @constraint(model, x[36, 40] <= 12)
   @constraint(model, x[36, 44] <= 12)
   @constraint(model, x[36, 52] <= 16)
   @constraint(model, x[36, 100] <= 2)
   @constraint(model, x[37, 38] <= 27)
   @constraint(model, x[37, 39] <= 18)
   @constraint(model, x[37, 45] <= 17)
   @constraint(model, x[37, 53] <= 26)
   @constraint(model, x[37, 101] <= 28)
   @constraint(model, x[38, 40] <= 4)
   @constraint(model, x[38, 46] <= 13)
   @constraint(model, x[38, 54] <= 1)
   @constraint(model, x[38, 102] <= 7)
   @constraint(model, x[39, 40] <= 2)
   @constraint(model, x[39, 47] <= 12)
   @constraint(model, x[39, 55] <= 13)
   @constraint(model, x[39, 103] <= 14)
   @constraint(model, x[40, 48] <= 4)
   @constraint(model, x[40, 56] <= 15)
   @constraint(model, x[40, 104] <= 32)
   @constraint(model, x[41, 42] <= 20)
   @constraint(model, x[41, 43] <= 30)
   @constraint(model, x[41, 45] <= 23)
   @constraint(model, x[41, 57] <= 31)
   @constraint(model, x[41, 105] <= 31)
   @constraint(model, x[42, 44] <= 9)
   @constraint(model, x[42, 46] <= 9)
   @constraint(model, x[42, 58] <= 15)
   @constraint(model, x[42, 106] <= 12)
   @constraint(model, x[43, 44] <= 13)
   @constraint(model, x[43, 47] <= 8)
   @constraint(model, x[43, 59] <= 14)
   @constraint(model, x[43, 107] <= 8)
   @constraint(model, x[44, 48] <= 23)
   @constraint(model, x[44, 60] <= 31)
   @constraint(model, x[44, 108] <= 7)
   @constraint(model, x[45, 46] <= 7)
   @constraint(model, x[45, 47] <= 5)
   @constraint(model, x[45, 61] <= 7)
   @constraint(model, x[45, 109] <= 5)
   @constraint(model, x[46, 48] <= 19)
   @constraint(model, x[46, 62] <= 24)
   @constraint(model, x[46, 110] <= 9)
   @constraint(model, x[47, 48] <= 7)
   @constraint(model, x[47, 63] <= 12)
   @constraint(model, x[47, 111] <= 20)
   @constraint(model, x[48, 64] <= 36)
   @constraint(model, x[48, 112] <= 63)
   @constraint(model, x[49, 50] <= 25)
   @constraint(model, x[49, 51] <= 17)
   @constraint(model, x[49, 53] <= 3)
   @constraint(model, x[49, 57] <= 11)
   @constraint(model, x[49, 113] <= 10)
   @constraint(model, x[50, 52] <= 1)
   @constraint(model, x[50, 54] <= 14)
   @constraint(model, x[50, 58] <= 16)
   @constraint(model, x[50, 114] <= 4)
   @constraint(model, x[51, 52] <= 6)
   @constraint(model, x[51, 55] <= 13)
   @constraint(model, x[51, 59] <= 10)
   @constraint(model, x[51, 115] <= 8)
   @constraint(model, x[52, 56] <= 16)
   @constraint(model, x[52, 60] <= 32)
   @constraint(model, x[52, 116] <= 11)
   @constraint(model, x[53, 54] <= 6)
   @constraint(model, x[53, 55] <= 4)
   @constraint(model, x[53, 61] <= 14)
   @constraint(model, x[53, 117] <= 7)
   @constraint(model, x[54, 56] <= 32)
   @constraint(model, x[54, 62] <= 17)
   @constraint(model, x[54, 118] <= 20)
   @constraint(model, x[55, 56] <= 17)
   @constraint(model, x[55, 63] <= 11)
   @constraint(model, x[55, 119] <= 2)
   @constraint(model, x[56, 64] <= 26)
   @constraint(model, x[56, 120] <= 7)
   @constraint(model, x[57, 58] <= 1)
   @constraint(model, x[57, 59] <= 6)
   @constraint(model, x[57, 61] <= 2)
   @constraint(model, x[57, 121] <= 15)
   @constraint(model, x[58, 60] <= 17)
   @constraint(model, x[58, 62] <= 15)
   @constraint(model, x[58, 122] <= 30)
   @constraint(model, x[59, 60] <= 2)
   @constraint(model, x[59, 63] <= 2)
   @constraint(model, x[59, 123] <= 27)
   @constraint(model, x[60, 64] <= 19)
   @constraint(model, x[60, 124] <= 18)
   @constraint(model, x[61, 62] <= 21)
   @constraint(model, x[61, 63] <= 24)
   @constraint(model, x[61, 125] <= 13)
   @constraint(model, x[62, 64] <= 54)
   @constraint(model, x[62, 126] <= 37)
   @constraint(model, x[63, 64] <= 54)
   @constraint(model, x[63, 127] <= 61)
   @constraint(model, x[64, 128] <= 11)
   @constraint(model, x[65, 66] <= 38)
   @constraint(model, x[65, 67] <= 61)
   @constraint(model, x[65, 69] <= 12)
   @constraint(model, x[65, 73] <= 47)
   @constraint(model, x[65, 81] <= 12)
   @constraint(model, x[65, 97] <= 48)
   @constraint(model, x[66, 68] <= 3)
   @constraint(model, x[66, 70] <= 10)
   @constraint(model, x[66, 74] <= 32)
   @constraint(model, x[66, 82] <= 2)
   @constraint(model, x[66, 98] <= 15)
   @constraint(model, x[67, 68] <= 7)
   @constraint(model, x[67, 71] <= 29)
   @constraint(model, x[67, 75] <= 18)
   @constraint(model, x[67, 83] <= 9)
   @constraint(model, x[67, 99] <= 25)
   @constraint(model, x[68, 72] <= 5)
   @constraint(model, x[68, 76] <= 9)
   @constraint(model, x[68, 84] <= 8)
   @constraint(model, x[68, 100] <= 12)
   @constraint(model, x[69, 70] <= 15)
   @constraint(model, x[69, 71] <= 4)
   @constraint(model, x[69, 77] <= 15)
   @constraint(model, x[69, 85] <= 14)
   @constraint(model, x[69, 101] <= 23)
   @constraint(model, x[70, 72] <= 6)
   @constraint(model, x[70, 78] <= 10)
   @constraint(model, x[70, 86] <= 9)
   @constraint(model, x[70, 102] <= 13)
   @constraint(model, x[71, 72] <= 11)
   @constraint(model, x[71, 79] <= 12)
   @constraint(model, x[71, 87] <= 8)
   @constraint(model, x[71, 103] <= 16)
   @constraint(model, x[72, 80] <= 4)
   @constraint(model, x[72, 88] <= 8)
   @constraint(model, x[72, 104] <= 32)
   @constraint(model, x[73, 74] <= 18)
   @constraint(model, x[73, 75] <= 26)
   @constraint(model, x[73, 77] <= 24)
   @constraint(model, x[73, 89] <= 20)
   @constraint(model, x[73, 105] <= 30)
   @constraint(model, x[74, 76] <= 5)
   @constraint(model, x[74, 78] <= 7)
   @constraint(model, x[74, 90] <= 12)
   @constraint(model, x[74, 106] <= 5)
   @constraint(model, x[75, 76] <= 5)
   @constraint(model, x[75, 79] <= 2)
   @constraint(model, x[75, 91] <= 2)
   @constraint(model, x[75, 107] <= 3)
   @constraint(model, x[76, 80] <= 7)
   @constraint(model, x[76, 92] <= 8)
   @constraint(model, x[76, 108] <= 26)
   @constraint(model, x[77, 78] <= 14)
   @constraint(model, x[77, 79] <= 2)
   @constraint(model, x[77, 93] <= 3)
   @constraint(model, x[77, 109] <= 16)
   @constraint(model, x[78, 80] <= 16)
   @constraint(model, x[78, 94] <= 11)
   @constraint(model, x[78, 110] <= 29)
   @constraint(model, x[79, 80] <= 8)
   @constraint(model, x[79, 95] <= 2)
   @constraint(model, x[79, 111] <= 10)
   @constraint(model, x[80, 96] <= 24)
   @constraint(model, x[80, 112] <= 4)
   @constraint(model, x[81, 82] <= 3)
   @constraint(model, x[81, 83] <= 2)
   @constraint(model, x[81, 85] <= 25)
   @constraint(model, x[81, 89] <= 3)
   @constraint(model, x[81, 113] <= 6)
   @constraint(model, x[82, 84] <= 13)
   @constraint(model, x[82, 86] <= 3)
   @constraint(model, x[82, 90] <= 3)
   @constraint(model, x[82, 114] <= 10)
   @constraint(model, x[83, 84] <= 9)
   @constraint(model, x[83, 87] <= 7)
   @constraint(model, x[83, 91] <= 2)
   @constraint(model, x[83, 115] <= 2)
   @constraint(model, x[84, 88] <= 28)
   @constraint(model, x[84, 92] <= 14)
   @constraint(model, x[84, 116] <= 20)
   @constraint(model, x[85, 86] <= 9)
   @constraint(model, x[85, 87] <= 2)
   @constraint(model, x[85, 93] <= 2)
   @constraint(model, x[85, 117] <= 5)
   @constraint(model, x[86, 88] <= 6)
   @constraint(model, x[86, 94] <= 3)
   @constraint(model, x[86, 118] <= 16)
   @constraint(model, x[87, 88] <= 4)
   @constraint(model, x[87, 95] <= 2)
   @constraint(model, x[87, 119] <= 12)
   @constraint(model, x[88, 96] <= 47)
   @constraint(model, x[88, 120] <= 1)
   @constraint(model, x[89, 90] <= 1)
   @constraint(model, x[89, 91] <= 7)
   @constraint(model, x[89, 93] <= 11)
   @constraint(model, x[89, 121] <= 10)
   @constraint(model, x[90, 92] <= 3)
   @constraint(model, x[90, 94] <= 28)
   @constraint(model, x[90, 122] <= 14)
   @constraint(model, x[91, 92] <= 20)
   @constraint(model, x[91, 95] <= 7)
   @constraint(model, x[91, 123] <= 3)
   @constraint(model, x[92, 96] <= 61)
   @constraint(model, x[92, 124] <= 40)
   @constraint(model, x[93, 94] <= 6)
   @constraint(model, x[93, 95] <= 3)
   @constraint(model, x[93, 125] <= 10)
   @constraint(model, x[94, 96] <= 18)
   @constraint(model, x[94, 126] <= 30)
   @constraint(model, x[95, 96] <= 54)
   @constraint(model, x[95, 127] <= 3)
   @constraint(model, x[96, 128] <= 79)
   @constraint(model, x[97, 98] <= 20)
   @constraint(model, x[97, 99] <= 5)
   @constraint(model, x[97, 101] <= 27)
   @constraint(model, x[97, 105] <= 4)
   @constraint(model, x[97, 113] <= 1)
   @constraint(model, x[98, 100] <= 16)
   @constraint(model, x[98, 102] <= 14)
   @constraint(model, x[98, 106] <= 10)
   @constraint(model, x[98, 114] <= 16)
   @constraint(model, x[99, 100] <= 9)
   @constraint(model, x[99, 103] <= 1)
   @constraint(model, x[99, 107] <= 12)
   @constraint(model, x[99, 115] <= 1)
   @constraint(model, x[100, 104] <= 11)
   @constraint(model, x[100, 108] <= 21)
   @constraint(model, x[100, 116] <= 24)
   @constraint(model, x[101, 102] <= 4)
   @constraint(model, x[101, 103] <= 1)
   @constraint(model, x[101, 109] <= 14)
   @constraint(model, x[101, 117] <= 10)
   @constraint(model, x[102, 104] <= 10)
   @constraint(model, x[102, 110] <= 1)
   @constraint(model, x[102, 118] <= 20)
   @constraint(model, x[103, 104] <= 1)
   @constraint(model, x[103, 111] <= 32)
   @constraint(model, x[103, 119] <= 12)
   @constraint(model, x[104, 112] <= 52)
   @constraint(model, x[104, 120] <= 46)
   @constraint(model, x[105, 106] <= 15)
   @constraint(model, x[105, 107] <= 3)
   @constraint(model, x[105, 109] <= 6)
   @constraint(model, x[105, 121] <= 3)
   @constraint(model, x[106, 108] <= 19)
   @constraint(model, x[106, 110] <= 5)
   @constraint(model, x[106, 122] <= 7)
   @constraint(model, x[107, 108] <= 17)
   @constraint(model, x[107, 111] <= 7)
   @constraint(model, x[107, 123] <= 7)
   @constraint(model, x[108, 112] <= 17)
   @constraint(model, x[108, 124] <= 14)
   @constraint(model, x[109, 110] <= 18)
   @constraint(model, x[109, 111] <= 6)
   @constraint(model, x[109, 125] <= 29)
   @constraint(model, x[110, 112] <= 45)
   @constraint(model, x[110, 126] <= 53)
   @constraint(model, x[111, 112] <= 35)
   @constraint(model, x[111, 127] <= 42)
   @constraint(model, x[112, 128] <= 50)
   @constraint(model, x[113, 114] <= 16)
   @constraint(model, x[113, 115] <= 7)
   @constraint(model, x[113, 117] <= 3)
   @constraint(model, x[113, 121] <= 5)
   @constraint(model, x[114, 116] <= 12)
   @constraint(model, x[114, 118] <= 2)
   @constraint(model, x[114, 122] <= 30)
   @constraint(model, x[115, 116] <= 31)
   @constraint(model, x[115, 119] <= 27)
   @constraint(model, x[115, 123] <= 6)
   @constraint(model, x[116, 120] <= 10)
   @constraint(model, x[116, 124] <= 10)
   @constraint(model, x[117, 118] <= 4)
   @constraint(model, x[117, 119] <= 19)
   @constraint(model, x[117, 125] <= 10)
   @constraint(model, x[118, 120] <= 25)
   @constraint(model, x[118, 126] <= 37)
   @constraint(model, x[119, 120] <= 60)
   @constraint(model, x[119, 127] <= 26)
   @constraint(model, x[120, 128] <= 34)
   @constraint(model, x[121, 122] <= 13)
   @constraint(model, x[121, 123] <= 12)
   @constraint(model, x[121, 125] <= 5)
   @constraint(model, x[122, 124] <= 59)
   @constraint(model, x[122, 126] <= 63)
   @constraint(model, x[123, 124] <= 3)
   @constraint(model, x[123, 127] <= 51)
   @constraint(model, x[124, 128] <= 44)
   @constraint(model, x[125, 126] <= 37)
   @constraint(model, x[125, 127] <= 62)
   @constraint(model, x[126, 128] <= 123)
   @constraint(model, x[127, 128] <= 68)

    # Flow must be balanced
   @constraint(model, [i = 2:127], sum(x[i, :]) == sum(x[:, i]))
    @constraint(model, sum(x[1, :])  == sum(x[:, 128]))
    # Trying to maximize the flow
    @objective(model, Max, sum(x[1, :]))

    optimize!(model)
    println(Int64(objective_value(model)))
end

println(@elapsed model())
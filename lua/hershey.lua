--luacheck: no max line length
--[[
Hershey font data for Lua

The Hershey Fonts were originally created by Dr. A. V. Hershey while working at
the U.S. National Bureau of Standards.
]]

local font = {}

-- x is in range: 0->26
-- y is in range: 0->32
font[" "] =  { w=16,   }
font["!"] =  { w=10,   5, 28, 5, 14, false, false, 5, 9, 4, 8, 5, 7, 6, 8, 5, 9 }
font["#"] =  { w=21,   11, 32, 4, 0, false, false, 17, 32, 10, 0, false, false, 4, 19, 18, 19, false, false, 3, 13, 17, 13 }
font["$"] =  { w=20,   8, 32, 8, 3, false, false, 12, 32, 12, 3, false, false, 17, 25, 15, 27, 12, 28, 8, 28, 5, 27, 3, 25, 3, 23, 4, 21, 5, 20, 7, 19, 13, 17, 15, 16, 16, 15, 17, 13, 17, 10, 15, 8, 12, 7, 8, 7, 5, 8, 3, 10 }
font["%"] =  { w=24,   21, 28, 3, 7, false, false, 8, 28, 10, 26, 10, 24, 9, 22, 7, 21, 5, 21, 3, 23, 3, 25, 4, 27, 6, 28, 8, 28, 10, 27, 13, 26, 16, 26, 19, 27, 21, 28, false, false, 17, 14, 15, 13, 14, 11, 14, 9, 16, 7, 18, 7, 20, 8, 21, 10, 21, 12, 19, 14, 17, 14 }
font["&"] =  { w=26,   23, 19, 23, 20, 22, 21, 21, 21, 20, 20, 19, 18, 17, 13, 15, 10, 13, 8, 11, 7, 7, 7, 5, 8, 4, 9, 3, 11, 3, 13, 4, 15, 5, 16, 12, 20, 13, 21, 14, 23, 14, 25, 13, 27, 11, 28, 9, 27, 8, 25, 8, 23, 9, 20, 11, 17, 16, 10, 18, 8, 20, 7, 22, 7, 23, 8, 23, 9 }
font["'"] =  { w=10,   5, 26, 4, 27, 5, 28, 6, 27, 6, 25, 5, 23, 4, 22 }
font["("] =  { w=14,   11, 32, 9, 30, 7, 27, 5, 23, 4, 18, 4, 14, 5, 9, 7, 5, 9, 2, 11, 0 }
font[")"] =  { w=14,   3, 32, 5, 30, 7, 27, 9, 23, 10, 18, 10, 14, 9, 9, 7, 5, 5, 2, 3, 0 }
font["*"] =  { w=16,   8, 28, 8, 16, false, false, 3, 25, 13, 19, false, false, 13, 25, 3, 19 }
font["+"] =  { w=26,   13, 25, 13, 7, false, false, 4, 16, 22, 16 }
font[","] =  { w=10,   6, 8, 5, 7, 4, 8, 5, 9, 6, 8, 6, false, 5, 4, 4, 3 }
font["-"] =  { w=26,   4, 16, 22, 16 }
font["."] =  { w=10,   5, 9, 4, 8, 5, 7, 6, 8, 5, 9 }
font["/"] =  { w=22,   20, 32, 2, 0 }
font["0"] =  { w=20,   9, 28, 6, 27, 4, 24, 3, 19, 3, 16, 4, 11, 6, 8, 9, 7, 11, 7, 14, 8, 16, 11, 17, 16, 17, 19, 16, 24, 14, 27, 11, 28, 9, 28 }
font["1"] =  { w=20,   6, 24, 8, 25, 11, 28, 11, 7 }
font["2"] =  { w=20,   4, 23, 4, 24, 5, 26, 6, 27, 8, 28, 12, 28, 14, 27, 15, 26, 16, 24, 16, 22, 15, 20, 13, 17, 3, 7, 17, 7 }
font["3"] =  { w=20,   5, 28, 16, 28, 10, 20, 13, 20, 15, 19, 16, 18, 17, 15, 17, 13, 16, 10, 14, 8, 11, 7, 8, 7, 5, 8, 4, 9, 3, 11 }
font["4"] =  { w=20,   13, 28, 3, 14, 18, 14, false, false, 13, 28, 13, 7 }
font["5"] =  { w=20,   15, 28, 5, 28, 4, 19, 5, 20, 8, 21, 11, 21, 14, 20, 16, 18, 17, 15, 17, 13, 16, 10, 14, 8, 11, 7, 8, 7, 5, 8, 4, 9, 3, 11 }
font["6"] =  { w=20,   16, 25, 15, 27, 12, 28, 10, 28, 7, 27, 5, 24, 4, 19, 4, 14, 5, 10, 7, 8, 10, 7, 11, 7, 14, 8, 16, 10, 17, 13, 17, 14, 16, 17, 14, 19, 11, 20, 10, 20, 7, 19, 5, 17, 4, 14 }
font["7"] =  { w=20,   17, 28, 7, 7, false, false, 3, 28, 17, 28 }
font["8"] =  { w=20,   8, 28, 5, 27, 4, 25, 4, 23, 5, 21, 7, 20, 11, 19, 14, 18, 16, 16, 17, 14, 17, 11, 16, 9, 15, 8, 12, 7, 8, 7, 5, 8, 4, 9, 3, 11, 3, 14, 4, 16, 6, 18, 9, 19, 13, 20, 15, 21, 16, 23, 16, 25, 15, 27, 12, 28, 8, 28 }
font["9"] =  { w=20,   16, 21, 15, 18, 13, 16, 10, 15, 9, 15, 6, 16, 4, 18, 3, 21, 3, 22, 4, 25, 6, 27, 9, 28, 10, 28, 13, 27, 15, 25, 16, 21, 16, 16, 15, 11, 13, 8, 10, 7, 8, 7, 5, 8, 4, 10 }
font[":"] =  { w=10,   5, 21, 4, 20, 5, 19, 6, 20, 5, 21, false, false, 5, 9, 4, 8, 5, 7, 6, 8, 5, 9 }
font[";"] =  { w=10,   5, 21, 4, 20, 5, 19, 6, 20, 5, 21, false, false, 6, 8, 5, 7, 4, 8, 5, 9, 6, 8, 6, false, 5, 4, 4, 3 }
font["<"] =  { w=24,   20, 25, 4, 16, 20, 7 }
font["="] =  { w=26,   4, 19, 22, 19, false, false, 4, 13, 22, 13 }
font[">"] =  { w=24,   4, 25, 20, 16, 4, 7 }
font["?"] =  { w=18,   3, 23, 3, 24, 4, 26, 5, 27, 7, 28, 11, 28, 13, 27, 14, 26, 15, 24, 15, 22, 14, 20, 13, 19, 9, 17, 9, 14, false, false, 9, 9, 8, 8, 9, 7, 10, 8, 9, 9 }
font["@"] =  { w=27,   18, 20, 17, 22, 15, 23, 12, 23, 10, 22, 9, 21, 8, 18, 8, 15, 9, 13, 11, 12, 14, 12, 16, 13, 17, 15, false, false, 12, 23, 10, 21, 9, 18, 9, 15, 10, 13, 11, 12, false, false, 18, 23, 17, 15, 17, 13, 19, 12, 21, 12, 23, 14, 24, 17, 24, 19, 23, 22, 22, 24, 20, 26, 18, 27, 15, 28, 12, 28, 9, 27, 7, 26, 5, 24, 4, 22, 3, 19, 3, 16, 4, 13, 5, 11, 7, 9, 9, 8, 12, 7, 15, 7, 18, 8, 20, 9, 21, 10, false, false, 19, 23, 18, 15, 18, 13, 19, 12 }
font["A"] =  { w=18,   9, 28, 1, 7, false, false, 9, 28, 17, 7, false, false, 4, 14, 14, 14 }
font["B"] =  { w=21,   4, 28, 4, 7, false, false, 4, 28, 13, 28, 16, 27, 17, 26, 18, 24, 18, 22, 17, 20, 16, 19, 13, 18, false, false, 4, 18, 13, 18, 16, 17, 17, 16, 18, 14, 18, 11, 17, 9, 16, 8, 13, 7, 4, 7 }
font["C"] =  { w=21,   18, 23, 17, 25, 15, 27, 13, 28, 9, 28, 7, 27, 5, 25, 4, 23, 3, 20, 3, 15, 4, 12, 5, 10, 7, 8, 9, 7, 13, 7, 15, 8, 17, 10, 18, 12 }
font["D"] =  { w=21,   4, 28, 4, 7, false, false, 4, 28, 11, 28, 14, 27, 16, 25, 17, 23, 18, 20, 18, 15, 17, 12, 16, 10, 14, 8, 11, 7, 4, 7 }
font["E"] =  { w=19,   4, 28, 4, 7, false, false, 4, 28, 17, 28, false, false, 4, 18, 12, 18, false, false, 4, 7, 17, 7 }
font["F"] =  { w=18,   4, 28, 4, 7, false, false, 4, 28, 17, 28, false, false, 4, 18, 12, 18 }
font["G"] =  { w=21,   18, 23, 17, 25, 15, 27, 13, 28, 9, 28, 7, 27, 5, 25, 4, 23, 3, 20, 3, 15, 4, 12, 5, 10, 7, 8, 9, 7, 13, 7, 15, 8, 17, 10, 18, 12, 18, 15, false, false, 13, 15, 18, 15 }
font["H"] =  { w=22,   4, 28, 4, 7, false, false, 18, 28, 18, 7, false, false, 4, 18, 18, 18 }
font["I"] =  { w= 8,   4, 28, 4, 7 }
font["J"] =  { w=16,   12, 28, 12, 12, 11, 9, 10, 8, 8, 7, 6, 7, 4, 8, 3, 9, 2, 12, 2, 14 }
font["K"] =  { w=21,   4, 28, 4, 7, false, false, 18, 28, 4, 14, false, false, 9, 19, 18, 7 }
font["L"] =  { w=17,   4, 28, 4, 7, false, false, 4, 7, 16, 7 }
font["M"] =  { w=24,   4, 28, 4, 7, false, false, 4, 28, 12, 7, false, false, 20, 28, 12, 7, false, false, 20, 28, 20, 7 }
font["N"] =  { w=22,   4, 28, 4, 7, false, false, 4, 28, 18, 7, false, false, 18, 28, 18, 7 }
font["O"] =  { w=22,   9, 28, 7, 27, 5, 25, 4, 23, 3, 20, 3, 15, 4, 12, 5, 10, 7, 8, 9, 7, 13, 7, 15, 8, 17, 10, 18, 12, 19, 15, 19, 20, 18, 23, 17, 25, 15, 27, 13, 28, 9, 28 }
font["P"] =  { w=21,   4, 28, 4, 7, false, false, 4, 28, 13, 28, 16, 27, 17, 26, 18, 24, 18, 21, 17, 19, 16, 18, 13, 17, 4, 17 }
font["Q"] =  { w=22,   9, 28, 7, 27, 5, 25, 4, 23, 3, 20, 3, 15, 4, 12, 5, 10, 7, 8, 9, 7, 13, 7, 15, 8, 17, 10, 18, 12, 19, 15, 19, 20, 18, 23, 17, 25, 15, 27, 13, 28, 9, 28, false, false, 12, 11, 18, 5 }
font["R"] =  { w=21,   4, 28, 4, 7, false, false, 4, 28, 13, 28, 16, 27, 17, 26, 18, 24, 18, 22, 17, 20, 16, 19, 13, 18, 4, 18, false, false, 11, 18, 18, 7 }
font["S"] =  { w=20,   17, 25, 15, 27, 12, 28, 8, 28, 5, 27, 3, 25, 3, 23, 4, 21, 5, 20, 7, 19, 13, 17, 15, 16, 16, 15, 17, 13, 17, 10, 15, 8, 12, 7, 8, 7, 5, 8, 3, 10 }
font["T"] =  { w=16,   8, 28, 8, 7, false, false, 1, 28, 15, 28 }
font["U"] =  { w=22,   4, 28, 4, 13, 5, 10, 7, 8, 10, 7, 12, 7, 15, 8, 17, 10, 18, 13, 18, 28 }
font["V"] =  { w=18,   1, 28, 9, 7, false, false, 17, 28, 9, 7 }
font["W"] =  { w=24,   2, 28, 7, 7, false, false, 12, 28, 7, 7, false, false, 12, 28, 17, 7, false, false, 22, 28, 17, 7 }
font["X"] =  { w=20,   3, 28, 17, 7, false, false, 17, 28, 3, 7 }
font["Y"] =  { w=18,   1, 28, 9, 18, 9, 7, false, false, 17, 28, 9, 18 }
font["Z"] =  { w=20,   17, 28, 3, 7, false, false, 3, 28, 17, 28, false, false, 3, 7, 17, 7 }
font["["] =  { w=14,   4, 32, 4, 0, false, false, 5, 32, 5, 0, false, false, 4, 32, 11, 32, false, false, 4, 0, 11, 0 }
font["\""] = { w=16,   4, 28, 4, 21, false, false, 12, 28, 12, 21 }
font["\\"] = { w=14,   0, 28, 14, 4 }
font["]"] =  { w=14,   9, 32, 9, 0, false, false, 10, 32, 10, 0, false, false, 3, 32, 10, 32, false, false, 3, 0, 10, 0 }
font["^"] =  { w=16,   6, 22, 8, 25, 10, 22, false, false, 3, 19, 8, 24, 13, 19, false, false, 8, 24, 8, 7 }
font["_"] =  { w=16,   0, 5, 16, 5 }
font["`"] =  { w=10,   6, 28, 5, 27, 4, 25, 4, 23, 5, 22, 6, 23, 5, 24 }
font["a"] =  { w=19,   15, 21, 15, 7, false, false, 15, 18, 13, 20, 11, 21, 8, 21, 6, 20, 4, 18, 3, 15, 3, 13, 4, 10, 6, 8, 8, 7, 11, 7, 13, 8, 15, 10 }
font["b"] =  { w=19,   4, 28, 4, 7, false, false, 4, 18, 6, 20, 8, 21, 11, 21, 13, 20, 15, 18, 16, 15, 16, 13, 15, 10, 13, 8, 11, 7, 8, 7, 6, 8, 4, 10 }
font["c"] =  { w=18,   15, 18, 13, 20, 11, 21, 8, 21, 6, 20, 4, 18, 3, 15, 3, 13, 4, 10, 6, 8, 8, 7, 11, 7, 13, 8, 15, 10 }
font["d"] =  { w=19,   15, 28, 15, 7, false, false, 15, 18, 13, 20, 11, 21, 8, 21, 6, 20, 4, 18, 3, 15, 3, 13, 4, 10, 6, 8, 8, 7, 11, 7, 13, 8, 15, 10 }
font["e"] =  { w=18,   3, 15, 15, 15, 15, 17, 14, 19, 13, 20, 11, 21, 8, 21, 6, 20, 4, 18, 3, 15, 3, 13, 4, 10, 6, 8, 8, 7, 11, 7, 13, 8, 15, 10 }
font["f"] =  { w=12,   10, 28, 8, 28, 6, 27, 5, 24, 5, 7, false, false, 2, 21, 9, 21 }
font["g"] =  { w=19,   15, 21, 15, 5, 14, 2, 13, 1, 11, 0, 8, 0, 6, 1, false, false, 15, 18, 13, 20, 11, 21, 8, 21, 6, 20, 4, 18, 3, 15, 3, 13, 4, 10, 6, 8, 8, 7, 11, 7, 13, 8, 15, 10 }
font["h"] =  { w=19,   4, 28, 4, 7, false, false, 4, 17, 7, 20, 9, 21, 12, 21, 14, 20, 15, 17, 15, 7 }
font["i"] =  { w= 8,   3, 28, 4, 27, 5, 28, 4, 29, 3, 28, false, false, 4, 21, 4, 7 }
font["j"] =  { w=10,   5, 28, 6, 27, 7, 28, 6, 29, 5, 28, false, false, 6, 21, 6, 4, 5, 1, 3, 0, 1, 0 }
font["k"] =  { w=17,   4, 28, 4, 7, false, false, 14, 21, 4, 11, false, false, 8, 15, 15, 7 }
font["l"] =  { w= 8,   4, 28, 4, 7 }
font["m"] =  { w=30,   4, 21, 4, 7, false, false, 4, 17, 7, 20, 9, 21, 12, 21, 14, 20, 15, 17, 15, 7, false, false, 15, 17, 18, 20, 20, 21, 23, 21, 25, 20, 26, 17, 26, 7 }
font["n"] =  { w=19,   4, 21, 4, 7, false, false, 4, 17, 7, 20, 9, 21, 12, 21, 14, 20, 15, 17, 15, 7 }
font["o"] =  { w=19,   8, 21, 6, 20, 4, 18, 3, 15, 3, 13, 4, 10, 6, 8, 8, 7, 11, 7, 13, 8, 15, 10, 16, 13, 16, 15, 15, 18, 13, 20, 11, 21, 8, 21 }
font["p"] =  { w=19,   4, 21, 4, 0, false, false, 4, 18, 6, 20, 8, 21, 11, 21, 13, 20, 15, 18, 16, 15, 16, 13, 15, 10, 13, 8, 11, 7, 8, 7, 6, 8, 4, 10 }
font["q"] =  { w=19,   15, 21, 15, 0, false, false, 15, 18, 13, 20, 11, 21, 8, 21, 6, 20, 4, 18, 3, 15, 3, 13, 4, 10, 6, 8, 8, 7, 11, 7, 13, 8, 15, 10 }
font["r"] =  { w=13,   4, 21, 4, 7, false, false, 4, 15, 5, 18, 7, 20, 9, 21, 12, 21 }
font["s"] =  { w=17,   14, 18, 13, 20, 10, 21, 7, 21, 4, 20, 3, 18, 4, 16, 6, 15, 11, 14, 13, 13, 14, 11, 14, 10, 13, 8, 10, 7, 7, 7, 4, 8, 3, 10 }
font["t"] =  { w=12,   5, 28, 5, 11, 6, 8, 8, 7, 10, 7, false, false, 2, 21, 9, 21 }
font["u"] =  { w=19,   4, 21, 4, 11, 5, 8, 7, 7, 10, 7, 12, 8, 15, 11, false, false, 15, 21, 15, 7 }
font["v"] =  { w=16,   2, 21, 8, 7, false, false, 14, 21, 8, 7 }
font["w"] =  { w=22,   3, 21, 7, 7, false, false, 11, 21, 7, 7, false, false, 11, 21, 15, 7, false, false, 19, 21, 15, 7 }
font["x"] =  { w=17,   3, 21, 14, 7, false, false, 14, 21, 3, 7 }
font["y"] =  { w=16,   2, 21, 8, 7, false, false, 14, 21, 8, 7, 6, 3, 4, 1, 2, 0, 1, 0 }
font["z"] =  { w=17,   14, 21, 3, 7, false, false, 3, 21, 14, 21, false, false, 3, 7, 14, 7 }
font["{"] =  { w=14,   9, 32, 7, 31, 6, 30, 5, 28, 5, 26, 6, 24, 7, 23, 8, 21, 8, 19, 6, 17, false, false, 7, 31, 6, 29, 6, 27, 7, 25, 8, 24, 9, 22, 9, 20, 8, 18, 4, 16, 8, 14, 9, 12, 9, 10, 8, 8, 7, 7, 6, 5, 6, 3, 7, 1, false, false, 6, 15, 8, 13, 8, 11, 7, 9, 6, 8, 5, false, 5, 4, 6, 2, 7, 1, 9, 0 }
font["|"] =  { w= 8,   4, 32, 4, 0 }
font["}"] =  { w=14,   5, 32, 7, 31, 8, 30, 9, 28, 9, 26, 8, 24, 7, 23, 6, 21, 6, 19, 8, 17, false, false, 7, 31, 8, 29, 8, 27, 7, 25, 6, 24, 5, 22, 5, 20, 6, 18, 10, 16, 6, 14, 5, 12, 5, 10, 6, 8, 7, 7, 8, 5, 8, 3, 7, 1, false, false, 8, 15, 6, 13, 6, 11, 7, 9, 8, 8, 9, false, 9, 4, 8, 2, 7, 1, 5, 0 }
font["~"] =  { w=24,   3, 13, 3, 15, 4, 18, 6, 19, 8, 19, 10, 18, 14, 15, 16, 14, 18, 14, 20, 15, 21, 17, false, false, 3, 15, 4, 17, 6, 18, 8, 18, 10, 17, 14, 14, 16, 13, 18, 13, 20, 14, 21, 17, 21, 19 }

function font:serialize()
	local serialized = {}
	local x_min,y_min = math.huge,math.huge
	local x_max,y_max = -math.huge,-math.huge
	for k,v in pairs(self) do
		if type(v) == "table" then
			local new_t = {}
			for i=1, #v,2 do
				local x = v[i]
				local y = v[i+1]
				x_min, y_min = math.min(x or math.huge, x_min),math.min(y or math.huge, y_min)
				x_max, y_max = math.max(x or -math.huge, x_max),math.max(y or -math.huge, y_max)
				table.insert(new_t, tostring(x))
				table.insert(new_t, tostring(y))
			end
			table.insert(serialized, ("font[%q] =  { w=%2d,   %s }"):format(k, v.w, table.concat(new_t, ", ")))
		end
	end
	table.sort(serialized)
	table.insert(serialized, "-- x is in range: "..x_min.."->"..x_max)
	table.insert(serialized, "-- y is in range: "..y_min.."->"..y_max)
	return table.concat(serialized, "\n")
end

-- append a character to a list of lists of line points.
-- each line is a list of x,y coordinates
function font:char_to_lines(char, lines, x_offset, y_offset, scale)
	local glyph = assert(self[char])
	x_offset, y_offset = tonumber(x_offset) or 0, tonumber(y_offset) or 0
	scale = tonumber(scale) or 1
	lines = lines or {}
	local cline = {}
	for i=1, #glyph,2 do
		local vx = glyph[i]
		local vy = glyph[i+1]
		if vx and vy then
			cline[#cline+1] = x_offset + vx*scale
			cline[#cline+1] = y_offset - vy*scale
		else
			lines[#lines+1] = cline
			cline = {}
		end
	end
	if #cline>0 then
		lines[#lines+1] = cline
	end
	return lines, glyph
end


-- get a list of lines for the specified text string.
-- uses font:char_to_lines, lines is a list of tables with x,y coordinates
function font:text_to_lines(text, char_spacing, scale, x_offset, y_offset)
	char_spacing = tonumber(char_spacing) or 0
	scale = tonumber(scale) or 1
	x_offset, y_offset = tonumber(x_offset) or 0, tonumber(y_offset) or 0
	local lines = {}
	local cx = 0
	for i=1, #text do
		local char = text:sub(i,i)
		local _, glyph = self:char_to_lines(char, lines, x_offset+cx, y_offset, scale)
		cx = cx + char_spacing*scale + glyph.w*scale
	end
	return lines, cx
end


-- get the length the text string would occopy when drawn(arguments are same as text_to_lines)
function font:get_text_length(text, char_spacing, scale)
	char_spacing = tonumber(char_spacing) or 0
	scale = tonumber(scale) or 1
	local cx = 0
	for i=1, #text do
		local char = text:sub(i,i)
		local glyph = assert(self[char])
		cx = cx + char_spacing*scale + glyph.w*scale
	end
	return cx
end


return font

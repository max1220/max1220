--[[
These palettes are used to map the 24-bit rgb color values to the
limited terminal color space. This also contains the ansi escape codes.

Different terminal emulators have different mappings, especially for the
3bit/4bit mappings, and we always have 24-bit color as input, so we chose
the escape code by the minimal distance to the

The 8-bit color codes are generated by these code snippets:

function greys_8bit(esc)
 for i=1, 24 do
  local b = math.floor((i/26)*255)
  io.write(("\t{ r = %.3d, g = %.3d, b = %.3d, code = \"%s\" },\n"):format( b, b, b, esc:format(231+i) ))
 end
end
function colors_8bit(esc)
for r=0,5 do for g=0,5 do for b=0,5 do
  local index = 36*r+6*g+b+16
  io.write(("\t{ r = %.3d, g = %.3d, b = %.3d, code = \"%s\"},\n"):format( r*51, g*51, b*51, esc:format(index)))
 end end end
end

-- output fg codes
print("fg_palette_8bit = {")
greys_8bit("\\027[38;5;%dm")
colors_8bit("\\027[38;5;%dm")
print("}")

-- output bg codes
print("bg_palette_8bit = {")
greys_8bit("\\027[48;5;%dm")
colors_8bit("\\027[48;5;%dm")
print("}")
]]

local palettes = {
	fg_palette_3bit = {
		{ r =   0, g =   0, b =   0, code = "\027[30m" },
		{ r = 255, g =   0, b =   0, code = "\027[31m" },
		{ r =   0, g = 255, b =   0, code = "\027[32m" },
		{ r = 255, g = 255, b =   0, code = "\027[33m" },
		{ r =   0, g =   0, b = 255, code = "\027[34m" },
		{ r = 255, g =   0, b = 255, code = "\027[35m" },
		{ r =   0, g = 255, b = 255, code = "\027[36m" },
		{ r = 255, g = 255, b = 255, code = "\027[37m" }
	},
	bg_palette_3bit =  {
		{ r =   0, g =   0, b =   0, code = "\027[40m" },
		{ r = 255, g =   0, b =   0, code = "\027[41m" },
		{ r =   0, g = 255, b =   0, code = "\027[42m" },
		{ r = 255, g = 255, b =   0, code = "\027[43m" },
		{ r =   0, g =   0, b = 255, code = "\027[44m" },
		{ r = 255, g =   0, b = 255, code = "\027[45m" },
		{ r =   0, g = 255, b = 255, code = "\027[46m" },
		{ r = 255, g = 255, b = 255, code = "\027[47m" }
	},
	fg_palette_4bit = {
		{ r =   0, g =   0, b =   0, code = "\027[30m" },
		{ r = 127, g =   0, b =   0, code = "\027[31m" },
		{ r =   0, g = 127, b =   0, code = "\027[32m" },
		{ r = 127, g = 127, b =   0, code = "\027[33m" },
		{ r =   0, g =   0, b = 127, code = "\027[34m" },
		{ r = 127, g =   0, b = 127, code = "\027[35m" },
		{ r =   0, g = 127, b = 127, code = "\027[36m" },
		{ r = 170, g = 170, b = 170, code = "\027[37m" },
		{ r =  85, g =  85, b =  85, code = "\027[90m" },
		{ r = 255, g =   0, b =   0, code = "\027[91m" },
		{ r =   0, g = 255, b =   0, code = "\027[92m" },
		{ r = 255, g = 255, b =   0, code = "\027[93m" },
		{ r =   0, g =   0, b = 255, code = "\027[94m" },
		{ r = 255, g =   0, b = 255, code = "\027[95m" },
		{ r =   0, g = 255, b = 255, code = "\027[96m" },
		{ r = 255, g = 255, b = 255, code = "\027[96m" }
	},
	bg_palette_4bit = {
		{ r =   0, g =   0, b =   0, code = "\027[40m" },
		{ r = 127, g =   0, b =   0, code = "\027[41m" },
		{ r =   0, g = 127, b =   0, code = "\027[42m" },
		{ r = 127, g = 127, b =   0, code = "\027[43m" },
		{ r =   0, g =   0, b = 127, code = "\027[44m" },
		{ r = 127, g =   0, b = 127, code = "\027[45m" },
		{ r =   0, g = 127, b = 127, code = "\027[46m" },
		{ r = 170, g = 170, b = 170, code = "\027[47m" },
		{ r =  85, g =  85, b =  85, code = "\027[100m" },
		{ r = 255, g =   0, b =   0, code = "\027[101m" },
		{ r =   0, g = 255, b =   0, code = "\027[102m" },
		{ r = 255, g = 255, b =   0, code = "\027[103m" },
		{ r =   0, g =   0, b = 255, code = "\027[104m" },
		{ r = 255, g =   0, b = 255, code = "\027[105m" },
		{ r =   0, g = 255, b = 255, code = "\027[106m" },
		{ r = 255, g = 255, b = 255, code = "\027[107m" }
	},
	fg_palette_8bit = {
		-- greys:
		{ r = 009, g = 009, b = 009, code = "\027[38;5;232m" },
		{ r = 019, g = 019, b = 019, code = "\027[38;5;233m" },
		{ r = 029, g = 029, b = 029, code = "\027[38;5;234m" },
		{ r = 039, g = 039, b = 039, code = "\027[38;5;235m" },
		{ r = 049, g = 049, b = 049, code = "\027[38;5;236m" },
		{ r = 058, g = 058, b = 058, code = "\027[38;5;237m" },
		{ r = 068, g = 068, b = 068, code = "\027[38;5;238m" },
		{ r = 078, g = 078, b = 078, code = "\027[38;5;239m" },
		{ r = 088, g = 088, b = 088, code = "\027[38;5;240m" },
		{ r = 098, g = 098, b = 098, code = "\027[38;5;241m" },
		{ r = 107, g = 107, b = 107, code = "\027[38;5;242m" },
		{ r = 117, g = 117, b = 117, code = "\027[38;5;243m" },
		{ r = 127, g = 127, b = 127, code = "\027[38;5;244m" },
		{ r = 137, g = 137, b = 137, code = "\027[38;5;245m" },
		{ r = 147, g = 147, b = 147, code = "\027[38;5;246m" },
		{ r = 156, g = 156, b = 156, code = "\027[38;5;247m" },
		{ r = 166, g = 166, b = 166, code = "\027[38;5;248m" },
		{ r = 176, g = 176, b = 176, code = "\027[38;5;249m" },
		{ r = 186, g = 186, b = 186, code = "\027[38;5;250m" },
		{ r = 196, g = 196, b = 196, code = "\027[38;5;251m" },
		{ r = 205, g = 205, b = 205, code = "\027[38;5;252m" },
		{ r = 215, g = 215, b = 215, code = "\027[38;5;253m" },
		{ r = 225, g = 225, b = 225, code = "\027[38;5;254m" },
		{ r = 235, g = 235, b = 235, code = "\027[38;5;255m" },
		-- colors:
		{ r = 000, g = 000, b = 000, code = "\027[38;5;16m"},
		{ r = 000, g = 000, b = 051, code = "\027[38;5;17m"},
		{ r = 000, g = 000, b = 102, code = "\027[38;5;18m"},
		{ r = 000, g = 000, b = 153, code = "\027[38;5;19m"},
		{ r = 000, g = 000, b = 204, code = "\027[38;5;20m"},
		{ r = 000, g = 000, b = 255, code = "\027[38;5;21m"},
		{ r = 000, g = 051, b = 000, code = "\027[38;5;22m"},
		{ r = 000, g = 051, b = 051, code = "\027[38;5;23m"},
		{ r = 000, g = 051, b = 102, code = "\027[38;5;24m"},
		{ r = 000, g = 051, b = 153, code = "\027[38;5;25m"},
		{ r = 000, g = 051, b = 204, code = "\027[38;5;26m"},
		{ r = 000, g = 051, b = 255, code = "\027[38;5;27m"},
		{ r = 000, g = 102, b = 000, code = "\027[38;5;28m"},
		{ r = 000, g = 102, b = 051, code = "\027[38;5;29m"},
		{ r = 000, g = 102, b = 102, code = "\027[38;5;30m"},
		{ r = 000, g = 102, b = 153, code = "\027[38;5;31m"},
		{ r = 000, g = 102, b = 204, code = "\027[38;5;32m"},
		{ r = 000, g = 102, b = 255, code = "\027[38;5;33m"},
		{ r = 000, g = 153, b = 000, code = "\027[38;5;34m"},
		{ r = 000, g = 153, b = 051, code = "\027[38;5;35m"},
		{ r = 000, g = 153, b = 102, code = "\027[38;5;36m"},
		{ r = 000, g = 153, b = 153, code = "\027[38;5;37m"},
		{ r = 000, g = 153, b = 204, code = "\027[38;5;38m"},
		{ r = 000, g = 153, b = 255, code = "\027[38;5;39m"},
		{ r = 000, g = 204, b = 000, code = "\027[38;5;40m"},
		{ r = 000, g = 204, b = 051, code = "\027[38;5;41m"},
		{ r = 000, g = 204, b = 102, code = "\027[38;5;42m"},
		{ r = 000, g = 204, b = 153, code = "\027[38;5;43m"},
		{ r = 000, g = 204, b = 204, code = "\027[38;5;44m"},
		{ r = 000, g = 204, b = 255, code = "\027[38;5;45m"},
		{ r = 000, g = 255, b = 000, code = "\027[38;5;46m"},
		{ r = 000, g = 255, b = 051, code = "\027[38;5;47m"},
		{ r = 000, g = 255, b = 102, code = "\027[38;5;48m"},
		{ r = 000, g = 255, b = 153, code = "\027[38;5;49m"},
		{ r = 000, g = 255, b = 204, code = "\027[38;5;50m"},
		{ r = 000, g = 255, b = 255, code = "\027[38;5;51m"},
		{ r = 051, g = 000, b = 000, code = "\027[38;5;52m"},
		{ r = 051, g = 000, b = 051, code = "\027[38;5;53m"},
		{ r = 051, g = 000, b = 102, code = "\027[38;5;54m"},
		{ r = 051, g = 000, b = 153, code = "\027[38;5;55m"},
		{ r = 051, g = 000, b = 204, code = "\027[38;5;56m"},
		{ r = 051, g = 000, b = 255, code = "\027[38;5;57m"},
		{ r = 051, g = 051, b = 000, code = "\027[38;5;58m"},
		{ r = 051, g = 051, b = 051, code = "\027[38;5;59m"},
		{ r = 051, g = 051, b = 102, code = "\027[38;5;60m"},
		{ r = 051, g = 051, b = 153, code = "\027[38;5;61m"},
		{ r = 051, g = 051, b = 204, code = "\027[38;5;62m"},
		{ r = 051, g = 051, b = 255, code = "\027[38;5;63m"},
		{ r = 051, g = 102, b = 000, code = "\027[38;5;64m"},
		{ r = 051, g = 102, b = 051, code = "\027[38;5;65m"},
		{ r = 051, g = 102, b = 102, code = "\027[38;5;66m"},
		{ r = 051, g = 102, b = 153, code = "\027[38;5;67m"},
		{ r = 051, g = 102, b = 204, code = "\027[38;5;68m"},
		{ r = 051, g = 102, b = 255, code = "\027[38;5;69m"},
		{ r = 051, g = 153, b = 000, code = "\027[38;5;70m"},
		{ r = 051, g = 153, b = 051, code = "\027[38;5;71m"},
		{ r = 051, g = 153, b = 102, code = "\027[38;5;72m"},
		{ r = 051, g = 153, b = 153, code = "\027[38;5;73m"},
		{ r = 051, g = 153, b = 204, code = "\027[38;5;74m"},
		{ r = 051, g = 153, b = 255, code = "\027[38;5;75m"},
		{ r = 051, g = 204, b = 000, code = "\027[38;5;76m"},
		{ r = 051, g = 204, b = 051, code = "\027[38;5;77m"},
		{ r = 051, g = 204, b = 102, code = "\027[38;5;78m"},
		{ r = 051, g = 204, b = 153, code = "\027[38;5;79m"},
		{ r = 051, g = 204, b = 204, code = "\027[38;5;80m"},
		{ r = 051, g = 204, b = 255, code = "\027[38;5;81m"},
		{ r = 051, g = 255, b = 000, code = "\027[38;5;82m"},
		{ r = 051, g = 255, b = 051, code = "\027[38;5;83m"},
		{ r = 051, g = 255, b = 102, code = "\027[38;5;84m"},
		{ r = 051, g = 255, b = 153, code = "\027[38;5;85m"},
		{ r = 051, g = 255, b = 204, code = "\027[38;5;86m"},
		{ r = 051, g = 255, b = 255, code = "\027[38;5;87m"},
		{ r = 102, g = 000, b = 000, code = "\027[38;5;88m"},
		{ r = 102, g = 000, b = 051, code = "\027[38;5;89m"},
		{ r = 102, g = 000, b = 102, code = "\027[38;5;90m"},
		{ r = 102, g = 000, b = 153, code = "\027[38;5;91m"},
		{ r = 102, g = 000, b = 204, code = "\027[38;5;92m"},
		{ r = 102, g = 000, b = 255, code = "\027[38;5;93m"},
		{ r = 102, g = 051, b = 000, code = "\027[38;5;94m"},
		{ r = 102, g = 051, b = 051, code = "\027[38;5;95m"},
		{ r = 102, g = 051, b = 102, code = "\027[38;5;96m"},
		{ r = 102, g = 051, b = 153, code = "\027[38;5;97m"},
		{ r = 102, g = 051, b = 204, code = "\027[38;5;98m"},
		{ r = 102, g = 051, b = 255, code = "\027[38;5;99m"},
		{ r = 102, g = 102, b = 000, code = "\027[38;5;100m"},
		{ r = 102, g = 102, b = 051, code = "\027[38;5;101m"},
		{ r = 102, g = 102, b = 102, code = "\027[38;5;102m"},
		{ r = 102, g = 102, b = 153, code = "\027[38;5;103m"},
		{ r = 102, g = 102, b = 204, code = "\027[38;5;104m"},
		{ r = 102, g = 102, b = 255, code = "\027[38;5;105m"},
		{ r = 102, g = 153, b = 000, code = "\027[38;5;106m"},
		{ r = 102, g = 153, b = 051, code = "\027[38;5;107m"},
		{ r = 102, g = 153, b = 102, code = "\027[38;5;108m"},
		{ r = 102, g = 153, b = 153, code = "\027[38;5;109m"},
		{ r = 102, g = 153, b = 204, code = "\027[38;5;110m"},
		{ r = 102, g = 153, b = 255, code = "\027[38;5;111m"},
		{ r = 102, g = 204, b = 000, code = "\027[38;5;112m"},
		{ r = 102, g = 204, b = 051, code = "\027[38;5;113m"},
		{ r = 102, g = 204, b = 102, code = "\027[38;5;114m"},
		{ r = 102, g = 204, b = 153, code = "\027[38;5;115m"},
		{ r = 102, g = 204, b = 204, code = "\027[38;5;116m"},
		{ r = 102, g = 204, b = 255, code = "\027[38;5;117m"},
		{ r = 102, g = 255, b = 000, code = "\027[38;5;118m"},
		{ r = 102, g = 255, b = 051, code = "\027[38;5;119m"},
		{ r = 102, g = 255, b = 102, code = "\027[38;5;120m"},
		{ r = 102, g = 255, b = 153, code = "\027[38;5;121m"},
		{ r = 102, g = 255, b = 204, code = "\027[38;5;122m"},
		{ r = 102, g = 255, b = 255, code = "\027[38;5;123m"},
		{ r = 153, g = 000, b = 000, code = "\027[38;5;124m"},
		{ r = 153, g = 000, b = 051, code = "\027[38;5;125m"},
		{ r = 153, g = 000, b = 102, code = "\027[38;5;126m"},
		{ r = 153, g = 000, b = 153, code = "\027[38;5;127m"},
		{ r = 153, g = 000, b = 204, code = "\027[38;5;128m"},
		{ r = 153, g = 000, b = 255, code = "\027[38;5;129m"},
		{ r = 153, g = 051, b = 000, code = "\027[38;5;130m"},
		{ r = 153, g = 051, b = 051, code = "\027[38;5;131m"},
		{ r = 153, g = 051, b = 102, code = "\027[38;5;132m"},
		{ r = 153, g = 051, b = 153, code = "\027[38;5;133m"},
		{ r = 153, g = 051, b = 204, code = "\027[38;5;134m"},
		{ r = 153, g = 051, b = 255, code = "\027[38;5;135m"},
		{ r = 153, g = 102, b = 000, code = "\027[38;5;136m"},
		{ r = 153, g = 102, b = 051, code = "\027[38;5;137m"},
		{ r = 153, g = 102, b = 102, code = "\027[38;5;138m"},
		{ r = 153, g = 102, b = 153, code = "\027[38;5;139m"},
		{ r = 153, g = 102, b = 204, code = "\027[38;5;140m"},
		{ r = 153, g = 102, b = 255, code = "\027[38;5;141m"},
		{ r = 153, g = 153, b = 000, code = "\027[38;5;142m"},
		{ r = 153, g = 153, b = 051, code = "\027[38;5;143m"},
		{ r = 153, g = 153, b = 102, code = "\027[38;5;144m"},
		{ r = 153, g = 153, b = 153, code = "\027[38;5;145m"},
		{ r = 153, g = 153, b = 204, code = "\027[38;5;146m"},
		{ r = 153, g = 153, b = 255, code = "\027[38;5;147m"},
		{ r = 153, g = 204, b = 000, code = "\027[38;5;148m"},
		{ r = 153, g = 204, b = 051, code = "\027[38;5;149m"},
		{ r = 153, g = 204, b = 102, code = "\027[38;5;150m"},
		{ r = 153, g = 204, b = 153, code = "\027[38;5;151m"},
		{ r = 153, g = 204, b = 204, code = "\027[38;5;152m"},
		{ r = 153, g = 204, b = 255, code = "\027[38;5;153m"},
		{ r = 153, g = 255, b = 000, code = "\027[38;5;154m"},
		{ r = 153, g = 255, b = 051, code = "\027[38;5;155m"},
		{ r = 153, g = 255, b = 102, code = "\027[38;5;156m"},
		{ r = 153, g = 255, b = 153, code = "\027[38;5;157m"},
		{ r = 153, g = 255, b = 204, code = "\027[38;5;158m"},
		{ r = 153, g = 255, b = 255, code = "\027[38;5;159m"},
		{ r = 204, g = 000, b = 000, code = "\027[38;5;160m"},
		{ r = 204, g = 000, b = 051, code = "\027[38;5;161m"},
		{ r = 204, g = 000, b = 102, code = "\027[38;5;162m"},
		{ r = 204, g = 000, b = 153, code = "\027[38;5;163m"},
		{ r = 204, g = 000, b = 204, code = "\027[38;5;164m"},
		{ r = 204, g = 000, b = 255, code = "\027[38;5;165m"},
		{ r = 204, g = 051, b = 000, code = "\027[38;5;166m"},
		{ r = 204, g = 051, b = 051, code = "\027[38;5;167m"},
		{ r = 204, g = 051, b = 102, code = "\027[38;5;168m"},
		{ r = 204, g = 051, b = 153, code = "\027[38;5;169m"},
		{ r = 204, g = 051, b = 204, code = "\027[38;5;170m"},
		{ r = 204, g = 051, b = 255, code = "\027[38;5;171m"},
		{ r = 204, g = 102, b = 000, code = "\027[38;5;172m"},
		{ r = 204, g = 102, b = 051, code = "\027[38;5;173m"},
		{ r = 204, g = 102, b = 102, code = "\027[38;5;174m"},
		{ r = 204, g = 102, b = 153, code = "\027[38;5;175m"},
		{ r = 204, g = 102, b = 204, code = "\027[38;5;176m"},
		{ r = 204, g = 102, b = 255, code = "\027[38;5;177m"},
		{ r = 204, g = 153, b = 000, code = "\027[38;5;178m"},
		{ r = 204, g = 153, b = 051, code = "\027[38;5;179m"},
		{ r = 204, g = 153, b = 102, code = "\027[38;5;180m"},
		{ r = 204, g = 153, b = 153, code = "\027[38;5;181m"},
		{ r = 204, g = 153, b = 204, code = "\027[38;5;182m"},
		{ r = 204, g = 153, b = 255, code = "\027[38;5;183m"},
		{ r = 204, g = 204, b = 000, code = "\027[38;5;184m"},
		{ r = 204, g = 204, b = 051, code = "\027[38;5;185m"},
		{ r = 204, g = 204, b = 102, code = "\027[38;5;186m"},
		{ r = 204, g = 204, b = 153, code = "\027[38;5;187m"},
		{ r = 204, g = 204, b = 204, code = "\027[38;5;188m"},
		{ r = 204, g = 204, b = 255, code = "\027[38;5;189m"},
		{ r = 204, g = 255, b = 000, code = "\027[38;5;190m"},
		{ r = 204, g = 255, b = 051, code = "\027[38;5;191m"},
		{ r = 204, g = 255, b = 102, code = "\027[38;5;192m"},
		{ r = 204, g = 255, b = 153, code = "\027[38;5;193m"},
		{ r = 204, g = 255, b = 204, code = "\027[38;5;194m"},
		{ r = 204, g = 255, b = 255, code = "\027[38;5;195m"},
		{ r = 255, g = 000, b = 000, code = "\027[38;5;196m"},
		{ r = 255, g = 000, b = 051, code = "\027[38;5;197m"},
		{ r = 255, g = 000, b = 102, code = "\027[38;5;198m"},
		{ r = 255, g = 000, b = 153, code = "\027[38;5;199m"},
		{ r = 255, g = 000, b = 204, code = "\027[38;5;200m"},
		{ r = 255, g = 000, b = 255, code = "\027[38;5;201m"},
		{ r = 255, g = 051, b = 000, code = "\027[38;5;202m"},
		{ r = 255, g = 051, b = 051, code = "\027[38;5;203m"},
		{ r = 255, g = 051, b = 102, code = "\027[38;5;204m"},
		{ r = 255, g = 051, b = 153, code = "\027[38;5;205m"},
		{ r = 255, g = 051, b = 204, code = "\027[38;5;206m"},
		{ r = 255, g = 051, b = 255, code = "\027[38;5;207m"},
		{ r = 255, g = 102, b = 000, code = "\027[38;5;208m"},
		{ r = 255, g = 102, b = 051, code = "\027[38;5;209m"},
		{ r = 255, g = 102, b = 102, code = "\027[38;5;210m"},
		{ r = 255, g = 102, b = 153, code = "\027[38;5;211m"},
		{ r = 255, g = 102, b = 204, code = "\027[38;5;212m"},
		{ r = 255, g = 102, b = 255, code = "\027[38;5;213m"},
		{ r = 255, g = 153, b = 000, code = "\027[38;5;214m"},
		{ r = 255, g = 153, b = 051, code = "\027[38;5;215m"},
		{ r = 255, g = 153, b = 102, code = "\027[38;5;216m"},
		{ r = 255, g = 153, b = 153, code = "\027[38;5;217m"},
		{ r = 255, g = 153, b = 204, code = "\027[38;5;218m"},
		{ r = 255, g = 153, b = 255, code = "\027[38;5;219m"},
		{ r = 255, g = 204, b = 000, code = "\027[38;5;220m"},
		{ r = 255, g = 204, b = 051, code = "\027[38;5;221m"},
		{ r = 255, g = 204, b = 102, code = "\027[38;5;222m"},
		{ r = 255, g = 204, b = 153, code = "\027[38;5;223m"},
		{ r = 255, g = 204, b = 204, code = "\027[38;5;224m"},
		{ r = 255, g = 204, b = 255, code = "\027[38;5;225m"},
		{ r = 255, g = 255, b = 000, code = "\027[38;5;226m"},
		{ r = 255, g = 255, b = 051, code = "\027[38;5;227m"},
		{ r = 255, g = 255, b = 102, code = "\027[38;5;228m"},
		{ r = 255, g = 255, b = 153, code = "\027[38;5;229m"},
		{ r = 255, g = 255, b = 204, code = "\027[38;5;230m"},
		{ r = 255, g = 255, b = 255, code = "\027[38;5;231m"},
	},
	bg_palette_8bit = {
		-- greys:
		{ r = 009, g = 009, b = 009, code = "\027[38;5;232m" },
		{ r = 019, g = 019, b = 019, code = "\027[38;5;233m" },
		{ r = 029, g = 029, b = 029, code = "\027[38;5;234m" },
		{ r = 039, g = 039, b = 039, code = "\027[38;5;235m" },
		{ r = 049, g = 049, b = 049, code = "\027[38;5;236m" },
		{ r = 058, g = 058, b = 058, code = "\027[38;5;237m" },
		{ r = 068, g = 068, b = 068, code = "\027[38;5;238m" },
		{ r = 078, g = 078, b = 078, code = "\027[38;5;239m" },
		{ r = 088, g = 088, b = 088, code = "\027[38;5;240m" },
		{ r = 098, g = 098, b = 098, code = "\027[38;5;241m" },
		{ r = 107, g = 107, b = 107, code = "\027[38;5;242m" },
		{ r = 117, g = 117, b = 117, code = "\027[38;5;243m" },
		{ r = 127, g = 127, b = 127, code = "\027[38;5;244m" },
		{ r = 137, g = 137, b = 137, code = "\027[38;5;245m" },
		{ r = 147, g = 147, b = 147, code = "\027[38;5;246m" },
		{ r = 156, g = 156, b = 156, code = "\027[38;5;247m" },
		{ r = 166, g = 166, b = 166, code = "\027[38;5;248m" },
		{ r = 176, g = 176, b = 176, code = "\027[38;5;249m" },
		{ r = 186, g = 186, b = 186, code = "\027[38;5;250m" },
		{ r = 196, g = 196, b = 196, code = "\027[38;5;251m" },
		{ r = 205, g = 205, b = 205, code = "\027[38;5;252m" },
		{ r = 215, g = 215, b = 215, code = "\027[38;5;253m" },
		{ r = 225, g = 225, b = 225, code = "\027[38;5;254m" },
		{ r = 235, g = 235, b = 235, code = "\027[38;5;255m" },
		-- colors:
		{ r = 000, g = 000, b = 000, code = "\027[38;5;16m"},
		{ r = 000, g = 000, b = 051, code = "\027[38;5;17m"},
		{ r = 000, g = 000, b = 102, code = "\027[38;5;18m"},
		{ r = 000, g = 000, b = 153, code = "\027[38;5;19m"},
		{ r = 000, g = 000, b = 204, code = "\027[38;5;20m"},
		{ r = 000, g = 000, b = 255, code = "\027[38;5;21m"},
		{ r = 000, g = 051, b = 000, code = "\027[38;5;22m"},
		{ r = 000, g = 051, b = 051, code = "\027[38;5;23m"},
		{ r = 000, g = 051, b = 102, code = "\027[38;5;24m"},
		{ r = 000, g = 051, b = 153, code = "\027[38;5;25m"},
		{ r = 000, g = 051, b = 204, code = "\027[38;5;26m"},
		{ r = 000, g = 051, b = 255, code = "\027[38;5;27m"},
		{ r = 000, g = 102, b = 000, code = "\027[38;5;28m"},
		{ r = 000, g = 102, b = 051, code = "\027[38;5;29m"},
		{ r = 000, g = 102, b = 102, code = "\027[38;5;30m"},
		{ r = 000, g = 102, b = 153, code = "\027[38;5;31m"},
		{ r = 000, g = 102, b = 204, code = "\027[38;5;32m"},
		{ r = 000, g = 102, b = 255, code = "\027[38;5;33m"},
		{ r = 000, g = 153, b = 000, code = "\027[38;5;34m"},
		{ r = 000, g = 153, b = 051, code = "\027[38;5;35m"},
		{ r = 000, g = 153, b = 102, code = "\027[38;5;36m"},
		{ r = 000, g = 153, b = 153, code = "\027[38;5;37m"},
		{ r = 000, g = 153, b = 204, code = "\027[38;5;38m"},
		{ r = 000, g = 153, b = 255, code = "\027[38;5;39m"},
		{ r = 000, g = 204, b = 000, code = "\027[38;5;40m"},
		{ r = 000, g = 204, b = 051, code = "\027[38;5;41m"},
		{ r = 000, g = 204, b = 102, code = "\027[38;5;42m"},
		{ r = 000, g = 204, b = 153, code = "\027[38;5;43m"},
		{ r = 000, g = 204, b = 204, code = "\027[38;5;44m"},
		{ r = 000, g = 204, b = 255, code = "\027[38;5;45m"},
		{ r = 000, g = 255, b = 000, code = "\027[38;5;46m"},
		{ r = 000, g = 255, b = 051, code = "\027[38;5;47m"},
		{ r = 000, g = 255, b = 102, code = "\027[38;5;48m"},
		{ r = 000, g = 255, b = 153, code = "\027[38;5;49m"},
		{ r = 000, g = 255, b = 204, code = "\027[38;5;50m"},
		{ r = 000, g = 255, b = 255, code = "\027[38;5;51m"},
		{ r = 051, g = 000, b = 000, code = "\027[38;5;52m"},
		{ r = 051, g = 000, b = 051, code = "\027[38;5;53m"},
		{ r = 051, g = 000, b = 102, code = "\027[38;5;54m"},
		{ r = 051, g = 000, b = 153, code = "\027[38;5;55m"},
		{ r = 051, g = 000, b = 204, code = "\027[38;5;56m"},
		{ r = 051, g = 000, b = 255, code = "\027[38;5;57m"},
		{ r = 051, g = 051, b = 000, code = "\027[38;5;58m"},
		{ r = 051, g = 051, b = 051, code = "\027[38;5;59m"},
		{ r = 051, g = 051, b = 102, code = "\027[38;5;60m"},
		{ r = 051, g = 051, b = 153, code = "\027[38;5;61m"},
		{ r = 051, g = 051, b = 204, code = "\027[38;5;62m"},
		{ r = 051, g = 051, b = 255, code = "\027[38;5;63m"},
		{ r = 051, g = 102, b = 000, code = "\027[38;5;64m"},
		{ r = 051, g = 102, b = 051, code = "\027[38;5;65m"},
		{ r = 051, g = 102, b = 102, code = "\027[38;5;66m"},
		{ r = 051, g = 102, b = 153, code = "\027[38;5;67m"},
		{ r = 051, g = 102, b = 204, code = "\027[38;5;68m"},
		{ r = 051, g = 102, b = 255, code = "\027[38;5;69m"},
		{ r = 051, g = 153, b = 000, code = "\027[38;5;70m"},
		{ r = 051, g = 153, b = 051, code = "\027[38;5;71m"},
		{ r = 051, g = 153, b = 102, code = "\027[38;5;72m"},
		{ r = 051, g = 153, b = 153, code = "\027[38;5;73m"},
		{ r = 051, g = 153, b = 204, code = "\027[38;5;74m"},
		{ r = 051, g = 153, b = 255, code = "\027[38;5;75m"},
		{ r = 051, g = 204, b = 000, code = "\027[38;5;76m"},
		{ r = 051, g = 204, b = 051, code = "\027[38;5;77m"},
		{ r = 051, g = 204, b = 102, code = "\027[38;5;78m"},
		{ r = 051, g = 204, b = 153, code = "\027[38;5;79m"},
		{ r = 051, g = 204, b = 204, code = "\027[38;5;80m"},
		{ r = 051, g = 204, b = 255, code = "\027[38;5;81m"},
		{ r = 051, g = 255, b = 000, code = "\027[38;5;82m"},
		{ r = 051, g = 255, b = 051, code = "\027[38;5;83m"},
		{ r = 051, g = 255, b = 102, code = "\027[38;5;84m"},
		{ r = 051, g = 255, b = 153, code = "\027[38;5;85m"},
		{ r = 051, g = 255, b = 204, code = "\027[38;5;86m"},
		{ r = 051, g = 255, b = 255, code = "\027[38;5;87m"},
		{ r = 102, g = 000, b = 000, code = "\027[38;5;88m"},
		{ r = 102, g = 000, b = 051, code = "\027[38;5;89m"},
		{ r = 102, g = 000, b = 102, code = "\027[38;5;90m"},
		{ r = 102, g = 000, b = 153, code = "\027[38;5;91m"},
		{ r = 102, g = 000, b = 204, code = "\027[38;5;92m"},
		{ r = 102, g = 000, b = 255, code = "\027[38;5;93m"},
		{ r = 102, g = 051, b = 000, code = "\027[38;5;94m"},
		{ r = 102, g = 051, b = 051, code = "\027[38;5;95m"},
		{ r = 102, g = 051, b = 102, code = "\027[38;5;96m"},
		{ r = 102, g = 051, b = 153, code = "\027[38;5;97m"},
		{ r = 102, g = 051, b = 204, code = "\027[38;5;98m"},
		{ r = 102, g = 051, b = 255, code = "\027[38;5;99m"},
		{ r = 102, g = 102, b = 000, code = "\027[38;5;100m"},
		{ r = 102, g = 102, b = 051, code = "\027[38;5;101m"},
		{ r = 102, g = 102, b = 102, code = "\027[38;5;102m"},
		{ r = 102, g = 102, b = 153, code = "\027[38;5;103m"},
		{ r = 102, g = 102, b = 204, code = "\027[38;5;104m"},
		{ r = 102, g = 102, b = 255, code = "\027[38;5;105m"},
		{ r = 102, g = 153, b = 000, code = "\027[38;5;106m"},
		{ r = 102, g = 153, b = 051, code = "\027[38;5;107m"},
		{ r = 102, g = 153, b = 102, code = "\027[38;5;108m"},
		{ r = 102, g = 153, b = 153, code = "\027[38;5;109m"},
		{ r = 102, g = 153, b = 204, code = "\027[38;5;110m"},
		{ r = 102, g = 153, b = 255, code = "\027[38;5;111m"},
		{ r = 102, g = 204, b = 000, code = "\027[38;5;112m"},
		{ r = 102, g = 204, b = 051, code = "\027[38;5;113m"},
		{ r = 102, g = 204, b = 102, code = "\027[38;5;114m"},
		{ r = 102, g = 204, b = 153, code = "\027[38;5;115m"},
		{ r = 102, g = 204, b = 204, code = "\027[38;5;116m"},
		{ r = 102, g = 204, b = 255, code = "\027[38;5;117m"},
		{ r = 102, g = 255, b = 000, code = "\027[38;5;118m"},
		{ r = 102, g = 255, b = 051, code = "\027[38;5;119m"},
		{ r = 102, g = 255, b = 102, code = "\027[38;5;120m"},
		{ r = 102, g = 255, b = 153, code = "\027[38;5;121m"},
		{ r = 102, g = 255, b = 204, code = "\027[38;5;122m"},
		{ r = 102, g = 255, b = 255, code = "\027[38;5;123m"},
		{ r = 153, g = 000, b = 000, code = "\027[38;5;124m"},
		{ r = 153, g = 000, b = 051, code = "\027[38;5;125m"},
		{ r = 153, g = 000, b = 102, code = "\027[38;5;126m"},
		{ r = 153, g = 000, b = 153, code = "\027[38;5;127m"},
		{ r = 153, g = 000, b = 204, code = "\027[38;5;128m"},
		{ r = 153, g = 000, b = 255, code = "\027[38;5;129m"},
		{ r = 153, g = 051, b = 000, code = "\027[38;5;130m"},
		{ r = 153, g = 051, b = 051, code = "\027[38;5;131m"},
		{ r = 153, g = 051, b = 102, code = "\027[38;5;132m"},
		{ r = 153, g = 051, b = 153, code = "\027[38;5;133m"},
		{ r = 153, g = 051, b = 204, code = "\027[38;5;134m"},
		{ r = 153, g = 051, b = 255, code = "\027[38;5;135m"},
		{ r = 153, g = 102, b = 000, code = "\027[38;5;136m"},
		{ r = 153, g = 102, b = 051, code = "\027[38;5;137m"},
		{ r = 153, g = 102, b = 102, code = "\027[38;5;138m"},
		{ r = 153, g = 102, b = 153, code = "\027[38;5;139m"},
		{ r = 153, g = 102, b = 204, code = "\027[38;5;140m"},
		{ r = 153, g = 102, b = 255, code = "\027[38;5;141m"},
		{ r = 153, g = 153, b = 000, code = "\027[38;5;142m"},
		{ r = 153, g = 153, b = 051, code = "\027[38;5;143m"},
		{ r = 153, g = 153, b = 102, code = "\027[38;5;144m"},
		{ r = 153, g = 153, b = 153, code = "\027[38;5;145m"},
		{ r = 153, g = 153, b = 204, code = "\027[38;5;146m"},
		{ r = 153, g = 153, b = 255, code = "\027[38;5;147m"},
		{ r = 153, g = 204, b = 000, code = "\027[38;5;148m"},
		{ r = 153, g = 204, b = 051, code = "\027[38;5;149m"},
		{ r = 153, g = 204, b = 102, code = "\027[38;5;150m"},
		{ r = 153, g = 204, b = 153, code = "\027[38;5;151m"},
		{ r = 153, g = 204, b = 204, code = "\027[38;5;152m"},
		{ r = 153, g = 204, b = 255, code = "\027[38;5;153m"},
		{ r = 153, g = 255, b = 000, code = "\027[38;5;154m"},
		{ r = 153, g = 255, b = 051, code = "\027[38;5;155m"},
		{ r = 153, g = 255, b = 102, code = "\027[38;5;156m"},
		{ r = 153, g = 255, b = 153, code = "\027[38;5;157m"},
		{ r = 153, g = 255, b = 204, code = "\027[38;5;158m"},
		{ r = 153, g = 255, b = 255, code = "\027[38;5;159m"},
		{ r = 204, g = 000, b = 000, code = "\027[38;5;160m"},
		{ r = 204, g = 000, b = 051, code = "\027[38;5;161m"},
		{ r = 204, g = 000, b = 102, code = "\027[38;5;162m"},
		{ r = 204, g = 000, b = 153, code = "\027[38;5;163m"},
		{ r = 204, g = 000, b = 204, code = "\027[38;5;164m"},
		{ r = 204, g = 000, b = 255, code = "\027[38;5;165m"},
		{ r = 204, g = 051, b = 000, code = "\027[38;5;166m"},
		{ r = 204, g = 051, b = 051, code = "\027[38;5;167m"},
		{ r = 204, g = 051, b = 102, code = "\027[38;5;168m"},
		{ r = 204, g = 051, b = 153, code = "\027[38;5;169m"},
		{ r = 204, g = 051, b = 204, code = "\027[38;5;170m"},
		{ r = 204, g = 051, b = 255, code = "\027[38;5;171m"},
		{ r = 204, g = 102, b = 000, code = "\027[38;5;172m"},
		{ r = 204, g = 102, b = 051, code = "\027[38;5;173m"},
		{ r = 204, g = 102, b = 102, code = "\027[38;5;174m"},
		{ r = 204, g = 102, b = 153, code = "\027[38;5;175m"},
		{ r = 204, g = 102, b = 204, code = "\027[38;5;176m"},
		{ r = 204, g = 102, b = 255, code = "\027[38;5;177m"},
		{ r = 204, g = 153, b = 000, code = "\027[38;5;178m"},
		{ r = 204, g = 153, b = 051, code = "\027[38;5;179m"},
		{ r = 204, g = 153, b = 102, code = "\027[38;5;180m"},
		{ r = 204, g = 153, b = 153, code = "\027[38;5;181m"},
		{ r = 204, g = 153, b = 204, code = "\027[38;5;182m"},
		{ r = 204, g = 153, b = 255, code = "\027[38;5;183m"},
		{ r = 204, g = 204, b = 000, code = "\027[38;5;184m"},
		{ r = 204, g = 204, b = 051, code = "\027[38;5;185m"},
		{ r = 204, g = 204, b = 102, code = "\027[38;5;186m"},
		{ r = 204, g = 204, b = 153, code = "\027[38;5;187m"},
		{ r = 204, g = 204, b = 204, code = "\027[38;5;188m"},
		{ r = 204, g = 204, b = 255, code = "\027[38;5;189m"},
		{ r = 204, g = 255, b = 000, code = "\027[38;5;190m"},
		{ r = 204, g = 255, b = 051, code = "\027[38;5;191m"},
		{ r = 204, g = 255, b = 102, code = "\027[38;5;192m"},
		{ r = 204, g = 255, b = 153, code = "\027[38;5;193m"},
		{ r = 204, g = 255, b = 204, code = "\027[38;5;194m"},
		{ r = 204, g = 255, b = 255, code = "\027[38;5;195m"},
		{ r = 255, g = 000, b = 000, code = "\027[38;5;196m"},
		{ r = 255, g = 000, b = 051, code = "\027[38;5;197m"},
		{ r = 255, g = 000, b = 102, code = "\027[38;5;198m"},
		{ r = 255, g = 000, b = 153, code = "\027[38;5;199m"},
		{ r = 255, g = 000, b = 204, code = "\027[38;5;200m"},
		{ r = 255, g = 000, b = 255, code = "\027[38;5;201m"},
		{ r = 255, g = 051, b = 000, code = "\027[38;5;202m"},
		{ r = 255, g = 051, b = 051, code = "\027[38;5;203m"},
		{ r = 255, g = 051, b = 102, code = "\027[38;5;204m"},
		{ r = 255, g = 051, b = 153, code = "\027[38;5;205m"},
		{ r = 255, g = 051, b = 204, code = "\027[38;5;206m"},
		{ r = 255, g = 051, b = 255, code = "\027[38;5;207m"},
		{ r = 255, g = 102, b = 000, code = "\027[38;5;208m"},
		{ r = 255, g = 102, b = 051, code = "\027[38;5;209m"},
		{ r = 255, g = 102, b = 102, code = "\027[38;5;210m"},
		{ r = 255, g = 102, b = 153, code = "\027[38;5;211m"},
		{ r = 255, g = 102, b = 204, code = "\027[38;5;212m"},
		{ r = 255, g = 102, b = 255, code = "\027[38;5;213m"},
		{ r = 255, g = 153, b = 000, code = "\027[38;5;214m"},
		{ r = 255, g = 153, b = 051, code = "\027[38;5;215m"},
		{ r = 255, g = 153, b = 102, code = "\027[38;5;216m"},
		{ r = 255, g = 153, b = 153, code = "\027[38;5;217m"},
		{ r = 255, g = 153, b = 204, code = "\027[38;5;218m"},
		{ r = 255, g = 153, b = 255, code = "\027[38;5;219m"},
		{ r = 255, g = 204, b = 000, code = "\027[38;5;220m"},
		{ r = 255, g = 204, b = 051, code = "\027[38;5;221m"},
		{ r = 255, g = 204, b = 102, code = "\027[38;5;222m"},
		{ r = 255, g = 204, b = 153, code = "\027[38;5;223m"},
		{ r = 255, g = 204, b = 204, code = "\027[38;5;224m"},
		{ r = 255, g = 204, b = 255, code = "\027[38;5;225m"},
		{ r = 255, g = 255, b = 000, code = "\027[38;5;226m"},
		{ r = 255, g = 255, b = 051, code = "\027[38;5;227m"},
		{ r = 255, g = 255, b = 102, code = "\027[38;5;228m"},
		{ r = 255, g = 255, b = 153, code = "\027[38;5;229m"},
		{ r = 255, g = 255, b = 204, code = "\027[38;5;230m"},
		{ r = 255, g = 255, b = 255, code = "\027[38;5;231m"},
	}
}

return palettes
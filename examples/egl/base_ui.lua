local ldb_egl = require("ldb_egl_debug")
local ldb_image = require("ldb_image")

local function make_base_ui(gr)
	local base_ui = {}

	base_ui.gr = assert(gr)

	base_ui.texture_path = "/home/max/Pictures/linux_mobile_gui.png"
	local grid_w, grid_h = 8,8
	base_ui.gr:set_grid(grid_w, grid_h)

	local elements = {}
	base_ui.gr.elements = {}

	local top_bar = {
		type = "rect",
	}
	table.insert(elements, top_bar)

	function base_ui:init()
		self.width, self.height = ldb_egl.get_info()
	end

	function base_ui:update()

	end

	return base_ui
end

return make_base_ui

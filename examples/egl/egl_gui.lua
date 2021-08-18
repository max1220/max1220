#!/usr/bin/env luajit
-- luacheck: no max line length
-- luacheck: ignore self
--local ldb_core = require("ldb_core")
--local ldb_gfx = require("ldb_gfx")
local ldb_egl = require("ldb_egl_debug")
local ldb_image = require("ldb_image")
local create_gui_renderer = require("examples.egl.egl_gui_renderer")
local make_finger_tracker = require("examples.egl.finger_tracker")

local function test_screen_texture(width, height, ui_scale)
	local test_screen = {}
	test_screen.gr = create_gui_renderer()

	test_screen.gr:set_texture("/home/max/Pictures/linux_mobile_gui.png")

	local grid_w, grid_h = 8,8
	test_screen.gr:set_grid(grid_w, grid_h)
	test_screen.gr.scale = ui_scale

	test_screen.ft = make_finger_tracker()

	function test_screen:update_elements()
		local tile_w, tile_h = 64,64
		local top_bar_h = 64
		local bottom_bar_h = 64*4
		local launcher_w = 64


		local top_bar_bg = {
			-- top bar background
			elements = {
				-- top-left
				{
					type = "rect",
					x = 0,
					y = 0,
					w = tile_w,
					h = top_bar_h,
					grid_id = 0,
				},
				{
					type = "rect",
					x = tile_w,
					y = 0,
					w = tile_w,
					h = top_bar_h,
					grid_id = 1
				},
				{
					type = "rect",
					x = tile_w-6,
					y = 0,
					w = tile_w,
					h = top_bar_h,
					grid_id = 30
				},

				-- top-center
				{
					type = "rect",
					x = 2*tile_w,
					y = 0,
					w = width-4*tile_w,
					h = top_bar_h,
					grid_id = 2
				},

				-- top-right
				{
					type = "rect",
					x = width-2*tile_w,
					y = 0,
					w = tile_w,
					h = top_bar_h,
					grid_id = 3
				},
				{
					type = "rect",
					x = width-tile_w,
					y = 0,
					w = tile_w,
					h = top_bar_h,
					grid_id = 4
				},
				{
					type = "rect",
					x = width-tile_w+9,
					y = 0,
					w = tile_w,
					h = top_bar_h,
					grid_id = 30
				},
			}
		}
		local battery_icon = {
			type = "rect",
			x = width-tile_w,
			y = 0,
			w = tile_w,
			h = top_bar_h,
			grid_id = 6,
			touch = true,
		}
		local cur_bat = 0.5
		local battery_indicator = {
			type = "rect",
			x = width-tile_w+29,
			w = 24,
		}
		function battery_icon:on_first_pos()
			cur_bat = (cur_bat - 0.02) % 1
			print("update battery:", cur_bat)
			battery_indicator:update_battery_pct(cur_bat)
			test_screen.gr:update_element(battery_indicator)
		end
		function battery_indicator:update_battery_pct(battery_pct)
			local battery_low = 0.25
			if (battery_pct<battery_low) then
				local gb = (battery_pct/battery_low)*0.3
				battery_indicator.color = {1,gb,gb,1}
			else
				battery_indicator.color = {1,1,1,1}
			end
			battery_indicator.y = 13 + 38*(1-battery_pct)
			battery_indicator.h = 1+38*battery_pct
		end
		battery_indicator:update_battery_pct(0.5)

		local launcher_icon = {
			type = "rect",
			x = 0,
			y = 0,
			w = launcher_w,
			h = top_bar_h,
			grid_id = 5
		}

		local date_text = {
			type = "text",
			x = tile_w,
			y = 0,
			w = width-2*tile_w,
			h = top_bar_h,
			line_w = 2,
			scale = 2,
			color = {0.9,0.9,0.98,1},
			text = "88:88:88",
			center = true
		}
		local top_bar = {
			x = 0,
			y = 0,
			w = width,
			h = top_bar_h,
			elements = {
				top_bar_bg,
				launcher_icon,
				date_text,
				battery_icon,
				battery_indicator
			}
		}




		local bottom_bar_bg = {
			-- bottom-left
			elements = {
				{
					type = "rect",
					x = 0,
					y = height-tile_h,
					w = tile_w,
					h = bottom_bar_h,
					grid_id = 16
				},
				{
					type = "rect",
					x = tile_w,
					y = height-tile_h,
					w = tile_w,
					h = bottom_bar_h,
					grid_id = 17
				},

				-- bottom-center
				{
					type = "rect",
					x = 2*tile_w,
					y = height-tile_h,
					w = width-4*tile_w,
					h = bottom_bar_h,
					grid_id = 18
				},

				-- bottom-right: bottom bar static bg + keyboard icon
				{
					type = "rect",
					x = width-2*tile_w,
					y = height-tile_h,
					w = tile_w,
					h = bottom_bar_h,
					grid_id = 19
				},
				{
					type = "rect",
					x = width-tile_w,
					y = height-tile_h,
					w = tile_w,
					h = bottom_bar_h,
					grid_id = 20
				},
			}
		}
		local back_icon = {
			type = "rect",
			x = 0.5*width-tile_w*0.5,
			y = height-tile_h,
			w = tile_w,
			h = tile_h,
			grid_id = 13,
			touch = true,
			on_first_pos = function(element)
				element.y = element.y + 6
				test_screen.gr:update_element(element)
			end,
			on_up = function(element)
				element.y = element.y - 6
				test_screen.gr:update_element(element)
			end
		}
		local keyboard_icon = {
			type = "rect",
			x = width-tile_w,
			y = height-tile_h,
			w = tile_w,
			h = tile_h,
			grid_id = 14
		}
		local bottom_bar = {
			x = 0,
			y = height-bottom_bar_h,
			w = width,
			h = bottom_bar_h,
			elements = {
				bottom_bar_bg,
				back_icon,
				keyboard_icon
			}
		}

		local elements = {
			top_bar,
			bottom_bar
		}

		self.gr.elements = elements
		self.ft.elements = elements
		self.ft.scale = self.gr.scale
	end

	function test_screen:init()
		test_screen:update_elements()
		test_screen.gr:init()
	end

	local last_date
	function test_screen:update()
		local now_data = os.date()
		if now_data ~= last_date then
			--date_text.text = os.date("%H:%M:%S")
			last_date = now_data
		end
	end

	return test_screen
end


local function background_image(path, width, height)
	local bg_db = ldb_image.load(path)
	local bg_texture_id = ldb_egl.create_texture2d_from_db(bg_db, true)

	local bg = {}
	bg.gr = create_gui_renderer()
	bg.gr.texture_id = bg_texture_id
	bg.gr.elements = {
		{
			type = "rect",
			x = 0,
			y = 32,
			w = width,
			h = height-64,
			texture = {0,0,1,1},
		}
	}

	function bg:draw()
		self.gr:draw()
	end

	return bg
end




--local prefered_width, prefered_height = 288, 512
local prefered_width, prefered_height = 512, 1024
assert(ldb_egl.init("/dev/dri/card0", prefered_width, prefered_height))

local native_width,native_height = ldb_egl.get_info()
print("Got native width,height:", native_width,native_height)

local ui_scale = 1
local bg = background_image("/home/max/Pictures/linux_mobile_bg.png", native_width/ui_scale,native_height/ui_scale)
bg.gr.scale = ui_scale
bg.gr:init()

local texture_screen = test_screen_texture(native_width/ui_scale,native_height/ui_scale, ui_scale)
texture_screen:init()

--local start = gettime()
--local iter, now, last = 0, start, start
local function draw()
	-- draw background
	ldb_egl.clear(0,0,0,1)
	bg.gr:draw()

	-- draw gui elements
	texture_screen:update()
	texture_screen.gr:draw()
end

print("Entering main loop...")
local run = true
print()
while run do
	--local dt = now-last

	--io.write(("\rfps: %7.2f  "):format(1/dt))
	if ldb_egl.glfw_mouse_state then
		local lmb,x,y = ldb_egl.glfw_mouse_state()
		texture_screen.ft:handle_glfw_state(lmb,x,y)
		--io.write(("mouse down: %3s pos: %4d, %4d"):format(lmb and "yes" or "no", tonumber(x) or -1, tonumber(y) or -1))
	end
	io.flush()

	assert(ldb_egl.update(draw))

	--iter = iter + 1
	--last = now
	--now = gettime()
end

--local elapsed = gettime()-start
--print(("%d iterations in %d seconds. (avg. FPS: %d)"):format(iter, elapsed, iter/elapsed))

ldb_egl.close()

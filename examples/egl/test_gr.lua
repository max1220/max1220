#!/usr/bin/env luajit
local ldb_egl = require("ldb_egl_debug")
local gettime = require("time").monotonic
local create_gui_renderer = require("examples.egl.egl_gui_renderer")

local width, height = 800, 600

local function generate_example_line()
	local line_element = {}
	line_element.type = "line"
	line_element.w = 5
	line_element.color = {1,0,1,1}

	local points = {}
	for i=0, 1, 0.02 do
		local point = {
			x = i*500,
			y = 400+math.sin(i*2*math.pi)*50+50,
			w = 0.5+i*10,
		}
		table.insert(points, point)
	end
	line_element.points = points

	return line_element
end

local gr = create_gui_renderer()
gr.elements ={
	{
		type = "rect",
		x = 0,
		y = 0,
		w = 100,
		h = 100,
		color = {1,0,0,1}
	},
	{
		type = "rect",
		x = 200,
		y = 0,
		w = 100,
		h = 100,
		color = {0,1,0,1}
	},
	{
		type = "rect",
		x = 400,
		y = 0,
		w = 100,
		h = 100,
		color = {0,0,1,1}
	},
	{
		type = "circle",
		x = 50,
		y = 250,
		radius = 50,
		color = {0,1,1,1}
	},
	{
		type = "circle",
		x = 250,
		y = 250,
		radius = 50,
		color = {1,0,1,1}
	},
	{
		type = "circle",
		x = 450,
		y = 250,
		radius = 50,
		color = {1,1,0,1}
	},
	{
		type = "line",
		w = 20,
		color = {1,1,1,1},
		points = {
			{x=600,y=0},
			{x=700,y=100}
		}
	},
	{
		type = "line",
		w = 20,
		color = {0.5,0.5,0.5,1},
		points = {
			{x=600,y=200},
			{x=700,y=300}
		}
	},
	{
		type = "line",
		w = 20,
		color = {0.1,0.1,0.1,1},
		points = {
			{x=600,y=400},
			{x=700,y=500}
		}
	},
	{
		type = "line",
		w = 20,
		color = {0,0,0,1},
		points = {
			{x=0,y=350, r=0,g=0,b=0},
			{x=500,y=350, r=1,g=1,b=1}
		}
	},
	generate_example_line(),

	-- last element will be animated
	{
		type = "rect",
		x = 50,
		y = 550,
		w = 700,
		h = 25,
		color = {1,0,0,1}
	}
}

assert(ldb_egl.init("/dev/dri/card0", width, height))

gr:init()

local function draw()
	collectgarbage()
	ldb_egl.clear(0,0,0,1)

	-- get last element
	local element = gr.elements[#gr.elements]

	-- change color
	local v = 0.2+math.abs(math.sin(gettime()))*0.8
	element.color[1] = v
	element.color[2] = v
	element.color[3] = v
	element.color[4] = 1

	-- update single element
	gr:update_element(element)

	gr:draw()
end

print("Entering main loop...")
local run = true
while run do
	assert(ldb_egl.update(draw))
end

ldb_egl.close()

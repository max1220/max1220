local ldb_egl = require("ldb_egl_debug")
local ldb_image = require("ldb_image")
local gettime = require("time").monotonic

-- luacheck: no max line length
-- luacheck: ignore self

-- load hershey vector font:
local hershey_font = require("lua-db.hershey")

-- a GUI renderer represents a single VBO used for rendering gui-like elements, from a single texture.
-- geometry is specified as a list of GUI elements.
-- vertex data is in screen coordinates.
local function create_gui_renderer()
	local gui_renderer = {}

	gui_renderer.elements = {}

	-- load shaders
	gui_renderer.vshader = (assert(io.open("examples/egl/vshader.glsl"))):read("*a")
	gui_renderer.fshader = (assert(io.open("examples/egl/fshader.glsl"))):read("*a")

	-- these tables contain the vertex data that should currently be sent to the
	-- GPU.
	gui_renderer.vertex_data = {}
	gui_renderer.index_data = {}

	-- this is the scaling factor for the gui_renderer.
	-- A scaling factor of 2 would mean that the screen's maximum x value is native_width/2,
	-- and all elements would be scaled up 2x.
	gui_renderer.scale = 1

	-- These two variables define a texture grid. The texture is split up into
	-- equal-size rectangles that can be indexed by a texture_id.
	-- grid_w=2, grid_h=2 would mean that the texture is made of 4 sub-textures,
	-- with the top-left texture having texture_id=0, top-right having texture_id=1, etc.
	gui_renderer.grid_w = 1
	gui_renderer.grid_h = 1

	-- This is the ammount of *extra* data to allocate at init.
	-- (total vertice data allocated = #vertex_data+v_alloc)
	gui_renderer.v_alloc = 0
	gui_renderer.i_alloc = 0

	-- default color if not specified for an element
	gui_renderer.default_color = {1,1,1,1}

	-- add vertex data x,y,z, r,g,b,a, tx,ty to vertex_data table at index vertex_offset(returns new index_offset)
	local function add_vertex_data9(vertex_data, vertex_offset, x,y,z, r,g,b,a, tx,ty)
		vertex_data[vertex_offset+1] = x -- position
		vertex_data[vertex_offset+2] = y
		vertex_data[vertex_offset+3] = z
		vertex_data[vertex_offset+4] = r -- center color
		vertex_data[vertex_offset+5] = g
		vertex_data[vertex_offset+6] = b
		vertex_data[vertex_offset+7] = a
		vertex_data[vertex_offset+8] = tx -- texture coords
		vertex_data[vertex_offset+9] = ty
		return vertex_offset+9
	end

	-- add index data a,b,c to index_data table at index index_offset(returns new index_offset)
	local function add_index_data3(index_data, index_offset, a,b,c)
		index_data[index_offset+1] = a -- position
		index_data[index_offset+2] = b
		index_data[index_offset+3] = c
		return index_offset+3
	end

	-- generate vertex/index data for a circle(using triangles, "fan")
	local function add_circle(vertex_data, vertex_offset, index_data, index_offset, center_x,center_y,z, radius, steps, c_in, c_out)
		-- add vertex data for center position
		local center_vert_i = vertex_offset/9
		vertex_offset = add_vertex_data9(
			vertex_data, vertex_offset,
			center_x, center_y, z,
			c_in[1],c_in[2],c_in[3],c_in[4],
			0,0
		)

		-- add vertex data for initial/end position
		local initial_vert_i = vertex_offset/9
		vertex_offset = add_vertex_data9(
			vertex_data, vertex_offset,
			center_x, center_y-radius, z,
			c_out[1],c_out[2],c_out[3],c_out[4],
			0,0
		)

		-- add vertex data for circle points
		for i=1, steps-2 do
			local a = (i/(steps-1))*math.pi*2
			local x = center_x-math.sin(a)*radius
			local y = center_y-math.cos(a)*radius
			vertex_offset = add_vertex_data9(
				vertex_data, vertex_offset,
				x, y, z,
				c_out[1],c_out[2],c_out[3],c_out[4],
				0,0
			)
		end

		-- add triangles to index table
		local last = initial_vert_i
		for _=1, steps-2 do
			index_offset = add_index_data3(
				index_data, index_offset,
				center_vert_i, last, last+1
			)
			last = last+1
		end

		-- add last triangle
		index_offset = add_index_data3(
			index_data, index_offset,
			center_vert_i, last, initial_vert_i
		)

		--index_offset = add_index_data3(index_data, index_offset, center_vert_i, last, initial_vert_i+i+1)
		return vertex_offset, index_offset
	end

	-- generate vertex/index data for an axis-aligned rectangle(x,y,w,h)
	local function add_rect(vertex_data, vertex_offset, index_data, index_offset, x,y,z,w,h, c1,c2,c3,c4, tx,ty,tw,th)
		tx = tonumber(tx) or 0
		ty = tonumber(ty) or 0
		tw = tonumber(tw) or 1
		th = tonumber(th) or 1

		local initial_vert_i = vertex_offset/9

		-- add vertex data

		-- top right
		vertex_offset = add_vertex_data9(vertex_data,vertex_offset, x+w,y,z, c1[1],c1[2],c1[3],c1[4], tx+tw,ty)

		-- bottom right
		vertex_offset = add_vertex_data9(vertex_data,vertex_offset, x+w,y+h,z, c2[1],c2[2],c2[3],c2[4], tx+tw, ty+th)

		-- bottom left
		vertex_offset = add_vertex_data9(vertex_data,vertex_offset, x,y+h,z, c3[1],c3[2],c3[3],c3[4], tx, ty+th)

		-- top left
		vertex_offset = add_vertex_data9(vertex_data,vertex_offset, x,y,z, c4[1],c4[2],c4[3],c4[4], tx,ty)

		-- add index data

		-- first triangle: top right, bottom right, top left
		index_data[index_offset+1] = initial_vert_i+0
		index_data[index_offset+2] = initial_vert_i+1
		index_data[index_offset+3] = initial_vert_i+3

		-- second triangle: top right, bottom right, bottom left
		index_data[index_offset+4] = initial_vert_i+1
		index_data[index_offset+5] = initial_vert_i+2
		index_data[index_offset+6] = initial_vert_i+3
		index_offset = index_offset + 6

		return vertex_offset, index_offset
	end

	-- turn 2 points defining a line into 4 points, defining a rectangle along the line with a width
	local function line_points_to_rect_points(lp1_x,lp1_y,lp1_w, lp2_x,lp2_y,lp2_w)
		local dx = lp2_x-lp1_x
		local dy = lp2_y-lp1_y

		local len = math.sqrt(dx^2+dy^2)

		local nx = dx/len
		local ny = dy/len

		local lp1_hw, lp2_hw = lp1_w/2, lp2_w/2

		local rp1_x = lp1_x-ny*lp1_hw
		local rp1_y = lp1_y+nx*lp1_hw
		local rp2_x = lp1_x+ny*lp1_hw
		local rp2_y = lp1_y-nx*lp1_hw
		local rp3_x = lp2_x-ny*lp2_hw
		local rp3_y = lp2_y+nx*lp2_hw
		local rp4_x = lp2_x+ny*lp2_hw
		local rp4_y = lp2_y-nx*lp2_hw

		return rp1_x,rp1_y,rp2_x,rp2_y,rp3_x,rp3_y,rp4_x,rp4_y
	end

	local function add_line(vertex_data, vertex_offset, index_data, index_offset, line_point_data, z)
		local initial_vert_i = vertex_offset/9

		-- add vertex data:
		local point_count = #line_point_data/7
		for i=0, point_count-2 do
			local lp1_x = line_point_data[i*7+1]
			local lp1_y = line_point_data[i*7+2]
			local lp1_w = line_point_data[i*7+3]
			local lp1_r = line_point_data[i*7+4]
			local lp1_g = line_point_data[i*7+5]
			local lp1_b = line_point_data[i*7+6]
			local lp1_a = line_point_data[i*7+7]

			local lp2_x = line_point_data[i*7+7+1]
			local lp2_y = line_point_data[i*7+7+2]
			local lp2_w = line_point_data[i*7+7+3]
			local lp2_r = line_point_data[i*7+7+4]
			local lp2_g = line_point_data[i*7+7+5]
			local lp2_b = line_point_data[i*7+7+6]
			local lp2_a = line_point_data[i*7+7+7]

			local rp1_x,rp1_y,rp2_x,rp2_y,rp3_x,rp3_y,rp4_x,rp4_y = line_points_to_rect_points(
				lp1_x,lp1_y,lp1_w,
				lp2_x,lp2_y,lp2_w
			)

			vertex_offset = add_vertex_data9(vertex_data, vertex_offset, rp1_x,rp1_y,z, lp1_r,lp1_g,lp1_b,lp1_a, 0,0)
			vertex_offset = add_vertex_data9(vertex_data, vertex_offset, rp2_x,rp2_y,z, lp1_r,lp1_g,lp1_b,lp1_a, 0,0)
			vertex_offset = add_vertex_data9(vertex_data, vertex_offset, rp3_x,rp3_y,z, lp2_r,lp2_g,lp2_b,lp2_a, 0,0)
			vertex_offset = add_vertex_data9(vertex_data, vertex_offset, rp4_x,rp4_y,z, lp2_r,lp2_g,lp2_b,lp2_a, 0,0)
		end

		-- add index data
		for i=0, point_count-2 do
			local a = initial_vert_i+i*4
			local b = initial_vert_i+i*4+1
			local c = initial_vert_i+i*4+2
			local d = initial_vert_i+i*4+3
			index_offset = add_index_data3(index_data,index_offset, a,b,c)
			index_offset = add_index_data3(index_data,index_offset, b,c,d)
		end

		return vertex_offset, index_offset
	end



	function gui_renderer:add_line_element_to_data(line_element, vertex_data, vertex_offset, index_data, index_offset)
		local line_points = {}
		local color = assert(line_element.color or self.default_color)
		for i=0, #line_element.points-1 do
			local point = line_element.points[i+1]
			line_points[i*7+1] = assert(point.x)
			line_points[i*7+2] = assert(point.y)
			line_points[i*7+3] = assert(point.w or line_element.w)
			line_points[i*7+4] = assert(point.r or color[1])
			line_points[i*7+5] = assert(point.g or color[2])
			line_points[i*7+6] = assert(point.b or color[3])
			line_points[i*7+7] = assert(point.a or color[4])
		end
		vertex_offset, index_offset = add_line(
			vertex_data, vertex_offset,
			index_data, index_offset,
			line_points,
			0
		)
		return vertex_offset, index_offset
	end

	function gui_renderer:add_circle_element_to_data(circle_element, vertex_data, vertex_offset, index_data, index_offset)
		local color = assert(circle_element.color or self.default_color)
		vertex_offset,index_offset = add_circle(
			vertex_data, vertex_offset,
			index_data, index_offset,
			assert(tonumber(circle_element.x)), assert(tonumber(circle_element.y)),
			0,
			assert(tonumber(circle_element.radius)),
			tonumber(circle_element.steps) or 64,
			color, color
		)
		return vertex_offset,index_offset
	end

	function gui_renderer:get_texture_coords_grid(grid_id)
		local ty = math.floor(grid_id/self.grid_w)
		local tx = grid_id-ty*self.grid_w
		return tx*(1/self.grid_w), ty*(1/self.grid_h), (1/self.grid_w), (1/self.grid_h)
	end

	function gui_renderer:add_rect_element_to_data(rect_element, vertex_data, vertex_offset, index_data, index_offset)
		local color = rect_element.color
		local tx,ty,tw,th
		if rect_element.grid_id then
			tx,ty,tw,th = self:get_texture_coords_grid(rect_element.grid_id)
			if not color then -- if no color provided, default to 100% texture
				color = {0,0,0,0}
			end
		elseif rect_element.texture then
			tx = assert(tonumber(rect_element.texture[1]))
			ty = assert(tonumber(rect_element.texture[2]))
			tw = assert(tonumber(rect_element.texture[3]))
			th = assert(tonumber(rect_element.texture[4]))
			if not color then -- if no color provided, default to 100% texture
				color = {0,0,0,0}
			end
		end
		color = assert(color or self.default_color)

		vertex_offset,index_offset = add_rect(
			vertex_data, vertex_offset,
			index_data, index_offset,
			assert(tonumber(rect_element.x)), assert(tonumber(rect_element.y)),
			0,
			assert(tonumber(rect_element.w)), assert(tonumber(rect_element.h)),
			color, color, color, color,
			tx,ty,tw,th
		)
		return vertex_offset,index_offset
	end

	function gui_renderer:add_text_element_to_data(text_element, vertex_data, vertex_offset, index_data, index_offset)
		local line_w = text_element.line_w or 1
		local color = assert(text_element.color or self.default_color)
		local scale = tonumber(text_element.scale) or 1
		local x_offset = tonumber(text_element.x) or 0
		local y_offset = tonumber(text_element.y) or 0
		local char_spacing = tonumber(text_element.char_spacing)

		y_offset = y_offset + 32*scale

		local text = assert(text_element.text)

		if text_element.center then
			local text_length = hershey_font:get_text_length(text, char_spacing, scale, x_offset, y_offset)
			if text_element.w then
				x_offset = x_offset + text_element.w * 0.5 - text_length*0.5
			end
			if text_element.h then
				y_offset = y_offset + text_element.h * 0.5 - 32*scale*0.5
			end
		end

		local lines = hershey_font:text_to_lines(text, char_spacing, scale, x_offset, y_offset)
		for i=1, #lines do
			local line = lines[i]
			local line_point_data = {}
			for j=1, #line, 2 do
				local vx = line[j]
				local vy = line[j+1]
				line_point_data[#line_point_data+1] = vx
				line_point_data[#line_point_data+1] = vy
				line_point_data[#line_point_data+1] = line_w
				line_point_data[#line_point_data+1] = color[1]
				line_point_data[#line_point_data+1] = color[2]
				line_point_data[#line_point_data+1] = color[3]
				line_point_data[#line_point_data+1] = color[4]
			end
			vertex_offset,index_offset = add_line(vertex_data, vertex_offset, index_data, index_offset, line_point_data, 0)
		end
		return vertex_offset,index_offset
	end


	function gui_renderer:element_to_data(element, vertex_data, vertex_offset, index_data, index_offset)
		if element.type == "rect" then
			vertex_offset, index_offset = self:add_rect_element_to_data(
				element,
				vertex_data, vertex_offset,
				index_data, index_offset
			)
		elseif element.type == "circle" then
			vertex_offset, index_offset = self:add_circle_element_to_data(
				element,
				vertex_data, vertex_offset,
				index_data,	index_offset
			)
		elseif element.type == "line" then
			vertex_offset, index_offset = self:add_line_element_to_data(
				element,
				vertex_data, vertex_offset,
				index_data, index_offset
			)
		elseif element.type == "text" then
			vertex_offset, index_offset = self:add_text_element_to_data(
				element,
				vertex_data, vertex_offset,
				index_data, index_offset
			)
		end
		if element.elements then
			vertex_offset, index_offset = self:elements_to_data(element.elements, vertex_data, vertex_offset, index_data, index_offset)
		end
		return vertex_offset, index_offset
	end

	function gui_renderer:elements_to_data(elements, vertex_data, vertex_offset, index_data, index_offset)
		for i=1, #elements do
			local element = elements[i]
			element.vertex_offset = vertex_offset
			element.index_offset = index_offset
			vertex_offset, index_offset = self:element_to_data(element, vertex_data, vertex_offset, index_data, index_offset)
		end
		return vertex_offset, index_offset
	end

	-- update a single element, updating both the gui_renderer vertex data and the buffer data.
	function gui_renderer:update_element(element, recursive)
		-- new vertex data for this element.
		-- TODO: Check if of equal length of old vertex data!!!
		-- TODO: currently does not support updating index data(is this useful?)
		--local update_vertex_data = {}
		--local update_index_data = {}

		-- needs to add same ammount of vertices as element previously had!
		--self:element_to_data(element, update_vertex_data, 0, update_index_data, 0)

		-- update internal representation
		self:element_to_data(element, self.vertex_data, element.vertex_offset, self.index_data, element.index_offset)

		-- Update vertex buffer
		assert(ldb_egl.bind_VBO(self.VBO))
		assert(ldb_egl.buffer_sub_data(element.vertex_offset, false, self.vertex_data, element.vertex_offset))

		-- Update index buffer
		assert(ldb_egl.bind_EBO(self.EBO))
		assert(ldb_egl.buffer_sub_data(element.index_offset, true, self.index_data, element.index_offset))

		if recursive and element.elements then
			for i=1, #element.elements do
				local subelement = element.elements[i]
				self:update_element(subelement, true)
			end
		end
	end

	-- update gui_renderer vertex data based on elements table
	function gui_renderer:update_data()
		local vertex_data = {}
		local vertex_offset = 0
		local index_data = {}
		local index_offset = 0
		self:elements_to_data(self.elements, vertex_data, vertex_offset, index_data, index_offset)
		self.vertex_data = vertex_data
		self.index_data = index_data
	end

	-- update VBO, EBO buffer content based on gui_renderer vertex data
	-- this re-sends the entire buffer content, you can also update single
	-- elements using :update_element.
	function gui_renderer:update_buffers()
		-- Update vertex buffer
		assert(ldb_egl.bind_VBO(self.VBO))
		assert(ldb_egl.buffer_sub_data(0, false, assert(self.vertex_data)))

		-- Update index buffer
		assert(ldb_egl.bind_EBO(self.EBO))
		assert(ldb_egl.buffer_sub_data(0, true, assert(self.index_data)))
	end

	-- create buffer objects(VBO, VAO, EBO)
	function gui_renderer:init_buffers()
		local VBO, VAO, EBO = ldb_egl.create_vao(#self.vertex_data+self.v_alloc,#self.index_data+self.i_alloc)
		assert(VBO and VAO and EBO)
		self.VBO = VBO
		self.VAO = VAO
		self.EBO = EBO
	end

	-- update the content displayed content after modifying elements table.
	function gui_renderer:update()

		-- update resolution for graphics.
		local native_width, native_height = ldb_egl.get_info()
		local width, height = native_width/self.scale, native_height/self.scale
		ldb_egl.use_program(assert(self.program))
		assert(ldb_egl.set_uniform_f("view_width", self.program, width))
		assert(ldb_egl.set_uniform_f("view_height", self.program, height))
		self.width,self.height = width,height

		-- update internal vertex representation
		self:update_data()

		if self.VBO then
			-- try to update the existing buffers
			-- TODO: Check vertex buffer size, compare to max size, reallocate larger VBO when needded
			self:update_buffers()
		else
			-- create and fill new buffers
			self:init_buffers()
			self:update_buffers()
		end
	end

	function gui_renderer:draw()
		local ok,err,err2 = ldb_egl.use_program(assert(self.program))
		assert(ok, tostring(err)..tostring(err2))

		if self.texture_id then
			assert(ldb_egl.bind_texture2d(self.texture_id))
		end

		-- bind the VAO that represents this gui_renderer
		assert(ldb_egl.bind_VAO(assert(self.VAO)))

		-- update the time uniform last
		assert(ldb_egl.set_uniform_f("time", self.program, gettime()))

		-- draw triangles using the VAO's VBO and EBO
		ldb_egl.draw_triangles(#assert(self.index_data))
	end

	function gui_renderer:set_grid(new_grid_w, new_grid_h)
		self.grid_w = tonumber(new_grid_w) or self.grid_w
		self.grid_h = tonumber(new_grid_h) or self.grid_h
	end

	function gui_renderer:set_texture(texture)
		if type(texture) == "number" then
			self.texture_id = texture
		elseif type(texture) == "string" then
			local texture_db = assert(ldb_image.load(texture))
			self.texture_id = assert(ldb_egl.create_texture2d_from_db(texture_db, true))
		end
	end

	function gui_renderer:init()
		local program,_err,_err2 = ldb_egl.create_program(self.vshader, self.fshader)
		self.program = assert(program, tostring(_err).." - "..tostring(_err2))
		self:update()
	end

	return gui_renderer
end

return create_gui_renderer

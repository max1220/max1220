local input = require("lua-input")
local gettime = require("time").monotonic
local codes = input.linux.input_event_codes


-- check if the position x,y is inside any of the elements in the elements list,
-- and return first element found.
local function get_element_for_pos(elements, x,y)
	for i=1, #elements do
		local element = assert(elements[i])
		if element.touch then
			local touch_x = assert(tonumber(element.touch_x) or tonumber(element.x))
			local touch_y = assert(tonumber(element.touch_y) or tonumber(element.y))
			local touch_w = assert(tonumber(element.touch_w) or tonumber(element.w))
			local touch_h = assert(tonumber(element.touch_h) or tonumber(element.h))
			if (x>=touch_x) and (y>=touch_y) and (x<touch_x+touch_w) and (y<touch_y+touch_h) then
				return element
			end
		end
		if element.elements then
			local found_element = get_element_for_pos(element.elements, x,y)
			if found_element then
				return found_element
			end
		end
	end
end


-- create a finger tracker, that is able to call callbacks based on touch events
-- (or fake touch events based on stateful mouse-like input)
local function make_finger_tracker(scale)
	local finger_tracker = {}

	finger_tracker.slot = 0
	finger_tracker.tracking_id = nil
	finger_tracker.scale = tonumber(scale) or 1

	function finger_tracker:down(finger_slot)
		local finger = self[finger_slot]
		assert(not finger, "Finger down twice without up!")
		self[finger_slot] = { time = gettime() }
	end
	function finger_tracker:first_pos(finger_slot)
		local finger = assert(self[finger_slot], "First position for non-existing finger!")
		local element = get_element_for_pos(self.elements, finger.x, finger.y)

		finger.down = {x=finger.x, y=finger.y}
		if element then
			finger.element = element
			if element.on_first_pos then
				element:on_first_pos(finger, finger.x, finger.y)
			end
		--else
			-- TODO: Add callback for missed first_pos events?
		end
	end
	function finger_tracker:moved(finger_slot, x, y)
		local finger = assert(self[finger_slot], "non-existing finger moved!")
		finger.x = x or finger.x
		finger.y = y or finger.y

		if finger.x and finger.y and (not finger.down) then
			return self:first_pos(finger_slot)
		end

		if finger.down and finger.element and finger.element.on_moved then
			finger.element:on_moved(finger, x,y)
		--elseif finger.down and (not finger.element) then
			-- TODO: Add callback for missed moved events?
		end
		--dprint("Finger moved", finger_slot, self[finger_slot].x, self[finger_slot].y)
	end
	function finger_tracker:up(finger_slot)
		local finger = assert(self[finger_slot], "non-existing finger released!")

		if finger.element and finger.element.on_up then
			finger.element:on_up(finger)
		--elseif (not finger.element) then
			-- TODO: Add callback for missed up events?
		end

		self[finger_slot] = nil
	end

	function finger_tracker:handle_touch_ev(touch_ev)
		if not touch_ev.type == codes.EV_ABS then
			return
		end

		if touch_ev.code == codes.ABS_MT_TRACKING_ID then
			self.tracking_id = touch_ev.value
			if (touch_ev.value == -1) and self.tracking_id then
				self:up(self.slot)
			else
				self:down(self.slot)
			end
		elseif touch_ev.code == codes.ABS_MT_SLOT then
			self.slot = touch_ev.value
		elseif touch_ev.code == codes.ABS_MT_POSITION_X then
			self:moved(self.slot, touch_ev.value/self.scale, nil)
		elseif touch_ev.code == codes.ABS_MT_POSITION_Y then
			self:moved(self.slot, nil, touch_ev.value/self.scale)
		end
	end

	-- debug function used for running in glfw. Only supports LMB and a single finger(mouse).
	local prev_lmb
	function finger_tracker:handle_glfw_state(lmb,x,y)
		local slot = "glfw"
		-- emulate touchscreen behaviour
		if lmb and (not prev_lmb) then
			-- finger went from not down to down
			self:down(slot)
			self:moved(slot, x/self.scale,y/self.scale)
		elseif (not lmb) and prev_lmb then
			-- finger went from down to not down
			self:moved(slot, x/self.scale,y/self.scale)
			self:up(slot)
		elseif lmb and prev_lmb then
			-- finger was and is down
			self:moved(slot, x/self.scale,y/self.scale)
		end
		prev_lmb = lmb
	end

	return finger_tracker
end

return make_finger_tracker

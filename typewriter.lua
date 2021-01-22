--[[
	Requires LOVE2D -- https://love2d.org/
	Written By: David Ashton | CognizanceGaming | CZGaming94
	Free for use in any project. No compensation is required. 
	It is only requested you leave this publication tag.
--]]

local lg = love.graphics
local typewriter = {}
typewriter.typewriters = {}

-- text, time between each letter, x, y, repeat
function typewriter:new(text, l, x, y, r)
	assert(text, "FAILURE: typewriter:new() :: missing parameter [text]")
	assert(type(text) == "string" or type(text) == "table", "FAILURE: typewriter:new() :: incorrect param[text]  - text or text table expected, but " .. type(text) .. " supplied.")
	assert(l, "FAILURE: typewriter:new() :: missing parameter [length]")
	assert(type(l) == "number", "FAILURE: typewriter:new() :: incorrect param[length] - number expected, but " .. type(l) .. " supplied.")
	assert(x, "FAILURE: typewriter:new() :: missing parameter [x]")
	assert(type(x) == "number", "FAILURE: typewriter:new() :: incorrect param[x] - number expected, but " .. type(x) .. " supplied.")
	assert(y, "FAILURE: typewriter:new() :: missing parameter [y]")
	assert(type(y) == "number", "FAILURE: typewriter:new() :: incorrect param[y] - number expected, but " .. type(y) .. " supplied.")
	if r then assert(type(r) == "boolean", "FAILURE: typewriter:new() :: incorrect param[repeat] - boolean expected, but " .. type(r) .. " supplied.") end
	
	local t = {}
	if type(text) == "table" then
		if text[2] then
			assert(type(text[2]) == "table", "FAILURE: typewriter:new() :: incorrect param[text[color]] - table expected, but " .. type(text[2]) .. " supplied.")
			while type(text[2][1]) == "table" do text[2] = text[2][1] end
		end
		text, t.color, t.font = unpack(text)
		t.oFont = t.font
	end
	t.text = self:split(text)
	t.oText = text
	t.timeWaited = 0
	t.timeToWait = l
	t.oTime = l
	t.curPrint = 1
	t.toShow = ""
	t.x = x
	t.y = y
	t.id = #self.typewriters + 1
	t.finished = false
	t.runCount = 0
	t.show = true
	t.rep = r or false
	t.isStopped = false
	t.background = {}
	t.scale = {1,1}
	
	function t:update(dt)
		self.timeWaited = self.timeWaited + dt
		while self.timeWaited >= self.timeToWait and self.curPrint <= #self.text do
			self.timeWaited = self.timeWaited - self.timeToWait
			self.toShow = self.toShow .. self.text[self.curPrint]
			self.curPrint = self.curPrint + 1
		end
		if self.curPrint >= #self.text and not self.finished then
			if not self.rep then self.finished = true else self:reset() end
			self.runCount = self.runCount + 1
		end
	end
	
	function t:draw()
		if self.scale[1] ~= 1 or self.scale[2] ~= 1 then 
			lg.push()
			lg.scale(unpack(self.scale))
		end
		if self.background[1] then
			lg.setColor(self.background[2])
			if self.background[5] then
				lg.rectangle(self.background[1], self.x - (self.background[3] / 2), self.x - (self.background[4] / 2), self.font:getWidth(self.oText) + self.background[3], self.font:getHeight(self.oText) + self.background[4], 5, 5)
			else
				lg.rectangle(self.background[1], self.x - (self.background[3] / 2), self.x - (self.background[4] / 2), self.font:getWidth(self.oText) + self.background[3], self.font:getHeight(self.oText) + self.background[4])
			end
			if self.background[6] then
				lg.setColor(self.background[6])
				if self.background[5] then
					lg.rectangle("line", self.x - (self.background[3] / 2), self.x - (self.background[4] / 2), self.font:getWidth(self.oText) + self.background[3], self.font:getHeight(self.oText) + self.background[4], 5, 5)
				else
					lg.rectangle("line", self.x - (self.background[3] / 2), self.x - (self.background[4] / 2), self.font:getWidth(self.oText) + self.background[3], self.font:getHeight(self.oText) + self.background[4])
				end
			end
		end
		
		--[[ Thanks, FlamingArrow ]]
		local c = self.color or {lg.getColor()}
		local f = self.font or lg.getFont()
		lg.print({c, self.toShow}, f, self.x, self.y)
		--[[ end Thanks ]]
		
		if self.scale[1] ~= 1 or self.scale[2] ~= 1 then 
			lg.pop()
		end
		lg.setColor(1,1,1,1)
	end
	
	function t:setSpeed(s)
		assert(s, "FAILURE: typewriter:setSpeed() :: missing param[speed]")
		assert(type(s) == "number", "FAILURE: typewriter:setSpeed() :: incorrect param[speed] - number expected, but " .. type(s) .. " supplied.")
		self.timeToWait = tonumber(s)
	end
	
	function t:getSpeed()
		return self.timeToWait
	end
	
	function t:setColor(c)
		assert(c, "FAILURE: typewriter:setColor() :: missing param[color]")
		assert(type(c) == "table", "FAILURE: typewriter:setColor() :: incorrect param[color] - table expected, but " .. type(c) .. " supplied.")
		self.color = c
	end
	
	function t:getColor()
		return self.color
	end
	
	function t:setFont(f)
		assert(f, "FAILURE: typewriter:setFont() :: missing param[font]")
		assert(type(f) == "userdata", "FAILURE: typewriter:setFont() :: incorrect param[font] - LOVE2D Font expected, but " .. type(f) .. " supplied.")
		self.font = f
	end
	
	function t:getFont()
		return self.font
	end
	
	function t:setBackground(fill, color, round, xPad, yPad, wrap)
		assert(fill, "FAILURE: typewriter:setBackground() :: missing param[fill]")
		assert(type(fill) == "string", "FAILURE: typewriter:setBackground() :: incorrect param[fill] - string expected, but " .. type(fill) .. " supplied.")
		assert(color, "FAILURE: typewriter:setBackground() :: missing param[color]")
		assert(type(color) == "table", "FAILURE: typewriter:setBackground() :: incorrect param[color] - table expected, but " .. type(color) .. " supplied.")
		if round then assert(type(round) == "boolean", "FAILURE: typewriter:setBackground() :: incorrect param[round] - boolean expected, but " .. type(round) .. " supplied.") end
		if xPad then assert(type(xPad) == "number", "FAILURE: typewriter:setBackground() :: incorrect param[round] - number expected, but " .. type(xPad) .. " supplied.") end
		if yPad then assert(type(yPad) == "number", "FAILURE: typewriter:setBackground() :: incorrect param[round] - number expected, but " .. type(yPad) .. " supplied.") end
		if wrap then assert(type(wrap) == "table", "FAILURE: typewriter:setBackground() :: incorrect param[wrap] - table expected, but " .. type(wrap) .. " supplied.") end
		
		xPad, yPad = xPad or 0, yPad or 0
		self.background = {fill, color, xPad, yPad, round, wrap}
	end
	
	function t:getBackground()
		return self.background
	end
	
	function t:setScale(x,y)
		assert(x, "FAILURE: typewriter:setScale() :: missing param[x]")
		assert(type(x) == "number", "FAILURE: typewriter:setScale() :: incorrect param[x] - number expected, but " .. type(x) .. " supplied.")
		assert(y, "FAILURE: typewriter:setScale() :: missing param[y]")
		assert(type(y) == "number", "FAILURE: typewriter:setScale() :: incorrect param[y] - number expected, but " .. type(y) .. " supplied.")
		self.scale = {x,y}
	end
	
	function t:getScale()
		return self.scale
	end
	
	function t:setText(t)
		assert(t, "FAILURE: typewriter:setScale() :: missing param[t]")
		assert(type(t) == "text", "FAILURE: typewriter:setScale() :: incorrect param[t] - text expected, but " .. type(t) .. " supplied.")
		self.oText = t
		self.text = typewriter:split(t)
		self:reset()
	end
	
	function t:getText()
		return self.oText
	end
	
	function t:stop()
		self.curPrint = 1
		self.toShow = ""
		self.isStopped = true
	end
	
	function t:play()
		if self.curPrint >= #self.toShow then
			self.curPrint = 1
			self.toShow = ""
		end
		self.finished = false
		self.isStopped = false
	end
	
	function t:pause()
		self.finished = true
	end

	function t:toggle(r)
		self.show = not self.show
		if r then self:reset() end
	end
	
	function t:remove()
		typewriter.typewriters[self.id] = {}
		self = {}
	end
	
	function t:reset(full)
		self.timeWaited = 0
		self.curPrint = 1
		self.toShow = ""
		self.finished = false
		self.isStopped = false
		if full then
			self.scale = {1,1}
			self.timeToWait = self.oTime
			if self.oFont then self.font = t.oFont end
		end
	end
	
	self.typewriters[t.id] = self:create(t)
	return self.typewriters[t.id]
end

function typewriter:create(item)
	local copies = {}
    local copy
    if type(item) == 'table' then
        if copies[item] then
            copy = copies[item]
        else
            copy = {}
            copies[item] = copy
            for orig_key, orig_value in next, item, nil do
                copy[self:create(orig_key, copies)] = self:create(orig_value, copies)
            end
            setmetatable(copy, self:create(getmetatable(item), copies))
        end
    else
        copy = item
    end
    return copy
end

function typewriter:split(str)
	local t={}
	for s in string.gmatch(str, ".") do
		t[#t+1] = s
	end
	return t
end

function typewriter:update(dt)
	for _,t in ipairs(self.typewriters) do if t.show and not t.isStopped then t:update(dt) end end
end

function typewriter:draw()
	for _,t in ipairs(self.typewriters) do if t.show and not t.isStopped then t:draw() end end
end

return typewriter

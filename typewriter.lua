--[[
	Requires LOVE2D -- https://love2d.org/
	Written By: David Ashton | CognizanceGaming | CZGaming94
	Free for use in any project. No compensation is required. 
	It is only requested you leave this publication tag.
--]]

local lg = love.graphics
local typewriter = {}
typewriter.typewriters = {}

-- text, time between each letter, x, y, repeat, z index
function typewriter:new(text, l, x, y, r, z)
	typewriter:errorCheck("new", "text")
	typewriter:errorCheck("new", "text", {"string", "table"}, text)
	typewriter:errorCheck("new", "length")
	typewriter:errorCheck("new", "length", "number", l)
	typewriter:errorCheck("new", "x")
	typewriter:errorCheck("new", "x", "number", x)
	typewriter:errorCheck("new", "y")
	typewriter:errorCheck("new", "y", "number", y)
	if r then typewriter:errorCheck("new", "repeat", "boolean", r) end
	if z then typewriter:errorCheck("new", "z", "number", z) end
	
	local t = {}
	if type(text) == "table" then
		if text[2] then
			typewriter:errorCheck("new", "text[color]", "table", text[2])
			while type(text[2][1]) == "table" do text[2] = text[2][1] end
		end
		text, t.color, t.font = unpack(text)
		t.oFont = t.font
	end
	t.text = self:split(text)
	t.oText = text
	t.color = t.color or {lg.getColor()}
	t.oColor = t.color
	t.font = t.font or lg.getFont()
	t.oFont = t.font
	t.timeWaited = 0
	t.timeToWait = l
	t.oTime = l
	t.curPrint = 1
	t.toShow = ""
	t.oX = x
	t.x = x
	t.oY = y
	t.y = y
	t.oZ = z or 0
	t.z = z or 0
	t.id = #self.typewriters + 1
	t.finished = false
	t.runCount = 0
	t.show = true
	t.rep = r or false
	t.stopped = false
	t.paused = false
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
		lg.push()
		lg.scale(unpack(self.scale))
		
		if self.background[1] then
			local fill, color, xPad, yPad, round, wrap = unpack(self.background)
			lg.setColor(color)
			if round then
				lg.rectangle(fill, self.x - (xPad / 2), self.y - (yPad / 2), self.font:getWidth(self.oText) + xPad, self.font:getHeight(self.oText) + yPad, 5, 5)
			else
				lg.rectangle(fill, self.x - (xPad / 2), self.y - (yPad / 2), self.font:getWidth(self.oText) + xPad, self.font:getHeight(self.oText) + yPad)
			end
			if wrap then
				lg.setColor(wrap)
				if round then
					lg.rectangle("line", self.x - (xPad / 2), self.y - (yPad / 2), self.font:getWidth(self.oText) + xPad, self.font:getHeight(self.oText) + yPad, 5, 5)
				else
					lg.rectangle("line", self.x - (xPad / 2), self.y - (yPad / 2), self.font:getWidth(self.oText) + xPad, self.font:getHeight(self.oText) + yPad)
				end
			end
		end
		
		lg.print({self.color, self.toShow}, self.font, self.x, self.y)
		
		lg.setColor(1,1,1,1)
		lg.pop()
	end
	
	function t:setBackground(fill, color, round, xPad, yPad, wrap)
		typewriter:errorCheck("setBackground", "fill")
		typewriter:errorCheck("setBackground", "fill", "string", fill)
		typewriter:errorCheck("setBackground", "color")
		typewriter:errorCheck("setBackground", "color", "table", color)
		if round then typewriter:errorCheck("setBackground", "round", "boolean", round) end
		if xPad then typewriter:errorCheck("setBackground", "xPad", "number", xPad) end
		if yPad then typewriter:errorCheck("setBackground", "yPad", "number", yPad) end
		if wrap then typewriter:errorCheck("setBackground", "wrap", "table", wrap) end
		
		xPad, yPad = xPad or 0, yPad or 0
		self.background = {fill, color, xPad, yPad, round, wrap}
	end
	
	function t:getBackground()
		return self.background
	end
	
	function t:setColor(c)
		typewriter:errorCheck("setColor", "c")
		typewriter:errorCheck("setColor", "c", "table", c)
		self.color = c
	end
	
	function t:getColor()
		return self.color
	end
	
	function t:setFont(f)
		typewriter:errorCheck("setFont", "f")
		typewriter:errorCheck("setFont", "f", "userdata", f)
		self.font = f
	end
	
	function t:getFont()
		return self.font
	end
	
	function t:setPos(x,y,z)
		typewriter:errorCheck("setPos", "x")
		typewriter:errorCheck("setPos", "x", "number", x)
		typewriter:errorCheck("setPos", "y")
		typewriter:errorCheck("setPos", "y", "number", y)
		if z then typewriter:errorCheck("setPos", "z", "number", z) end
		self.x, self.y, self.z = x, y, z or self.z 
	end
	
	function t:getPos()
		return self.x, self.y, self.z
	end
	
	function t:setRepeat(r)
		typewriter:errorCheck("setRepeat", "r")
		typewriter:errorCheck("setRepeat", "r", "boolean", r)
		self.rep = r
	end
	
	function t:getRepeat()
		return self.rep
	end
	
	function t:setScale(x,y)
		typewriter:errorCheck("setScale", "x")
		typewriter:errorCheck("setScale", "x", "number", x)
		typewriter:errorCheck("setScale", "y")
		typewriter:errorCheck("setScale", "y", "number", y)
		self.scale = {x,y}
	end
	
	function t:getScale()
		return self.scale
	end
	
	function t:setSpeed(s)
		typewriter:errorCheck("setSpeed", "speed")
		typewriter:errorCheck("setSpeed", "speed", "number", s)
		self.timeToWait = tonumber(s)
	end
	
	function t:getSpeed()
		return self.timeToWait
	end
	
	function t:setText(t)
		typewriter:errorCheck("setText", "text")
		typewriter:errorCheck("setText", "text", "string", t)
		self.oText = t
		self.text = typewriter:split(t)
		self:reset()
	end
	
	function t:getText()
		return self.oText
	end
	
	function t:setX(x)
		typewriter:errorCheck("setX", "x")
		typewriter:errorCheck("setX", "x", "number", x)
		self.x = x
	end
	
	function t:getX()
		return self.x
	end
	
	function t:setY(y)
		typewriter:errorCheck("setY", "y")
		typewriter:errorCheck("setY", "y", "number", y)
		self.y = y
	end
	
	function t:getY()
		return self.y
	end
	
	function t:setZ(z)
		typewriter:errorCheck("setZ", "z")
		typewriter:errorCheck("setZ", "z", "number", z)
		self.z = z
	end
	
	function t:getZ()
		return self.z
	end
	
	function t:play()
		if self.curPrint >= #self.toShow then
			self.curPrint = 1
			self.toShow = ""
		end
		self.finished = false
		self.paused = false
		self.stopped = false
	end
	
	function t:isPlaying()
		return (self:isPaused() or self:isStopped()) and false or true
	end
	
	function t:pause()
		self.paused = true
	end
	
	function t:isPaused()
		return self.isPaused
	end
	
	function t:stop()
		self.curPrint = 1
		self.toShow = ""
		self.stopped = true
	end
	
	function t:isStopped()
		return self.isStopped
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
		self.stopped = false
		self.paused = false
		if full then
			self.scale = {1,1}
			self.color = t.oColor
			self.font = t.oFont
			self.timeToWait = self.oTime
			self.x = self.oX
			self.y = self.oY
			self.z = self.oZ
		end
	end
	
	self.typewriters[t.id] = self:create(t)
	return self.typewriters[t.id], self:sort()
end

function typewriter:sort()
	table.sort(self.typewriters, function(a,b) return a.z > b.z end)
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

function typewriter:errorCheck(f, p, t, v)
	if t then
		if type(t) == "table" then
			local failed = false
			for _,i in ipairs(t) do 
				if i == type(v) then
					failed = false
					t = i
					break
				else
					failed = true
				end
			end
		end
		assert(type(v) == t, "FAILURE: typewriter:" .. f .. "() :: incorrect param[" .. p .. "] - " .. t .. " expected, but " .. type(v) .. " supplied.")
	else
		assert(p, "FAILURE: typewriter:" .. f .. "() :: missing param[" .. p .. "]")
	end
end

function typewriter:update(dt)
	for _,t in ipairs(self.typewriters) do if t.show and t:isPlaying() then t:update(dt) end end
end

function typewriter:draw()
	for _,t in ipairs(self.typewriters) do if t.show and t:isPlaying() then t:draw() end end
end

return typewriter

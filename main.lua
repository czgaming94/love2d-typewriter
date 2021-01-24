local typewriter = require("typewriter")

local myFont = love.graphics.newFont("pixelated.ttf")
local colors = { 
	red = {1,0,0,1}, 
	yellow = {1,1,0,1},
	green = {0,1,0,1}, 
	cyan = {0,1,1,1},
	blue = {0,0,1,1},
	purple = {1,0,1,1},
	white = {1,1,1,1}, 
	black = {0,0,0,0} 
}

local a = typewriter:new("hello", 0.5, 5, 10, false, 3)
local b = typewriter:new({"world", colors.color}, 0.5, 40, 10)
local c = typewriter:new({"This is my text...", {1,0,1,1}, myFont}, 0.05, 5, 50, true)
local d = typewriter:new({"Let's get it started", nil, myFont}, 0.01, 100, 100, false, 1)
local e = typewriter:new({"In heeeeeere!", colors.blue}, 0.015, 5, 10, false, 1)

local playTime = 0

function love.load()
	local dSettings = {
		"fill",			-- fill / line
		{0,0.4,0.3,0.5},	-- color
		true,			-- round corners
		20,				-- x padding
		30,				-- y padding
		{0,1,0.3,1}		-- wrap with line
	}
	
	-- set box background behind typewriter
	d:setBackground(unpack(dSettings))
	
	-- scale your text
	a:setScale(5,2)
	
	-- pause typewriter. keep position
	e:pause()
	
	-- store position of text
	local x,y = a:getPos()
end

function love.update(dt)
	typewriter:update(dt)
	playTime = playTime + dt
	
	if c.runCount == 3 then 
		-- fully stop typewriter. resets text
		d:stop() 
		
		-- change typewriter text. resets text
		b:setText("boys and girls!")
		
		-- reset typewriter, including scale speed and font
		a:reset(true)
	end 
	
	if c.runCount == 4 then 		
		-- change just x position
		a:setX(375)
		
		-- change just y position
		d:setY(300)
		
		-- change just z position
		e:setZ(2)
		
		-- start typewriter
		if e:isStopped() then e:play() end
		
		-- change both x,y position
		c:setPos(200,200)
		
		-- change full position
		b:setPos(100,300,5)
	end
	
	if c.runCount == 5 then	
		-- reset typewriter, only position
		d:reset()
	end
	
	if c.runCount == 6 then 
		-- check if typewriter is running
		if c:isPlaying() then 
			-- remove typewriter from list
			c:remove() 
		end
	end
	
	if playTime > 2 then 
		playTime = 0
		
		-- change color of text
		if b:getColor() ~= colors.red then b:setColor(colors.red) end
		
		-- change font of text
		if b:getFont() ~= myFont then b:setFont(myFont) end
		
		-- change speed of print
		if c:getSpeed() ~= 0.2 then c:setSpeed(0.02) end
		
		-- check if typewriter is stopped
		if c:isStopped() then
			-- play typewriter 
			c:play() 
		end
		
		-- toggle on and off, don't reset text
		c:toggle(false)
		
		-- toggle on and off, reset text
		a:toggle(true)
	end
end

function love.draw()
	typewriter:draw()
end
	typewriter:update(dt)
	playTime = playTime + dt
	
	if c.runCount == 3 then 
		-- fully stop typewriter. resets text
		d:stop() 
		
		-- change typewriter text. resets text
		b:setText("boys and girls!")
		
		-- reset typewriter, including scale speed and font
		a:reset(true)
	end 
	
	if c.runCount == 4 then 		
		-- change just x position
		a:setX(375)
		
		-- change just y position
		d:setY(300)
		
		-- change just z position
		e:setZ(2)
		
		-- start typewriter
		if e:isStopped() then e:play() end
		
		-- change both x,y position
		c:setPos(200,200)
		
		-- change full position
		b:setPos(100,300,5)
	end
	
	if c.runCount == 5 then	
		-- reset typewriter, only position
		d:reset()
	end
	
	if c.runCount == 6 then 
		-- check if typewriter is running
		if c:isPlaying() then 
			-- remove typewriter from list
			c:remove() 
		end
	end
	
	if playTime > 2 then 
		playTime = 0
		
		-- change color of text
		if b:getColor() ~= colors.red then b:setColor(colors.red) end
		
		-- change font of text
		if b:getFont() ~= myFont then b:setFont(myFont) end
		
		-- change speed of print
		if c:getSpeed() ~= 0.2 then c:setSpeed(0.02) end
		
		-- play typewriter
		if c:isStopped() then c:play() end
		
		-- toggle on and off, don't reset text
		c:toggle(false)
		
		-- toggle on and off, reset text
		a:toggle(true)
	end
end

function love.draw()
	typewriter:draw()
end

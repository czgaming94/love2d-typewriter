local typewriter = require("typewriter")

local myFont = love.graphics.newFont("pixelated.ttf")
local colors = { red = {1,0,0,1}, blue = {0,1,0,1}, green = {0,0,1,1}, white = {1,1,1,1}, black = {0,0,0,0} }

local a = typewriter:new("hello", .5, 5, 10)
local b = typewriter:new({"world", {0,1,1,1}}, .5, 40, 10)
local c = typewriter:new({"This is my text...", {1,0,1,1}, myFont}, .05, 5, 50, true)
local d = typewriter:new({"Let's get it started", nil, myFont}, .01, 100, 100)

local playTime = 0

function love.load()
	local dSettings = {
		"fill",			-- fill / line
		{0,.4,.3,.5},	-- color
		true,			-- round corners
		20,				-- x padding
		30,				-- y padding
		{0,1,.3,1}		-- wrap with line
	}
	
	-- set box background behind typewriter
	d:setBackground(unpack(dSettings))
	
	-- scale your text
	a:setScale(5,2)
end

function love.update(dt)
	typewriter:update(dt)
	playTime = playTime + dt
	
	if c.runCount == 3 then 
		-- fully stop typewriter. resets text
		d:stop() 
		
		-- reset typewriter, including scale speed and font
		a:reset(true)
	end 
	
	if c.runCount == 4 then 
		-- pause typewriter. keep position
		a:pause() 
	end
	
	if c.runCount == 5 then	
		-- reset typewriter, only position
		d:reset()
	end
	
	if c.runCount == 6 then 
		-- remove typewriter from list
		c:remove() 
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
		if c.isStopped then c:play() end
		
		-- toggle on and off, don't reset text
		c:toggle(false)
		
		-- toggle on and off, reset text
		a:toggle(true)
	end
end

function love.draw()
	typewriter:draw()
end

local typewriter = require("typewriter")

local myFont = love.graphics.newFont("pixelated.ttf")
local myFont2 = love.graphics.newFont("thicktext.ttf")

local a = typewriter:new("hello", 0.5, 5, 10, 3, false)
local b = typewriter:new("world", colors.color, 0.5, 40, 10)
local c = typewriter:new("This is my text...",, 0.05, 5, 50, true)
local d = typewriter:new("Let's get it started", 0.01, 100, 100, 1, false)
local e = typewriter:new("In heeeeeere!", 0.015, 5, 10, 1, false)

local playTime = 0

function love.load()
	-- load a font into the typewriter module
	typewriter:addFont(myFont, "myFont")
	typewriter:addFont(myFont2, "myFont2")
	
	-- load a color into the typewriter module
	typewriter:addColor({.2,1,.4,1},"mySpecialColor")
	
	-- change font of typewriter
	if b:getFont() ~= typewriter:font("myFont") then b:setFont("myFont") end
	
	-- change repeat of typewriter
	b:setRepeat(true)
	
	local greenWrap = {
		"fill",			-- fill / line
		{0,0.4,0.3,0.5},	-- color
		true,			-- round corners
		20,				-- x padding
		30,				-- y padding
		{0,1,0.3,1}		-- wrap with line
	}
	
	-- load a background into the typewriter module
	typewriter:addBackground(greenWrap, "greenWrap")
	
	-- set box background behind typewriter
	d:setBackground("greenWrap")
	
	-- scale your typewriter
	a:setScale(5,2)
	
	-- pause typewriter. keep position
	e:pause()
	
	-- store position of typewriter text
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
		
		-- unload color from typewriter module
		typewriter:removeColor("mySpecialColor")
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
		if b:getColor() ~= typewriter:color("red") then b:setColor("red") end
		
		-- change speed of print
		if c:getSpeed() ~= 0.2 then c:setSpeed(0.02) end
		
		-- check if typewriter is stopped
		if c:isStopped() then
			-- play typewriter 
			c:play() 
			
			-- unload font from typewriter module
			typewriter:removeFont("myFont2")
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

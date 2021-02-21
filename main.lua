local typewriter = require("typewriter")
local myFont = love.graphics.newFont("pixelated.ttf")

local colors = { red = {1,0,0,1}, green = {0,1,0,1}, blue = {0,0,1,1} }

local a = typewriter:new("hello")
local b = typewriter:new("dance")
local c = typewriter:new("pet")

local playTime = 0

function love.load()
	a:setData({t = "Hello World!", x = 10, y = 100, color = colors.green, font = myFont, typewriter = true, speed = 2})
	b:setData({t = "Let's go to the dance." x = 50, y = 250, typewriter = true, color = colors.blue, speed = 4})
	c:setData({t = "No pets are allowed at the dance.", x = 50, y = 265, typewriter = true, color = colors.blue, speed = 0.5})
end

function love.update(dt)
	typewriter:update(dt)
	playTime = playTime + dt
	
	if playTime > 2 then 
		playTime = 0
		if b:getColor() ~= colors.red then b:setColor(colors.red) end
	end
end

function love.draw()
	typewriter:draw()
end

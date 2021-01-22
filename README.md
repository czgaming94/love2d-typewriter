# __LOVE2D Typewriter__
This is a simple yet effective typewriter API for LOVE2D text display.

### Examples
```lua 
--[[
  text
  time between each letter
  x
  y
  repeat
--]]
local t = typewriter:new("hello world", .05, 5, 10)
local t2 = typewriter:new({"This is my text...", {1,0,1,1}, myFont}, .05, 5, 50, true)
```

##### You can use these to modify the date of the typewriter<br>
```lua
:setBackground
:setColor
:setFont
:setScale
:setSpeed
```
##### You can use these to modify the state of the typewriter<br>
```lua
:play
:pause
:reset
:stop
```
##### You can use these to get information from the typewriter<br>
```lua
:getBackground
:getColor
:getFont
:getScale
:getSpeed
```
Get detailed examples inside of [main.lua](https://github.com/czgaming94/love2d-typewriter/blob/main/main.lua)

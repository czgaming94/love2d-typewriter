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
  z index
--]]
local t = typewriter:new("hello world", .05, 5, 10)
local t2 = typewriter:new({"This is my text...", {1,0,1,1}, myFont}, .05, 5, 50, true)
```

##### You can use these to modify the data of the typewriter<br>
```lua
:setBackground
:setColor
:setFont
:setPos
:setScale
:setSpeed
:setText
:setX
:setY
:setZ
```
##### You can use these to modify the state of the typewriter<br>
```lua
:play
:pause
:reset
:stop
:toggle
:remove
```
##### You can use these to get information from the typewriter<br>
```lua
:getBackground
:getColor
:getFont
:getPos
:getScale
:getSpeed
:getText
:getX
:getY
:getZ

:isPlaying
:isPaused
:isStopped

```
Get detailed examples inside of [main.lua](https://github.com/czgaming94/love2d-typewriter/blob/main/main.lua)

# __LOVE2D Typewriter__
This is a simple yet effective typewriter API for LOVE2D text display.<br>
Simulates oldschool typewriter text display, by creating timed printing of supplied text over supplied time.

## Examples
```lua 
--[[
  text
  time between each letter
  x
  y
  z index
  repeat
--]]
local t = typewriter:new("hello world", .05, 5, 10, 1)
local t2 = typewriter:new("This is my text...", .05, 5, 50, 2, true)
```
### Typewriter Module
#### You can use these to modify the data of the typewriter module<br>
```lua
:addBackground
  -->typewriter:addBackground(wrap, "wrap")
:getBackground
  -->local wrapBackground = typewriter:getBackground("wrap")
:removeBackground
  -->typewriter:removeBackground("wrap")
  
:addColor
  -->typewriter:addColor({.2,1,.4,1},"mySpecialColor")
:getColor
  -->local specialColor = typewriter:getColor("mySpecialColor")
:removeColor
  -->typewriter:removeColor("mySpecialColor")
  
:addFont
  -->typewriter:addFont(myFont, "myFont")
:getFont
  -->local myFontReference = typewriter:getFont("myFont")
:removeFont
  -->typewriter:removeFont("myFont")
```
### Typewriter Objects
##### You can use these to modify the data of the typewriters<br>
```lua
:setBackground
  -->t:setBackground("wrap")
:setColor
  -->t:setColor("mySpecialColor")
:setFont
  -->t:setFont("myFont")
:setPos
  -->t:setPos(200,300)
  -->t:setPos(200,300,2)
:setRepeat
  -->t:setRepeat(true)
:setScale
  -->t:setScale(1.5,1.2)
:setSpeed
  -->t:setSpeed(0.1)
:setText
  -->t:setText("Hello")
:setX
  -->t:setX(5)
:setY
  --t:setY(500)
:setZ
  --t:setZ(1)
```
##### You can use these to modify the state of the typewriters<br>
```lua
:play
  -->t:play()
:pause
  -->t:pause()
:reset
  --t:reset()
:stop
  --t:stop()
:toggle
  --t:toggle()
:remove
  --t:remove()
```
##### You can use these to get information from the typewriters<br>
```lua
:getBackground
  -->local tBackground = t:getBackground()
:getColor
  -->local tColor = t:getColor()
:getFont
  -->local tFont = t:getFont()
:getPos
  -->local tPos = t:getPos()
:getRepeat
  -->local tRepeat = t:getRepeat()
:getScale
  -->local tScale = t:getScale()
:getSpeed
  -->local tSpeed = t:getSpeed()
:getText
  -->local tText = t:getText()
:getX
  -->local tX = t:getX()
:getY
  -->local tY = t:getY()
:getZ
  -->local tZ = t:getZ()

:isPlaying
  -->if t:isPlaying() then ... end
:isPaused
  --if t:isPaused() then ... end
:isStopped
  ---if t:isStopped() then ... end
```
Get detailed examples inside of [main.lua](https://github.com/czgaming94/love2d-typewriter/blob/main/main.lua)

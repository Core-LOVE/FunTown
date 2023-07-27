---@class Line : Object
---@overload fun(...) : Line
local Line, super = Class(Object)

function Line:init(x, y, x2, y2)
    super.init(self, x, y)
	self.x2 = x2 or x or 0
	self.y2 = y2 or y or 0
	
    self.color = {1, 1, 1}

    self.line = false
    self.line_width = 1
end

function Line:draw()
    love.graphics.setLineWidth(self.line_width)
    love.graphics.line(0, 0, self.x2, self.y2)

    love.graphics.setColor(1, 1, 1, 1)
    super.draw(self)
end

return Line
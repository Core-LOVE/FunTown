local SimpleText, super = Class(Object)

function SimpleText:init(text, x, y)
	super:init(self, x, y)
	
	self.text = text
end

function SimpleText:draw()
	super:draw(self)
	
	love.graphics.print(self.text, 0, 0)
end

return SimpleText
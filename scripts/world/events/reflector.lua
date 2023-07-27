local MyEvent, super = Class(Event)

function MyEvent:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

	self.collider = Hitbox(self, 24, 24, 1, 1)
	self.id = "reflector"
	
	local properties = data.properties or {}
	
	self:setScale(2)
    self:setOrigin(0.5, 0.5)
    self:setSprite("objects/reflector", 0.25)
end

return MyEvent
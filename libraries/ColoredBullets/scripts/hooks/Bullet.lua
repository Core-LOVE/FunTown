local Bullet, super = Class(Bullet)

function Bullet:setType(newclass)
	if newclass.postInit then
		newclass.postInit(self)
	end
	
	self.onCollide = newclass.onCollide
	self.update = newclass.update
end

return Bullet
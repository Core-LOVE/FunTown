local id = "superstar/cutter"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)
	
	self.isCutting = true
    self:setSprite("bullets/" .. id, 3 / 30, true)

	self:setLayer(self.layer + 1)
end

function MyBullet:update()
	super.update(self)
end

return MyBullet
local id = "novanna/mini"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, size)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	
    self:setHitbox(0, 0, 12, 16)
	
	self.physics.gravity = math.random(1, 2) / 6
end

function MyBullet:update()
	super.update(self)
	
	self.rotation = math.atan2(self.physics.speed_y, self.physics.speed_x) - math.rad(90)
end

return MyBullet
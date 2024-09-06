local MyBullet, super = Class(Bullet, "diamond")

function MyBullet:init(x, y, angle, speed)
	local angle = angle or 0
    super:init(self, x, y)

	self.damage = 100
	-- self.damage = 0

	self:setSprite("bullets/diamond")
	
    self:setHitbox(1, 1, 4, 4)
	-- self:setScale(1, 1)
	
	self.physics.match_rotation = true
	self.rotation = angle + math.rad(180)
    self.physics.speed = speed or 8
	
	-- self.remove_offscreen = false
end

function MyBullet:remove(...)
	super:remove(self, ...)
end

function MyBullet:update()
    super:update(self)
end

return MyBullet
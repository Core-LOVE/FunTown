local id = "lumia/droplet"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, size)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	
	local hitbox_w, hitbox_h = 4, 4
	local hitbox_x, hitbox_y = (8 - hitbox_w) * .5, (16 - hitbox_h) * .75

    self:setHitbox(hitbox_x, hitbox_y, hitbox_w, hitbox_h)
    
	self.physics.gravity = 0.3
end

function MyBullet:update()
	super.update(self)
	
	self.rotation = math.atan2(self.physics.speed_y, self.physics.speed_x) + math.rad(270)
end

return MyBullet
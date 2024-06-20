local id = "superstar/darkdollar"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, size)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	
    self:setHitbox(0, 0, 96, 192)
	
	self.physics.speed_y = 4
	self.remove_offscreen = false
	self.cutout_bottom = 0
	self.tp = 0
	
	self.damage = 0
	self.destroy_on_hit = false
end

function MyBullet:update()
	super.update(self)
	
    for _,bullet in ipairs(Game.stage:getObjects(Bullet)) do
        if bullet:collidesWith(self.collider) and bullet.isCutting then
			self.cutout_bottom = self.cutout_bottom + (self.physics.speed_y * .5)
        end
    end
end

return MyBullet
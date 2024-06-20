local id = "lumia/bird"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 3 / 30, true)
	
    self:setHitbox(2, 2, 2, 2)
end

function MyBullet:movement() 
	self.sinTimer = self.sinTimer or 0
	self.sinTimer = self.sinTimer + 1

	local sinSpeed = math.cos(self.sinTimer / 2) * (self.sinTimer / 7.5)
	self.y = self.y + (self.sinSpeed * self.sinDir)
end

function MyBullet:update()
	super.update(self)
	self:movement()
end

return MyBullet
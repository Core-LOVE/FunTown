local id = "lumia/bird"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

	local soul = Game.battle.soul

    self:setSprite("bullets/" .. id, 3 / 30, true)
	self.physics.direction = (rot ~= nil and rot) or math.atan2(soul.y - self.y, soul.x - self.x)
	self.tp = 1
	
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
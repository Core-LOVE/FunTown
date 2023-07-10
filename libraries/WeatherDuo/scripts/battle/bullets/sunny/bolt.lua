local id = "sunny/bolt"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id)
	
    self:setHitbox(0, 0, 14, 18)
	self:setScale(1, 1)
	
	-- self.tp = 0
	-- self.damage = 0
	self.physics.direction = math.atan2(Game.battle.soul.y - self.y, Game.battle.soul.x - self.x)
	self.physics.speed = 7.5
	
	local timer = Timer()
	timer:tween(0.75, self, {scale_x = 2, scale_y = 2}, nil, function()
		timer:remove()
	end)
	
	self:addChild(timer)
end

return MyBullet
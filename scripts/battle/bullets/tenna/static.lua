local id = "tenna/static"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setScale(1, 1)
	
    self:setHitbox(0, 0, 32, 32)
	self.color = {1, 1, 1}
	
	self.layer = BATTLE_LAYERS.above_bullets
end

function MyBullet:draw()
	love.graphics.rectangle('fill', 0, 0, 32, 32)
end

return MyBullet
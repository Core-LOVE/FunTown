local id = "eternal lumia/stick"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, rot)
    super:init(self, x, 470)
    self:setSprite("bullets/" .. id, 4 / 60, true)
	
	-- self:setScale(1)
    self:setHitbox(6, 3, 12, 6)
end

return MyBullet
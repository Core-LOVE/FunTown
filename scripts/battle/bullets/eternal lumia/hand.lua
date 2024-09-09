local id = "eternal lumia/hand"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x + 4, y)
    self:setSprite("bullets/" .. id, 0.05, false)
end

return MyBullet
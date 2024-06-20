local id = "eternal lumia/light"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)
    self:setSprite("bullets/" .. id, 4 / 60, true)
end

return MyBullet
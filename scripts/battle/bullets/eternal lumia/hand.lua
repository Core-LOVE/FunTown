local id = "eternal lumia/hand"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)
    self:setSprite("bullets/" .. id .. "_holding", 4 / 60, true)
end

return MyBullet
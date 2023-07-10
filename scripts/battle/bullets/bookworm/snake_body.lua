local id = "bookworm/snake_body"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id)
	
    self:setHitbox(0, 0, 8, 8)
	
	self.destroy_on_hit = false
	
	self.timer = Timer()
	self:addChild(self.timer)
	
	self.layer = self.layer + 10
end

return MyBullet
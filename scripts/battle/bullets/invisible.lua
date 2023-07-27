local id = "invisible"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, size)
    super:init(self, x, y)

	self.visible = false
	
    self:setSprite("bullets/" .. id, 4 / 60, true)
	self.color = {1, 0, 0}
	self:setScale(1)
	
	self.destroy_on_hit = false
	
    self:setHitbox(0, 0, 16, 16)
end

-- function MyBullet:draw()
	-- super.draw(self)

    -- love.graphics.rectangle("fill", 0, 0, self.width, self.height)

    -- love.graphics.setColor(1, 1, 1, 1)
    -- super.draw(self)
-- end

return MyBullet
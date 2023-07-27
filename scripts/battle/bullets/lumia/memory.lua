local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

	self.tp = 0
	self.destroy_on_hit = false
	self.damage = 0
end

-- function MyBullet:update()
	-- super.update(self)
-- end

function Bullet:onCollide(soul)
    if soul.inv_timer == 0 then
        self:onDamage(soul)
    end

    if self.destroy_on_hit then
        self:remove()
    end
end

return MyBullet
local id = "lumia/card"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(type, x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id .. "/" .. (type or "club"), 3 / 30, true)

    self:setHitbox(0, 0, 32, 48)

	self.tp = 0
	self.destroy_on_hit = false
	self.damage = 0

	local soul = Game.battle.soul

	self.physics.match_rotation = true
	self.rotation = (rot ~= nil and rot) or math.atan2(soul.y - self.y, soul.x - self.x)
end

function MyBullet:update()
	super.update(self)
end

return MyBullet
local id = "lumia/doll/part_nose"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, rot)
    super:init(self, x, y)

	Assets.playSound("noise", 0.75, 0.75)

	local soul = Game.battle.soul

    self:setSprite("bullets/" .. id, 3 / 30, true)

	self.physics.match_rotation = true
	-- self.physics.speed = -8
	self.rotation = rot or 0
	-- self:setRotationOrigin(0.75, 0)

    self:setHitbox(4, 4, 2, 2)
end

function MyBullet:draw()
	love.graphics.push('all')
	love.graphics.origin()

	love.graphics.setColor(0.5, 0.5, 0.5, 0.5)
	love.graphics.line(self.x, self.y, self.init_x, self.init_y)

	love.graphics.pop()

	super.draw(self)
end

return MyBullet
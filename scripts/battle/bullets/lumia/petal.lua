local id = "lumia/petal"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, size)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	
    self:setHitbox(6, 6, 6, 6)
	self.graphics.spin = 0.125
	self.alpha = 0.1
	
	local t = Timer()
	
	t:tween(.5, self, {alpha = 1}, nil, function()
		local arena = Game.battle.arena
		
		if self.x < arena.x - 71 then
			t:tween(.25, self, {alpha = 0}, nil, function()
				self:remove()
			end)
		end
	end)
	
	self._t = 0
	self:addChild(t)
end

function MyBullet:update()
	super.update(self)
	
	self._t = self._t + 0.01
	
	self.physics.speed_y = math.sin(self._t) * 4
end

return MyBullet
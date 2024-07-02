local id = "lumia/petal"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, size)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	
	local hitbox_w, hitbox_h = 4, 4
	local hitbox_x, hitbox_y = (12 - hitbox_w) * .5, (12 - hitbox_h) * .5

    self:setHitbox(hitbox_x, hitbox_y, hitbox_w, hitbox_h)
    
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
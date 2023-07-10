local id = "luna/rain"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id)
	
    self:setHitbox(0, 0, 3, 6)
	self:setScale(1, 1)
	
	-- self.tp = 0
	-- self.damage = 0
	
	self.timer = Timer()
	-- self.timer:tween(0.4, self, {radius = 24}, 'out-circ')
	-- self.timer:tween(0.7, self, {x = 96, }, 'out-sine'
	
	self.alpha = 0
	self.timer:tween(0.1, self, {alpha = 1})
	
	self.timer:script(function(wait)
		wait(0.5)
		self.timer:tween(0.25, self, {alpha = 0}, nil, function()
			self:remove()
		end)
	end)
	
	self:addChild(self.timer)
end

function MyBullet:update()
	super.update(self)
	
	self.physics.speed_y = self.physics.speed_y + 0.34
	self.scale_y = self.physics.speed_y * 0.2
end

return MyBullet
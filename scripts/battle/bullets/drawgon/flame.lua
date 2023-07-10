local id = "drawgon/flame"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, size)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	
    self:setHitbox(0, 0, 4, 4)
	
	self.willFade = false
end

function MyBullet:update()
	super:update(self)
	
	if not self.willFade then
		if self.x < Game.battle.soul.x then
			self:fadeTo(0, 4, function()
				self:remove()
			end)
		end	
	end
	
	self:setScale(self.physics.speed / 2.5)

	self.physics.speed = self.physics.speed - 0.025
	if self.physics.speed < 0 then
		self:remove()
	end
end

return MyBullet
local id = "drawgon/person"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 3 / 30, true)
	
    self:setHitbox(0, 16, 16, 16)
	self.scale_origin_y = 1
	self.scale_y = 0
	
	local timer = Timer()
	self:addChild(timer)
	
	timer:script(function(wait)
		while self.scale_y < 2 do
			self.scale_y = self.scale_y + 0.3
			wait()
		end
		
		wait(0.25)
		
		while self.scale_y > 0 do
			self.scale_y = self.scale_y - 0.25
			wait()
		end
		
		self:remove()
	end)
end

return MyBullet
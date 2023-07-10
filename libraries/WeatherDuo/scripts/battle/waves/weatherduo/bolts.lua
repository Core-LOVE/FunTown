local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.enemies = self:getAttackers()
	self.time = -1
end

function MyWave:shoot()
	local enemies = self.enemies
	
	for k,enemy in ipairs(enemies) do
		self.timer:script(function(wait)
			wait(0.5)
			
			for i = 1, 4 do
				local bullet = self:spawnBullet("sunny/bolt", enemy.x - 32, enemy.y - 72)
				wait(0.15)
			end
			
			enemy:setAnimation('idle')
			
			wait(1)
			
			self:shoot()
		end)
		
		enemy:setAnimation('shoot')
	end
end

function MyWave:onStart()
	self:shoot()
end

return MyWave
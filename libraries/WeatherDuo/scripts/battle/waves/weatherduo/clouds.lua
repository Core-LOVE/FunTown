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
			
			local bullet = self:spawnBullet("luna/cloud", enemy.x - 48, enemy.y - 72)
			bullet.enemy = enemy	
			
		end)
		
		enemy:setAnimation('shoot')
	end
end

function MyWave:onStart()
	self:shoot()
end

return MyWave
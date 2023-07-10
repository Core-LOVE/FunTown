local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.arena_height = 128
	self.arena_width = self.arena_height + self.arena_height
	
	self.time = 5
    self.enemy = self:getAttackers()[1]
end

local function spawnFlame(self, speed)
	Assets.playSound("drawgon_fire", 0.5, 6)
	local speed = speed or 8
	
	local enemy = self.enemy
	local bullet = self:spawnBullet("drawgon/flame", enemy.x, enemy.y - 40, size)
	bullet.physics.direction = math.atan2(Game.battle.soul.y - bullet.y, Game.battle.soul.x - bullet.x) + math.rad(math.random(-4, 4))
	bullet.physics.speed = speed
end

function MyWave:onStart()
	local enemy = self.enemy

    self.timer:script(function(wait)
		-- enemy:setAnimation('idle')	
		
		while true do
			wait(0.8)
			enemy:setAnimation('angry')
			wait(0.22)
			
			spawnFlame(self)
			wait(0.1)
			spawnFlame(self, 6)
			wait(0.1)
			spawnFlame(self, 5)
			wait(0.25)
			spawnFlame(self, 4)
			enemy:setAnimation('idle')
		end
	end)
end

function MyWave:onEnd(death)
	self.enemy:setAnimation('idle')
end

return MyWave
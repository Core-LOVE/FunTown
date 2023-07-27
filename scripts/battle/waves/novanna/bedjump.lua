local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)

	self.time = 7
    self.enemy = self:getAttackers()[1]
	
	self:setArenaSize(208, 96)
end

function MyWave:onStart()
	local arena = Game.battle.arena
	local soul = Game.battle.soul
	local x, y = arena:getBottomLeft()
	
	local bed = self:spawnBullet("novanna/bed", 320, y + 48)
	
	self.timer:script(function(wait)
		local t = 0.9
		
		wait(0.25)
		
		while true do
			for i = -1, 1 do
				local dx = (32 * i)
				
				local bullet = self:spawnBullet("novanna/mini", soul.x + dx, -4)
				bullet.physics.speed_x = math.random(0, 1)
			end
			
			wait(t)
			
			for i = -1, 1 do
				local dx = (16 * i)
				
				local bullet = self:spawnBullet("novanna/mini", soul.x + dx, -4)
				bullet.physics.speed_x = -math.random(0, 1)
			end
			
			wait(t)
		end
	end)
end

return MyWave
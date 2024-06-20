local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.time = -1
    self.enemies = self:getAttackers()
	
	self:setArenaOffset(0, 64)
end

function MyWave:onStart()
	local arena = Game.battle.arena
	
	local x, y = arena:getTopLeft()
	
	self:spawnBullet("superstar/cutter", x + 69, y - 64)
	self:spawnBullet("superstar/darkdollar", x + 69, -192)
		
	-- self.timer:every(3, function()
		-- self:spawnBullet("superstar/darkdollar", x + 69, -192)
	-- end)
end

return MyWave
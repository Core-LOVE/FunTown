local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.time = 7.5
    self.enemies = self:getAttackers()
end

function MyWave:onStart(...)
	local doll = self:spawnBullet("lumia/doll", SCREEN_WIDTH - 96, 96)
end

return MyWave
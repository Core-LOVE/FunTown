local MyWave, super = Class(Wave)

function MyWave:init()
	super:init(self)

	self.arena_width = 80
	self.arena_height = 80
	
	self.time = 2.75
end

function MyWave:onStart()
	Assets.playSound("chirp")
	
	local bullet = self:spawnBullet("lumia/bird", 0, 96)
	bullet.movement = function()

	end

	bullet.physics.direction = 0
	bullet.physics.speed_x = 4
	bullet.physics.speed_y = -1
	bullet.physics.friction = -0.32
end

return MyWave
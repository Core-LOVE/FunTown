local MyWave, super = Class(Wave)

function MyWave:init()
	super:init(self)
	
	self.arena_width = 80
	self.arena_height = self.arena_width
	
	self.time = 7.5
end

local function spawnRocket(self, x)
	self:spawnBullet("eternal lumia/rocket", x, math.random(32, 320))
end

local function spawnBolt(self, x)
	self:spawnBullet("eternal lumia/bolt", x, math.random(32, 320))
end

function MyWave:onStart()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setHeadAnimation("looks", nil, false)
	end

	local angle = 0

	self.timer:every(0.1, function()
		angle = (angle + 32) % 0
	end)

	self.timer:script(function(wait)
		local x = 600
		
		local amount = 5
		local delay = 0.125
		
		while true do
			wait(0.25)
			
			for _ = 1, amount do
				spawnBolt(self, x)
				wait(delay)
			end

			if math.random() > 0.5 then
				x = (x == 600 and 100) or 600
			end

			wait(0.36)

			for _ = 1, 2 do
				spawnRocket(self, x)
				wait(delay)
			end

			x = (x == 600 and 100) or 600

			wait(0.42)
		end
	end)
end

function MyWave:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setHeadAnimation("normalize", 0.08, false, function()
			enemy.sprite:setHeadAnimation()
		end)
	end
end

return MyWave
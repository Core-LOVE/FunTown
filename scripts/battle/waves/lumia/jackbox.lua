local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.time = 7.5
    self.enemies = self:getAttackers()
end

local function randomWithStep(first, last, step)
    local maxSteps = math.floor((last-first)/step)
    return first + step * math.random(0, maxSteps)
end

function MyWave:onStart()
	local step = 64

	self.timer:every(0.7, function()
		local x = randomWithStep(32, 128, step) + 16
		local y = SCREEN_HEIGHT - randomWithStep(32, 208, step) - 160

		if math.random() > 0.5 then
			x = SCREEN_WIDTH - randomWithStep(32, 128, 32) - 16
		end

		local bullet = self:spawnBullet("lumia/jackbox", x, y)
	end)
end

return MyWave
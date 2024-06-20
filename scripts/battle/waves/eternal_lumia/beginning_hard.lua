local MyWave, super = Class(Wave)

function MyWave:init()
	super:init(self)
	
	self.arena_width = 80
	self.arena_height = self.arena_width
	
	self.time = 7.5
end

local function spawnBolt(self, x, y)
	return self:spawnBullet("eternal lumia/bolt", x, y)
end

local function randomWithStep(first, last, stepSize)
    local maxSteps = math.floor((last-first)/stepSize)
    return first + stepSize * math.random(0, maxSteps)
end

function MyWave:onStart()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setHeadAnimation("looks", nil, false)
	end

	self.timer:script(function(wait)
		local soul = Game.battle.soul

		local old_angle = 0
		local angle = 0
		local radius = 216

		local amount = 6
		local delay = 0.2
		
		wait(0.32)

		while true do
			for _ = 1, amount do
				-- Assets.playSound("l_thunder", .5, 2)

				angle = randomWithStep(0, 360, 90)

				while (angle == old_angle) do
					angle = randomWithStep(0, 360, 80)
				end

				old_angle = angle
				
				for _ = 1, 3 do
					local angle = math.rad(angle + math.random(-8, 8))
					local x = soul.x + (math.cos(angle) * radius) + math.random(-16, 16)
					local y = soul.y + (math.sin(angle) * radius) + math.random(-16, 16)

					local bolt = spawnBolt(self, x, y)
					-- bolt.sfx:stop()

					wait(0.1)
				end

				wait(delay)
			end

			wait(0.25)
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
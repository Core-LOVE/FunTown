local MyWave, super = Class(Wave)

function MyWave:init()
	super:init(self)
	
	self.arena_width = 80
	self.arena_height = self.arena_width
	self:setArenaOffset(-45, -5)

	self.time = 10
end

local function randomWithStep(first, last, stepSize)
    local maxSteps = math.floor((last-first)/stepSize)
    return first + stepSize * math.random(0, maxSteps)
end

local function boltSpawning(self)
	local heads = {}

	for k,enemy in ipairs(self:getAttackers()) do
		local head = enemy.sprite.parts['head']

		table.insert(heads, {x = enemy.x + head.x - 16, y = enemy.y + head.y - 56})
	end	

	self.timer:script(function(wait)
		local rotation = 22.5
		local side = 1

		while (true) do
			for k,head in ipairs(heads) do
				for i = 1, 2 do
					local x = head.x
					local y = head.y
					local rot = math.rad(180 + (rotation * side))

					self:spawnBullet("eternal lumia/dbolt", x, y, rot + math.rad(-22.5), 50, 275)
					self:spawnBullet("eternal lumia/dbolt", x, y, rot, 50, 275)
					self:spawnBullet("eternal lumia/dbolt", x, y, rot + math.rad(22.5), 50, 275)
					wait(0.05)
				end
			
				rotation = rotation - (22.5 / 2)

				if rotation < -90 then
					rotation = 22.5
				end

				-- side = -side

				wait(1.5)	
			end	
		end
	end)
end

function MyWave:onStart()
	Assets.playSound("l_film_1")
	
	local t = 0.6
	local y = 50

	for i = 1, 2 do
		local frames = Sprite("battle/eternal lumia/frame_ground", 0, y)
		frames:setRotationOriginExact(0, y)
		frames.rotation = math.rad(-90)
		frames.wrap_texture_x = true
		frames.physics.speed_x = (i == 2 and 6) or -6

		self.timer:tween(t, frames, {rotation = math.rad(0)}, 'in-bounce')
		self:addChild(frames)
		y = 275
	end

	self.timer:after(t - 0.1, function()
		for k,enemy in ipairs(self:getAttackers()) do
			enemy.sprite:setHeadAnimation("open_mouth", 0.08, false)
		end

		boltSpawning(self)
	end)
end

function MyWave:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setHeadAnimation("close_mouth", 0.08, false, function()
			enemy.sprite:setHeadAnimation()
		end)
	end
end

return MyWave
local MyWave, super = Class(Wave)

function MyWave:init()
	super:init(self)
	
	self.arena_width = 80
	self.arena_height = self.arena_width

	self.time = 7.5
end

local function randomWithStep(first, last, step)
    local maxSteps = math.floor((last-first)/step)
    return first + step * math.random(0, maxSteps)
end

local function spawnDiamond(self)
	local x = randomWithStep(32, 128, 32) + 16
	local y = SCREEN_HEIGHT - randomWithStep(32, 360, 32) - 32

	if math.random() > 0.5 then
		x = SCREEN_WIDTH - randomWithStep(32, 128, 32) - 16
	end

	local bullet = self:spawnBullet("eternal lumia/big_diamond", x, y)
end

function MyWave:onStart()
	spawnDiamond(self)

	self.timer:every(0.8, function()
		spawnDiamond(self)
	end)
	-- Assets.playSound("l_film_1")
	
	-- local t = 0.6
	-- local y = 272

	-- -- for i = 1, 2 do
	-- local frames = Sprite("battle/eternal lumia/frame_ground", 0, y)
	-- frames:setRotationOriginExact(0, y)
	-- frames.rotation = math.rad(-90)
	-- frames.wrap_texture_x = true
	-- frames.physics.speed_x = (i == 2 and 6) or -6

	-- self.timer:tween(t, frames, {rotation = math.rad(0)}, 'in-bounce')
	-- self:addChild(frames)
	-- -- 	y = 275
	-- -- end

	-- -- self.timer:after(t - 0.1, function()
	-- -- 	for k,enemy in ipairs(self:getAttackers()) do
	-- -- 		enemy.sprite:setHeadAnimation("open_mouth", 0.08, false)
	-- -- 	end

	-- -- 	boltSpawning(self)
	-- -- end)
end

return MyWave
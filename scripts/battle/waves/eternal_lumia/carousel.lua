local MyWave, super = Class(Wave)

local side
local accel
local min
local max
local absolute_min
local absolute_max
local t

function MyWave:onGameOver()
	self.sfx:stop()
	self.sfx:release()
	self.sfx = nil
end

function MyWave:init()
	super:init(self)
	
	side = 1
	accel = 0
	min = 4.15
	absolute_max = 6
	absolute_min = 3.9
	max = min
	t = 0

	self.arena_width = 160
	self.arena_height = self.arena_width * .5
	
	self.time = 7.5
	self.shouldDraw = false

	local sfx = Assets.playSound("l_carousel", 0.8)
	sfx:setLooping(true)
	sfx:stop()

	self.sfx = sfx
end

function MyWave:update()
	accel = accel + (0.8 * DTMULT) * side

	if accel > max then
		accel = max
	elseif accel < -max then
		accel = -max
	end

	t = t + accel

	if self.sfx then
		self.sfx:setPitch(math.abs(accel / min))
	end

	super.update(self)
end

function MyWave:onStart()
	self.sfx:play()
	self.shouldDraw = true

	self.timer:script(function(wait)
		while true do 
			local timer = 0.3 + (math.random() * 0.75)

			wait(timer)

			spawn = false
			side = -side
			max = math.random(absolute_min, absolute_max)
		end
	end)

	self.timer:script(function(wait)
		local arena = Game.battle.arena
		local soul = Game.battle.soul

		while true do
			wait((1 - (max / absolute_max) * .5) * .66)

			local x = (arena.x - self.arena_width * .5)
			local scale_x = 1
			local origin_x = 0

			if side == -1 then 
				x = (arena.x + self.arena_width * .5) + 25
				scale_x = -scale_x
				origin_x = 1
			end

			local bullet = self:spawnBullet('eternal lumia/cbolt', x, soul.y)
			bullet.scale_x = 0
			bullet.scale_y = 0.5
			bullet.physics.speed = 0
			bullet.color = {0.5, 0.5, 0.5}
			if side == -1 then bullet.rotation = bullet.rotation + math.rad(180) end
			bullet.scale_origin_x = 0

			local tm = Timer()
			local current_max = max

			tm:tween(1 - (max / absolute_max) * .5, bullet, {scale_x = scale_x, scale_y = 1, color = {1, 1, 1}}, 'in-sine', function()
				bullet.physics.speed = current_max * scale_x
				tm:tween(0.5, bullet, {scale_x = scale_x * 1.5})
			end)

			bullet:addChild(tm)
		end
	end)
end

-- function MyWave:onEnd()
-- 	for k,enemy in ipairs(self:getAttackers()) do
-- 		enemy.sprite:setHeadAnimation("normalize", 0.08, false, function()
-- 			enemy.sprite:setHeadAnimation()
-- 		end)
-- 	end
-- end

local function inOutSine(t, b, c, d)
	return -c / 2 * (math.cos(math.pi * t / d) - 1) + b
end

function MyWave:draw()
	if not self.shouldDraw then return super.draw(self) end

	for i = 0, 6 do
		love.graphics.push()

		local t = (t + (20 * i)) % self.arena_width

		local dx = inOutSine(t, 0, self.arena_width, self.arena_width)
		local middle = ((self.arena_width * .5) - dx)

		local arena = Game.battle.arena

		local x = arena.x + dx - (self.arena_width * .5)
		local y = arena.y - (self.arena_height * .5)
		local h = arena.y + (self.arena_height * .5)

		love.graphics.setColor(0, 0.75, 0, .5)

		local dy = math.abs(middle) * .5

		love.graphics.setLineWidth(2 + ((dy / 20) * 2))

		y = y + (dy * .25)
		h = h - (dy * .25)

		love.graphics.line(x, y, x, h)

		love.graphics.pop()
	end

	super.draw(self)
end

function MyWave:beforeEnd()
	self.sfx:stop()
	self.sfx:release()
end

return MyWave
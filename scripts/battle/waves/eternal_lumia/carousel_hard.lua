local MyWave, super = Class(Wave)

local function makeRoll(isVertical)
	local sfx = Assets.playSound("l_carousel", 0.4)
	sfx:setLooping(true)
	sfx:stop()

	local min = 3

	return {
		side = 1,
		accel = 0,
		min = min,
		absolute_max = 4,
		absolute_min = min,
		max = min,
		t = 0,	
		sfx = sfx,
		isVertical = isVertical
	}
end

function MyWave:onGameOver()
	for k,v in ipairs(self.rolls) do
		v.sfx:stop()
		v.sfx:release()
		v.sfx = nil
	end
end

function MyWave:init()
	super:init(self)
	
	self.rolls = {
		makeRoll(),
		makeRoll(true),	
	}

	self.arena_width = 160
	self.arena_height = self.arena_width
	self.roll_height = self.arena_width * .5

	self.time = 7.5
	self.shouldDraw = false

	local sfx = Assets.playSound("l_carousel", 0.8)
	sfx:setLooping(true)
	sfx:stop()

	self.sfx = sfx
end

function MyWave:update()
	for k,roll in ipairs(self.rolls) do
		local max = roll.max

		roll.accel = roll.accel + ((0.6 * DTMULT) * roll.side)

		local accel = roll.accel

		if accel > max then
			roll.accel = max
		elseif accel < -max then
			roll.accel = -max
		end

		roll.t = roll.t + roll.accel

		if roll.sfx then
			roll.sfx:setPitch(math.abs(roll.accel / roll.min))
		end
	end

	-- self.sfx:setPitch(math.abs(accel / min))

	super.update(self)
end

local function rollMoves(self, roll)
	local timer = Timer()

	local waitTimer = (roll.isVertical and 2.0) or 1.0

	timer:script(function(wait)
		while true do
			wait(waitTimer)

			roll.side = -roll.side

			local val = math.random(roll.absolute_min, roll.absolute_max)

			if roll.isVertical then
				val = self.rolls[1].max
			end

			roll.max = val
		end
	end)

	if roll.isVertical then
		timer:script(function(wait)
			local arena = Game.battle.arena
			local soul = Game.battle.soul

			while true do
				local w = (1 - (roll.max / roll.absolute_max) * .5) * .88
				wait(w)

				local y = (arena.y - self.arena_height * .5)
				local scale_y = 1
				local origin_y = 0

				if roll.side == -1 then 
					y = (arena.y + self.arena_height * .5) - 25
					scale_y = -scale_y
					origin_y = 1
				end

				local bullet = self:spawnBullet('eternal lumia/cbolt', soul.x, y)
				bullet.scale_x = 0
				bullet.scale_y = 0.5
				bullet.physics.speed = 0
				bullet.color = {0.5, 0.5, 0.5}
				bullet.rotation = math.rad(90)
				-- bullet.damage = 0
				-- if roll.side == -1 then bullet.rotation = bullet.rotation + math.rad(180) else bullet.rotation = bullet.rotation + math.rad(90) end

				bullet.scale_origin_x = origin_y

				local tm = Timer()
				local current_max = roll.max

				tm:tween(1 - (roll.max / roll.absolute_max) * .5, bullet, {scale_y = 1, scale_x = scale_y, color = {1, 1, 1}}, 'in-sine', function()
					bullet.physics.speed = current_max * scale_y
					tm:tween(0.65, bullet, {scale_x = scale_y * 1.5})
				end)

				bullet:addChild(tm)
			end
		end)
	else
		timer:script(function(wait)
			local arena = Game.battle.arena
			local soul = Game.battle.soul

			while true do
				local w = (1 - (roll.max / roll.absolute_max) * .25) * .88
				wait(w + 0.5)

				local x = (arena.x - self.arena_width * .5)
				local scale_x = 1
				local origin_x = 0

				if roll.side == -1 then 
					x = (arena.x + self.arena_width * .5) + 25
					scale_x = -scale_x
					origin_x = 1
				end

				local bullet = self:spawnBullet('eternal lumia/cbolt', x, soul.y)
				bullet.scale_x = 0
				bullet.scale_y = 0.5
				bullet.physics.speed = 0
				bullet.color = {0.5, 0.5, 0.5}
				-- bullet.damage = 0

				if roll.side == -1 then bullet.rotation = bullet.rotation + math.rad(180) end

				bullet.scale_origin_x = 0

				local tm = Timer()
				local current_max = roll.max

				tm:tween(1 - (roll.max / roll.absolute_max) * .5, bullet, {scale_x = scale_x, scale_y = 1, color = {1, 1, 1}}, 'in-sine', function()
					bullet.physics.speed = current_max * scale_x
					tm:tween(0.5, bullet, {scale_x = scale_x * 1.5})
				end)

				bullet:addChild(tm)
			end
		end)
	end

	self:addChild(timer)
end

function MyWave:onStart()
	-- self.sfx:play()
	self.shouldDraw = true

	for k,roll in ipairs(self.rolls) do
		rollMoves(self, roll)
		roll.sfx:play()
	end
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

	local arena = Game.battle.arena

	for k,roll in ipairs(self.rolls) do
		local t = roll.t
		local isVertical = roll.isVertical

		for i = 0, 6 do
			love.graphics.push()
			love.graphics.setColor(0, 0.75, 0, .25)

			local t = (t + (20 * i))

			if isVertical then
				t = t % self.arena_height
			else
				t = t % self.arena_width
			end

			local dx = inOutSine(t, 0, self.arena_width, self.arena_width)
			local middle = ((self.arena_width * .5) - dx)
			local dy = math.abs(middle) * .5

			local x = arena.x + dx - (self.arena_width * .5)
			local y = arena.y - (self.arena_height * .5) + (self.roll_height * .5)
			local h = arena.y + (self.roll_height * .5)

			if isVertical then
				dy = inOutSine(t, 0, self.arena_height, self.arena_height)
				middle = ((self.arena_height * .5) - dy)

				dx = math.abs(middle) * .5

				x = arena.x - (self.arena_width * .5) + (self.roll_height * .5)
				y = arena.y + dy - (self.arena_height * .5)
				local w = arena.x + (self.roll_height * .5)

				y = y + (dx * .25)
				w = w - (dx * .25)

				love.graphics.setLineWidth(2 + ((dx / 20) * 2))	
				love.graphics.line(x, y, w, y)
			else
				y = y + (dy * .25)
				h = h - (dy * .25)

				love.graphics.setLineWidth(2 + ((dy / 20) * 2))
				love.graphics.line(x, y, x, h)
			end

			-- love.graphics.setLineWidth(2 + ((dy / 20) * 2))

			-- y = y + (dy * .25)
			-- h = h - (dy * .25)

			love.graphics.pop()
		end
	end

	super.draw(self)
end

function MyWave:beforeEnd()
	for k,roll in ipairs(self.rolls) do
		roll.sfx:stop()
		roll.sfx:release()
	end
end

return MyWave
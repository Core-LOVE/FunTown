local MyWave, super = Class(Wave)

local DISTANCE = 160

function MyWave:init()
	super:init(self)
	
	self.arena_width = 80
	self.arena_height = self.arena_width
	self:setArenaOffset(0, 40)

	self.time = 6.4
end

local function spawnBolt(self, x)
	self:spawnBullet("eternal lumia/rocket", x, math.random(32, 320))
end

function MyWave:onStart()
	-- for k,enemy in ipairs(self:getAttackers()) do
	-- 	enemy.sprite:setHeadAnimation("looks", nil, false)
	-- end

	local t = {scale_x = 0.5, scale_y = 0.5}
	local style = 'out-quad'
	local wait = 0.5

	self.timer:script(function(wait)
		local arena = Game.battle.arena
		local soul = Game.battle.soul

		local xpos = {
			soul.x -  DISTANCE - 40,
			soul.x,		
			soul.x + DISTANCE + 40,
		}

		local ypos = {
			-15,
			480,
		}

		wait(0.5)

		local prev_y = y

		while true do
			-- local x = xpos[math.random(#xpos)]
			-- local y = ypos[math.random(#ypos)]

			-- if math.random() > 0.5 then
			-- 	while (y == prev_y) do
			-- 		y = ypos[math.random(#ypos)]
			-- 	end
			-- end

			-- prev_y = y

			-- local angle = math.rad(90)

			-- if y == ypos[2] then
			-- 	angle = math.rad(270)
			-- end

			for i = 1, 4 do
				local from = math.random(1, 3)
				local to = math.random(1, 3)
				local count = 1

				while (to < from) do
					to = math.random(1, 3)
				end

				if to == 3 then
					count = 2
				end

				Assets.playSound("l_thunder", .5, 2)

				local y = ypos[math.random(#ypos)]

				if math.random() > 0.75 then
					while (y == prev_y) do
						y = ypos[math.random(#ypos)]
					end
				end

				prev_y = y

				local angle = math.rad(90)

				if y == ypos[2] then
					angle = math.rad(270)
				end

				for dx = from, to, count do
					local bolt = self:spawnBullet("eternal lumia/bolt", xpos[dx], y, angle)
					bolt.physics.speed = 10
					bolt.sfx:stop()
					local realbolt = self:spawnBullet("eternal lumia/bolt", soul.x, y, angle, true)
					realbolt.physics.speed = bolt.physics.speed

					Utils.hook(realbolt, 'onRemove', function(orig, obj, ...)
						bolt:remove()
						bolt.sprite:remove()
						orig(obj, ...)	
					end)
				end

				wait(0.3)
			end

			wait(0.32)
		end
	end)
	-- self.timer:tween(wait, Game.battle.soul, t, style)
	-- self.timer:tween(wait, Game.battle.arena, t, style)
	-- self.timer:tween(wait, self, t, style)
end

function MyWave:draw()
	local soul = Game.battle.soul
	local arena = Game.battle.arena

	love.graphics.push()

	-- love.graphics.translate(640 )
		love.graphics.push()
		love.graphics.translate(arena.x + DISTANCE, arena.y - 40)

		arena:draw()

		love.graphics.translate(40, 40)
		soul:draw()
		love.graphics.pop()

		love.graphics.push()
		love.graphics.translate(arena.x - DISTANCE - 80, arena.y - 40)

		arena:draw()

		love.graphics.translate(40, 40)
		soul:draw()
		love.graphics.pop()

	love.graphics.pop()

	super.draw(self)
end

local function shards(self, arena, x, y)
	local effect = Rectangle(x + 40, y + 40, 80, 80)
	effect:setOrigin(.5, .5)

	local t = Timer()

	t:tween(0.25, effect, {alpha = 0, scale_x = 1.5, scale_y = 1.5}, nil, function()
		effect:remove()
	end)

	effect:addChild(t)
	Game.battle:addChild(effect, BATTLE_LAYERS.above_bullets)

	for dx = 0, 80, 16 do
		for dy = 0, 80, 16 do
			local effect = Sprite("effects/eternal lumia/shard", x + dx, y + dy)
			effect:setOrigin(.5, .5)
			effect:setScale(math.random(2))	
			effect.alpha = math.random() + .5
			effect.physics.gravity = math.random(1) * .25
			effect.physics.speed_y = -math.random(6, 9)
			effect.physics.speed_x = math.random(-3, 3)
			effect:play(2 / 30, true)

			local t = Timer()
			local timer = math.random(2) / 2

			t:after(timer, function()
				t:tween(0.32, effect, {alpha = 0}, nil, function()
					effect:remove()
				end)			
			end)

			effect:addChild(t)

			Game.battle:addChild(effect, BATTLE_LAYERS.above_bullets)
		end
	end
end

function MyWave:beforeEnd()
	Assets.playSound("l_shard", 1, 1)
	Assets.playSound("l_shard", 1, 0.8)
	Game.battle:shakeCamera(6, 6, .5)

	-- for k,enemy in ipairs(self:getAttackers()) do
	-- 	enemy.sprite:setHeadAnimation("normalize", 0.08, false, function()
	-- 		enemy.sprite:setHeadAnimation()
	-- 	end)
	-- end

	local arena = Game.battle.arena

	do
		local x = arena.x + DISTANCE
		local y = arena.y - 40

		shards(self, arena, x, y)
	end

	do
		local x = arena.x - DISTANCE - 80
		local y = arena.y - 40

		shards(self, arena, x, y)
	end
end

return MyWave
local MyWave, super = Class(Wave)

local head

function MyWave:spawnTrain(x, y)
	local soul = Game.battle.soul

	head = Sprite("battle/eternal lumia/train_head", x, y)
	head:setScale(2)
	head.saved = {}
	head.trail = {}

	head.physics.match_rotation = true
	head.rotation = math.rad(0)
	head.physics.speed = 29

	local head_light = Sprite("battle/eternal lumia/train_light", 0, 0)
	head_light.alpha = 0.1
	head:addChild(head_light)

	local delay = 0
	local t = 0

	Utils.hook(head, 'update', function(orig, head, ...)
		t = t + 1

		orig(head, ...)
		table.insert(head.saved, head.rotation)
	end)

	for i = 1, 9 do
		local body = Sprite("battle/eternal lumia/train_body", x - (192 * i), y)
		body:setScale(2)
		body.physics.match_rotation = head.physics.match_rotation
		body.rotation = head.rotation
		body.physics.speed = head.physics.speed

		Utils.hook(body, 'update', function(orig, body, ...)
			local delay = head.physics.speed * .25

			-- if head.physics.speed == 8 then
			-- 	delay = 21
			-- end

			body.physics.speed = head.physics.speed
			local saved = head.saved[t - math.floor(delay * i)]

			if saved then
				body.rotation = saved
			end

			orig(body, ...)
		end)

		Game.battle:addChild(body)
		table.insert(head.trail, body)
		body:setLayer(BATTLE_LAYERS.below_soul)
	end

	self.timer:tween(0.5, head_light, {alpha = 1})

	self.timer:after(1.2, function()
		self.timer:script(function(wait)
			local soul = Game.battle.soul
			local distance = 256

			while true do
				wait(0.32)

				for i = 0, 4 do
					local rotation = soul.rotation

					local x, y = math.cos(rotation) * distance, math.sin(rotation) * distance

					local bullet = self:spawnBullet("eternal lumia/bolt", soul.x + x, soul.y + y, nil, nil, true)
					bullet.physics.speed = bullet.physics.speed * .05
					bullet.damage = 0

					wait(0.25)
				end
			end
		end)

		self.timer:tween(2, head, {rotation = math.rad(45)}, 'in-sine', function()
			self.timer:tween(4, head, {rotation = math.rad(-60)}, 'in-sine', function()

			end)
		end)
	end)

	self.timer:after(0.45, function()
		Assets.playSound("locker")

		Game.battle:shakeCamera(8, 8)
		Game.battle.camera.target = soul

		self.timer:tween(0.5, soul, {rotation = math.rad(359)}, nil, function()
			soul.rotation = math.rad(0)
			
			self.timer:tween(0.5, soul, {rotation = math.rad(359)}, nil, function()
				soul.rotation = math.rad(0)
			end)
		end)

		self.timer:tween(0.5, soul, {y = soul.y - 256}, 'in-sine', function()
			self.timer:tween(0.5, soul, {y = soul.y + 148}, 'in-sine', function()
				local follow = head

		        Object.startCache()
		        for k,body in ipairs(head.trail) do
		           	if soul.x >= body.x and soul.x <= body.x + 192 then
		           		follow = body
		           		break
		           	end
		        end
		        Object.endCache()

		        for k,body in ipairs(head.trail) do
		        	body:shake(math.random(-2, 2), math.random(-2, 2), 1 / 15)
		        end

				Utils.hook(soul, 'update', function(orig, soul, ...)
					local rot = follow.rotation

					local x, y = follow:getRelativePos(0, -15, self)

					soul.x = x
					soul.y = y
					soul.rotation = rot

					soul.shield.additional_distance = head.physics.speed

					orig(soul, ...)
				end)

				Assets.playSound("locker")
				-- head.physics.speed = 8
				Game.battle:shakeCamera(16, 16)
			end)		
		end)
	end)

	Game.battle:addChild(head)
	head:setLayer(BATTLE_LAYERS.below_soul)
end

function MyWave:init()
	super:init(self)
	
	self.arena_width = 80
	self.arena_height = self.arena_width
	
	self.time = -1

	Assets.playSound("snd_trainhonk")
end

function MyWave:onStart()
	local fader = Rectangle(-32, -32, SCREEN_WIDTH + 32, SCREEN_HEIGHT + 32)
	fader.color = {0, 0, 0}
	fader.parallax_x = 0
    fader.parallax_y = 0
    fader.alpha = 0
    fader.layer = BATTLE_LAYERS.above_arena - 50

    Game.battle:addChild(fader)

    local tension_bar = Game.battle.tension_bar
    tension_bar:setLayer(BATTLE_LAYERS.above_arena + 1)
	tension_bar.parallax_x = 0
    tension_bar.parallax_y = 0

	self.timer:tween(0.75, fader, {alpha = 1}, 'out-cubic')

	self.timer:tween(1, self, {arena_width = 650, arena_height = 650}, 'out-cubic')
	self.timer:script(function(wait)
		self:spawnTrain(-192, 96)

		while true do
			self:setArenaSize(self.arena_width, self.arena_height)
			wait()
		end
	end)

	self.timer:after(0.2, function()
		local w, h = SCREEN_WIDTH, SCREEN_HEIGHT

		self.timer:every(1.35, function()
			local curve = love.math.newBezierCurve{
				-96, math.random(0, h),
				w / 4, math.random(0, h / 4),
				w / 2, math.random(h / 2, h),
				w * .75, math.random(h / 4, h * .75),	
				w, h / 2,
			}
			local derivative = curve:getDerivative()

			self.timer:script(function(wait)
				local texture = "battle/eternal lumia/train_head"
				local scale = math.random(1, 2) / 4

				for i = 1, math.random(4, 8) do
					local obj = Sprite((i == 1 and "battle/eternal lumia/train_head") or "battle/eternal lumia/train_body", -96, 0)
					obj.parallax_x = 0
					obj.parallax_y = 0
					obj.layer = BATTLE_LAYERS.above_arena - (math.random(1, 9))
					obj:setScale(scale)
					obj:setColor(scale, scale, scale)

					if (i == 1) then
						local head_light = Sprite("battle/eternal lumia/train_light", 0, 0)
						head_light.alpha = 0.5
						obj:addChild(head_light)
					end

					local t = 0
					local speed = 0.01

					Utils.hook(obj, 'update', function(old, self, ...)
						t = t + speed

						if (t >= 1) then return self:remove() end

						local ex,ey = curve:evaluate(t)
						local dx,dy = derivative:evaluate(t)

						self.x = ex
						self.y = ey
						self.rotation = (math.atan2(dy,dx)+math.pi/2) - math.rad(90)

						old(self, ...)
					end)

					Game.battle:addChild(obj)
					wait(scale / 3.5)
				end
			end)
		end)
	end)
end

function MyWave:update()
	if head and math.random() > 0.8 then
		local effect = Sprite("effects/wind", SCREEN_WIDTH, math.random(SCREEN_HEIGHT))
		effect.scale_x = math.random(100, 175) / 100

		effect.physics.match_rotation = true
		effect.rotation = head.rotation
		effect.physics.speed = -(effect.scale_x * 2) * 1.5

		effect.layer = BATTLE_LAYERS["above_arena"]
		effect.alpha = math.random(1, 4) * .5
		effect.parallax_x = 0
	    effect.parallax_y = 0
	    effect:setColor(76 / 255, 133 / 255, 186 / 255)

	    local t = Timer()

		t:tween(.4, effect, {alpha = 0, x = 0, scale_x = 0.25}, 'in-out-sine', function()
			effect:remove()
		end)

		effect:addChild(t)
		Game.battle:addChild(effect)
	end

	super.update(self)
end

return MyWave
local MyWave, super = Class(Wave)

local SoulFlash = Class(Sprite)

function SoulFlash:init(parent, count, alpha)
    Sprite.init(self, "player/heart_dodge", 0, 0)
    
    self.color = parent.color
    
    self:setParallax(0)
    self:setOrigin(.5)
    
    self.count = count
    self.countAlpha = alpha
    
    parent:addChild(self)
end

function SoulFlash:update()
    self:setScale(self.scale_x + self.count)
    self.alpha = self.alpha - self.countAlpha
    
    if self.alpha < 0 then
        self:remove()
    end
end

function MyWave:init()
	super.init(self)
	
	self.arena_width = 160
	self.arena_height = self.arena_width
	
	self.time = 7.5
end

function MyWave:birds()
	local soul = Game.battle.soul

	local side = 1

	self.timer:every(0.75 / 2, function()
		Assets.playSound("chirp", 0.5, 1.5)
	end)

	self.timer:every(0.75, function()
		local dx, dy = soul.x, soul.y

		Assets.playSound("swipe", 0.5, 1.5)

		local bird = self:spawnBullet("eternal lumia/bigbird", soul.x, 0)
		bird.birds = {}

		local sx = 12 * side

		for i = 1, 3 do
			local saved_x = sx
			local smallbird = self:spawnBullet("lumia/bird", soul.x + sx, 0)

			smallbird.movement = function(smallbird)
				if bird then
					smallbird.rotation = bird.rotation
				else
					local rot = Utils.angle(bird, soul)	

					smallbird.physics.direction = rot
					smallbird.physics.speed = 4.5
				end
			end

			bird.timer:tween(0.5 + (i / 6), smallbird, {x = dx + saved_x, y = dy - 9}, 'out-sine')

			sx = sx + (14 * side)
			table.insert(bird.birds, smallbird)
		end

		side = -side

		bird.timer:after(0.45, function()
			local rot = Utils.angle(bird, soul)
			print(math.deg(rot))

			bird.timer:tween(0.5, bird, {rotation = rot}, 'out-cubic', function()
				bird.physics.direction = rot
				bird.physics.speed = 4
				bird.physics.friction = -0.25

				local fr = 0

				for k,v in ipairs(bird.birds) do
					v.physics.direction = bird.physics.direction
					v.physics.speed = 3.5
					v.physics.friction = -(0.24 - fr)

					fr = fr - 0.05
				end
			end)
		end)

		bird.timer:tween(0.5, bird, {x = dx, y = dy}, 'out-sine', function()

		end)
	end)
end

function MyWave:onStart()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setHeadAnimation("looks", nil, false)
	end
	
	local t = 1
	local y = 272

	Assets.playSound("l_film_1")

	local frames = Sprite("battle/eternal lumia/frame_ground", 0, y)
	frames.rotation = math.rad(-125)
	frames:setScale(2)
	frames:setColor(1, 0, 0)

	self.timer:tween(t, frames, {rotation = math.rad(90)}, 'out-back')

	self.timer:after(t - 0.25, function()
		frames:remove()
		self:birds()
	end)

	self.timer:after(t * .15, function()
		local soul = Game.battle.soul
		local x, y = soul.x, soul.y

		soul:remove()

		Game.battle.soul = Soul(x, y, {1, 0, 0})

		local soul = Game.battle.soul

		Game.battle:addChild(soul)

	    SoulFlash(soul, 0.1, 0.075)
	    SoulFlash(soul, 0.25, 0.05)
	end)

	self.timer:every(0.1, function()
		local effect = Sprite("battle/eternal lumia/frame_ground", 0, 0)
		effect.rotation = math.rad(-10)
		effect.inherit_color = true
		effect.alpha = 0.5

		self.timer:tween(0.2, effect, {alpha = 0})

		frames:addChild(effect)
	end)

	self:addChild(frames)
end

function MyWave:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setHeadAnimation("normalize", 0.08, false, function()
			enemy.sprite:setHeadAnimation()
		end)
	end
end

return MyWave
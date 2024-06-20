local MyObject, super = Class(Bullet)

function MyObject:init(x, y, texture)
	super.init(self, x, y, texture)
	self.ignore = true
	self.tp = 2.0
end

local function firework(self)
	Assets.playSound("l_explosion", .5, 1)

	local circle = Ellipse(self.x, self.y, 15)
	circle:setOrigin(.5)
	
	local t = Timer()

	t:tween(0.25, circle, {alpha = 0, width = circle.width * 2, height = circle.height * 2}, nil, function()
		circle:remove()
	end)
	
	circle:addChild(t)
	circle:setLayer(self.layer + 1)
	
	Game.battle:addChild(circle)

	local circle = Ellipse(self.x + math.random(-24, 24), self.y + math.random(-24, 24), 24)
	circle:setOrigin(.5)
	circle:setColor(1, 0, 0)
	circle.alpha = 0.25
	local t = Timer()

	t:tween(0.75, circle, {alpha = 0, width = circle.width * 4, height = circle.height * 4}, nil, function()
		circle:remove()
	end)

	t:tween(0.5 / 2, circle, {color = {0, 1, 0}}, nil, function()
		t:tween(0.5 / 2, circle, {color = {0, 0, 1}}, nil, function()
			t:tween(0.5 / 2, circle, {color = {0, 0.5, 1}}, nil, function()

			end)
		end)
	end)
	
	circle:addChild(t)
	circle:setLayer(self.layer + 1)
	
	Game.battle:addChild(circle)

	for i = 1, 9 do
		local dx, dy = math.random(-8, 8), math.random(-8, 8)

		local effect = Sprite("effects/eternal lumia/firework", self.x + dx, self.y + dy)
		effect:setOrigin(.5, .5)
		effect:setScale(1.5)	
		effect.alpha = 1
		effect:play(2 / 30, false, function()
			effect:remove()
		end)

		Utils.hook(effect, 'update', function(orig, obj)
			orig(obj)
			obj.color = circle.color
		end)

		effect.physics.speed_x = dx * .5
		effect.physics.speed_y = dy * .5

		effect.graphics.spin = math.random() / 20

		Game.battle.waves[1]:addChild(effect, BATTLE_LAYERS.above_bullets)
	end
end

function MyObject:_onCollide(soul)
	local shield = soul.shield

	-- local fl = flash(shield)

	-- local t = Timer()
	-- t:tween(0.25, shield, {rotation = shield.rotation + math.rad(180)}, 'out-quad')

	-- soul.sprite:shake(math.random(4), math.random(4), .5, 2/30)
	-- shield.sprite:shake(math.random(2), math.random(2))

	-- soul:addChild(t)

	firework(self)

	local flash = FlashFade(soul.sprite, soul.x, soul.y)
	flash:setOrigin(0.5, 0.5)
	flash:setScale(self:getScale())
	soul:addChild(flash)
end

function MyObject:onCollide(soul, no_hurt)
	self:_onCollide(soul, no_hurt)
	
	if not no_hurt then
		super.onCollide(self, soul)
	else
		self.damage = 0
		self:remove()
	end
end

return MyObject
local id = "eternal lumia/rocket"
local MyBullet, super = Class(PhantomBullet, id)

local function appear(self)
	Assets.playSound("l_firework", .25, .5)
	Assets.playSound("l_explosion", .4, 2)

	-- local circle = Ellipse(self.x, self.y, 15)
	-- circle:setOrigin(.5)
	
	-- local t = Timer()

	-- t:tween(0.5, circle, {alpha = 0, width = circle.width * 2, height = circle.height * 2}, nil, function()
	-- 	circle:remove()
	-- end)
	
	-- circle:addChild(t)
	-- circle:setLayer(self.layer + 1)
	
	-- Game.battle:addChild(circle)
end

function MyBullet:init(x, y, rot)
    super:init(self, x, 470)

	local soul = Game.battle.soul
	
    self:setSprite("bullets/" .. id, 4 / 60, true)
	
	-- self:setScale(1)
    self:setHitbox(6, 3, 12, 6)
	
	self.physics.match_rotation = true
	self.rotation = (rot ~= nil and rot) or math.atan2(soul.y - self.y, soul.x - self.x)
	
	-- self.physics.speed = 7.5

	local dx = math.random(160, 280)

	if x >= 320 then
		dx = -dx
	end

	self.curve = love.math.newBezierCurve(
		self.x, self.y,
		self.x - dx, math.random(-80, -240),
		soul.x, soul.y
	)

	self.curveTimer = 0

	self.trail = RibbonTrail(self.x + 8, self.y + 8)
	self.trail.alpha = 0.5
	-- self.trail.parent = self
	self.trail.interval = 0.1
	self:addChild(self.trail)

	self.timer = Timer()
	self.timer:every(0.15, function()
		-- local x, y = self:getRelativePos(-8, -8, Game.battle)
		local circle = Ellipse(self.x + math.random(-8, 8), self.y + math.random(-8, 8), 8)
		circle.rotation = self.rotation
		circle.physics.match_rotation = true
		circle.physics.speed = -math.random(1, 4)
		circle:setOrigin(.5)

		local t = Timer()

		t:tween(0.5, circle, {alpha = 0, width = 0, height = 0}, nil, function()
			circle:remove()
		end)
		
		circle:addChild(t)
		Game.battle:addChild(circle)
	end)

	self:addChild(self.timer)
	-- self.damage = 0
	-- self.ignore = true
	-- self.tp = 2.0

	appear(self)
end

function MyBullet:update()
	self.curveTimer = self.curveTimer + 0.02

	local time     = self.curveTimer
	local t        = time

	if t > 1 then
		t = 1
	end 

	local x, y     = self.curve:evaluate(t)

	self.x, self.y = x, y

	self.trail.x = x + 8
	self.trail.y = y + 8

	local future = t + 0.02
	
	if future > 1 then future = 1 end

	local nx, ny = self.curve:evaluate(future)

	self.rotation = Utils.angle(x, y, nx, ny)
	
	super.update(self)
end

-- local function firework(self)
-- 	Assets.playSound("l_explosion", .5, 1)

-- 	local circle = Ellipse(self.x, self.y, 15)
-- 	circle:setOrigin(.5)
	
-- 	local t = Timer()

-- 	t:tween(0.25, circle, {alpha = 0, width = circle.width * 2, height = circle.height * 2}, nil, function()
-- 		circle:remove()
-- 	end)
	
-- 	circle:addChild(t)
-- 	circle:setLayer(self.layer + 1)
	
-- 	Game.battle:addChild(circle)

-- 	local circle = Ellipse(self.x + math.random(-24, 24), self.y + math.random(-24, 24), 24)
-- 	circle:setOrigin(.5)
-- 	circle:setColor(1, 0, 0)
-- 	circle.alpha = 0.25
-- 	local t = Timer()

-- 	t:tween(0.75, circle, {alpha = 0, width = circle.width * 4, height = circle.height * 4}, nil, function()
-- 		circle:remove()
-- 	end)

-- 	t:tween(0.5 / 2, circle, {color = {0, 1, 0}}, nil, function()
-- 		t:tween(0.5 / 2, circle, {color = {0, 0, 1}}, nil, function()
-- 			t:tween(0.5 / 2, circle, {color = {0, 0.5, 1}}, nil, function()

-- 			end)
-- 		end)
-- 	end)
	
-- 	circle:addChild(t)
-- 	circle:setLayer(self.layer + 1)
	
-- 	Game.battle:addChild(circle)

-- 	for i = 1, 9 do
-- 		local dx, dy = math.random(-8, 8), math.random(-8, 8)

-- 		local effect = Sprite("effects/eternal lumia/firework", self.x + dx, self.y + dy)
-- 		effect:setOrigin(.5, .5)
-- 		effect:setScale(1.5)	
-- 		effect.alpha = 1
-- 		effect:play(2 / 30, false, function()
-- 			effect:remove()
-- 		end)

-- 		Utils.hook(effect, 'update', function(orig, obj)
-- 			orig(obj)
-- 			obj.color = circle.color
-- 		end)

-- 		effect.physics.speed_x = dx * .5
-- 		effect.physics.speed_y = dy * .5

-- 		effect.graphics.spin = math.random() / 20

-- 		Game.battle.waves[1]:addChild(effect, BATTLE_LAYERS.above_bullets)
-- 	end
-- end

-- function MyBullet:_onCollide(soul)
-- 	local shield = soul.shield

-- 	-- local fl = flash(shield)

-- 	-- local t = Timer()
-- 	-- t:tween(0.25, shield, {rotation = shield.rotation + math.rad(180)}, 'out-quad')

-- 	-- soul.sprite:shake(math.random(4), math.random(4), .5, 2/30)
-- 	-- shield.sprite:shake(math.random(2), math.random(2))

-- 	-- soul:addChild(t)

-- 	firework(self)

-- 	local flash = FlashFade(soul.sprite, soul.x, soul.y)
-- 	flash:setOrigin(0.5, 0.5)
-- 	flash:setScale(self:getScale())
-- 	soul:addChild(flash)
-- end

-- function MyBullet:onCollide(soul, no_hurt)
-- 	self:_onCollide(soul, no_hurt)
	
-- 	if not no_hurt then
-- 		super.onCollide(self, soul)
-- 	else
-- 		self.damage = 0
-- 		self:remove()
-- 	end
-- end

return MyBullet